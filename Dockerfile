# --- Stage 1: Build the Maven application ---
FROM maven:3.8.5-openjdk-17-slim AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# --- Stage 2: Run Tomcat and MariaDB ---
FROM tomcat:9.0-jdk17-openjdk-slim

# Disable Tomcat shutdown port to force Render to route to port 8080
RUN sed -i 's/port="8005"/port="-1"/' /usr/local/tomcat/conf/server.xml

# Install MariaDB server and client
RUN apt-get update && \
    apt-get install -y mariadb-server mariadb-client && \
    rm -rf /var/lib/apt/lists/*

# Set up working directories and copy assets
WORKDIR /app
COPY database_schema.sql .
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

# Deploy the WAR to Tomcat (rename to ROOT.war to serve on "/")
COPY --from=build /app/target/RestaurantReservation-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Expose HTTP port
EXPOSE 8080

# Run entrypoint script
ENTRYPOINT ["/app/entrypoint.sh"]
