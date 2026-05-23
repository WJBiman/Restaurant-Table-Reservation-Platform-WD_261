#!/bin/bash
set -e

# Ensure correct permissions for MariaDB directories
mkdir -p /var/run/mysqld
chown -R mysql:mysql /var/run/mysqld
chown -R mysql:mysql /var/lib/mysql

# Initialize MariaDB directory if empty
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

echo "Starting MariaDB..."
mysqld_safe --user=mysql --datadir=/var/lib/mysql --port=3306 &

# Wait for MariaDB to start up
echo "Waiting for MariaDB to start..."
until mysqladmin ping >/dev/null 2>&1; do
    sleep 1
done

echo "Configuring database..."
mysql -u root -e "CREATE DATABASE IF NOT EXISTS bloom_db;"
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '';"
mysql -u root -e "FLUSH PRIVILEGES;"

echo "Importing database schema..."
if [ -f "/app/database_schema.sql" ]; then
    mysql -u root bloom_db < /app/database_schema.sql
    echo "Database schema imported successfully."
else
    echo "database_schema.sql not found at /app/database_schema.sql"
fi

echo "Starting Tomcat..."
export JAVA_OPTS="-Xms128m -Xmx256m -XX:MaxMetaspaceSize=128m"
exec catalina.sh run
