CREATE DATABASE IF NOT EXISTS bloom_db;
USE bloom_db;

-- 1. Users Table (Customers and Admins)
CREATE TABLE IF NOT EXISTS users (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    role VARCHAR(20) NOT NULL
);

-- 2. Restaurant Tables (Physical dining spaces)
CREATE TABLE IF NOT EXISTS restaurant_tables (
    table_id VARCHAR(50) PRIMARY KEY,
    capacity INT NOT NULL,
    availability_status VARCHAR(50) NOT NULL,
    location VARCHAR(50) NOT NULL DEFAULT 'Main Hall'
);

-- 3. Active Reservations
CREATE TABLE IF NOT EXISTS reservations (
    reservation_id VARCHAR(50) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    reservation_date VARCHAR(20) NOT NULL,
    reservation_time VARCHAR(20) NOT NULL,
    guest_count INT NOT NULL,
    table_number VARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL,
    submission_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (table_number) REFERENCES restaurant_tables(table_id)
);

-- 4. Completed Reservations (Archive)
CREATE TABLE IF NOT EXISTS completed_reservations (
    reservation_id VARCHAR(50) PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    reservation_date VARCHAR(20) NOT NULL,
    reservation_time VARCHAR(20) NOT NULL,
    guest_count INT NOT NULL,
    table_number VARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL,
    submission_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT IGNORE INTO users (id, name, phone, email, username, password, role) 
VALUES ('USR-ADMIN01', 'System Admin', '0000000000', 'admin@bloom.com', 'admin', 'admin123', 'Admin');

INSERT IGNORE INTO restaurant_tables (table_id, capacity, availability_status, location) VALUES
('T01', 2, 'Available', 'Window Side'),
('T02', 2, 'Available', 'Window Side'),
('T03', 4, 'Available', 'Main Hall'),
('T04', 4, 'Available', 'Main Hall'),
('T05', 6, 'Available', 'Main Hall'),
('T06', 6, 'Available', 'Main Hall'),
('T07', 8, 'Available', 'Private Terrace'),
('T08', 12, 'Available', 'Private Terrace');
