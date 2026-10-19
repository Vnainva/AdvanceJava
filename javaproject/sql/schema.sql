-- ==========================================================
-- CineBook – Movie Ticket Booking System
-- Database Schema and Sample Data
-- Target Database: MySQL 8.x
-- ==========================================================

CREATE DATABASE IF NOT EXISTS cinebook_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE cinebook_db;

-- 1. Users Table (Customers and Admins)
DROP TABLE IF EXISTS booked_seats;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS showtimes;
DROP TABLE IF EXISTS theatres;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    role ENUM('CUSTOMER', 'ADMIN') DEFAULT 'CUSTOMER',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 2. Movies Table
CREATE TABLE movies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    genre VARCHAR(60) NOT NULL,
    duration_mins INT NOT NULL,
    language VARCHAR(40) NOT NULL,
    description TEXT,
    poster_url VARCHAR(500),
    release_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 3. Theatres Table
CREATE TABLE theatres (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    city VARCHAR(80) NOT NULL,
    address VARCHAR(255) NOT NULL
) ENGINE=InnoDB;

-- 4. Showtimes Table
CREATE TABLE showtimes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    movie_id INT NOT NULL,
    theatre_id INT NOT NULL,
    show_date DATE NOT NULL,
    show_time VARCHAR(20) NOT NULL,
    ticket_price DECIMAL(10, 2) NOT NULL,
    total_seats INT NOT NULL DEFAULT 40,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE,
    FOREIGN KEY (theatre_id) REFERENCES theatres(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 5. Bookings Table
CREATE TABLE bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    booking_ref VARCHAR(36) NOT NULL UNIQUE,
    user_id INT NOT NULL,
    showtime_id INT NOT NULL,
    seats VARCHAR(255) NOT NULL,
    seat_count INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    payment_status ENUM('SUCCESS', 'FAILED') DEFAULT 'SUCCESS',
    payment_mode VARCHAR(40) NOT NULL,
    booking_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (showtime_id) REFERENCES showtimes(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 6. Booked Seats Table (Guarantees seat uniqueness & validates availability)
CREATE TABLE booked_seats (
    id INT AUTO_INCREMENT PRIMARY KEY,
    showtime_id INT NOT NULL,
    seat_number VARCHAR(10) NOT NULL,
    booking_id INT NOT NULL,
    UNIQUE KEY uq_showtime_seat (showtime_id, seat_number),
    FOREIGN KEY (showtime_id) REFERENCES showtimes(id) ON DELETE CASCADE,
    FOREIGN KEY (booking_id) REFERENCES bookings(id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ==========================================================
-- Sample Seed Data
-- Passwords in this demo are stored as plain or SHA-256 for simplicity
-- Default Admin: admin@cinebook.com / admin123
-- Default Customer: john@example.com / password123
-- ==========================================================

INSERT INTO users (name, email, password, phone, role) VALUES
('System Administrator', 'admin@cinebook.com', 'admin123', '9876543210', 'ADMIN'),
('John Doe', 'john@example.com', 'password123', '9123456780', 'CUSTOMER'),
('Sarah Connor', 'sarah@example.com', 'password123', '9123456781', 'CUSTOMER');

INSERT INTO movies (title, genre, duration_mins, language, description, poster_url, release_date) VALUES
('Oppenheimer', 'Biography / Drama / History', 180, 'English', 
 'The story of American scientist J. Robert Oppenheimer and his role in the development of the atomic bomb.', 
 'https://images.unsplash.com/photo-1534447677768-be436bb09401?w=800&auto=format&fit=crop&q=60', '2023-07-21'),

('Interstellar', 'Sci-Fi / Adventure', 169, 'English', 
 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity survival.', 
 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800&auto=format&fit=crop&q=60', '2014-11-07'),

('Inception', 'Sci-Fi / Action', 148, 'English', 
 'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea.', 
 'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=800&auto=format&fit=crop&q=60', '2010-07-16'),

('The Dark Knight', 'Action / Crime / Drama', 152, 'English', 
 'When the menace known as the Joker wreaks havoc on Gotham, Batman must accept one of the greatest psychological and physical tests.', 
 'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?w=800&auto=format&fit=crop&q=60', '2008-07-18');

INSERT INTO theatres (name, city, address) VALUES
('PVR Grand Cineplex', 'Mumbai', 'Phoenix Mall, Lower Parel'),
('IMAX Luxe Cinema', 'Bengaluru', 'Forum South, Koramangala');

-- Showtimes for today / tomorrow
INSERT INTO showtimes (movie_id, theatre_id, show_date, show_time, ticket_price, total_seats) VALUES
(1, 1, CURDATE(), '10:30 AM', 250.00, 40),
(1, 1, CURDATE(), '02:45 PM', 280.00, 40),
(1, 2, CURDATE(), '06:15 PM', 350.00, 40),
(2, 1, CURDATE(), '01:00 PM', 220.00, 40),
(2, 2, CURDATE(), '07:30 PM', 320.00, 40),
(3, 1, CURDATE(), '04:00 PM', 240.00, 40),
(4, 2, CURDATE(), '09:00 PM', 300.00, 40);

-- One initial sample booking for testing seat conflicts
INSERT INTO bookings (booking_ref, user_id, showtime_id, seats, seat_count, total_amount, payment_status, payment_mode, booking_time) VALUES
('CBK-20261019-001', 2, 1, 'B3, B4', 2, 500.00, 'SUCCESS', 'UPI', NOW());

INSERT INTO booked_seats (showtime_id, seat_number, booking_id) VALUES
(1, 'B3', 1),
(1, 'B4', 1);
