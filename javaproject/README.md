# 🎬 CineBook – Movie Ticket Booking System

![Java 17](https://img.shields.io/badge/Java-17%2B-orange?logo=openjdk)
![Tomcat 11](https://img.shields.io/badge/Apache_Tomcat-11.x-yellow?logo=apachetomcat)
![Jakarta EE 10](https://img.shields.io/badge/Jakarta_EE-10-blue)
![MySQL 8](https://img.shields.io/badge/MySQL-8.x-00758F?logo=mysql&logoColor=white)
![Maven](https://img.shields.io/badge/Build-Maven-C71A36?logo=apachemaven)
![Bootstrap 5](https://img.shields.io/badge/UI-Bootstrap_5-7952B3?logo=bootstrap&logoColor=white)
![Architecture](https://img.shields.io/badge/Architecture-MVC-green)

A complete, production-ready Advanced Java web application developed using **MVC Architecture** (`JSP → Servlet → Service → DAO → JDBC → MySQL`), specifically tailored for **Apache Tomcat 11** and **Jakarta EE 10**.

---

## 📑 Table of Contents

- [Overview & Architecture](#-overview--architecture)
- [Key Features](#-key-features)
- [Project Directory Structure](#-project-directory-structure)
- [Database Schema (MySQL)](#-database-schema-mysql)
- [Getting Started & Installation](#-getting-started--installation)
- [Default Login Credentials](#-default-login-credentials)
- [Advanced Java Demos (Standalone)](#-advanced-java-demos-standalone)
  - [1. Swing GUI Box Office Counter](#1-swing-gui-box-office-counter)
  - [2. Multi-threaded TCP Sockets](#2-multi-threaded-tcp-sockets)
  - [3. Java RMI (Remote Method Invocation)](#3-java-rmi-remote-method-invocation)
  - [4. Object Serialization & Transient Fields](#4-object-serialization--transient-fields)
  - [5. Internationalization (i18n & l10n)](#5-internationalization-i18n--l10n)
  - [6. Filters & Listeners](#6-filters--listeners)
- [Seat Concurrency Validation](#-seat-concurrency-validation)

---

## 🏛️ Overview & Architecture

CineBook strictly follows the Enterprise **MVC (Model-View-Controller)** pattern with a distinct multi-tier separation of concerns:

```
+---------------------------------------------------------------+
|                      Presentation Tier (View)                 |
|       JSP Pages (JSTL 3.0, Expression Language, Bootstrap 5)  |
+------------------------------+--------------------------------+
                               | (HTTP Request / Form POST)
                               v
+---------------------------------------------------------------+
|                      Controller Tier                          |
|   Jakarta Servlets (AuthServlet, MovieServlet, BookingServlet)|
+------------------------------+--------------------------------+
                               | (Service Invocations)
                               v
+---------------------------------------------------------------+
|                    Business Logic Tier                        |
|       Services (UserService, MovieService, BookingService)    |
+------------------------------+--------------------------------+
                               | (Data Access Objects)
                               v
+---------------------------------------------------------------+
|                   Data Access Layer (DAO)                     |
|           JDBC PreparedStatements, Transactions, DBUtil       |
+------------------------------+--------------------------------+
                               | (SQL Connection)
                               v
+---------------------------------------------------------------+
|                    Database Tier (MySQL 8)                    |
|       cinebook_db (InnoDB, Foreign Keys, Unique Locks)        |
+---------------------------------------------------------------+
```

---

## ✨ Key Features

### 👤 Customer Experience
* **User Authentication**: Secure registration, login with session tracking, and graceful logout.
* **Movie Discovery**: Real-time catalog with dynamic genre tags, runtime formatting, and full-text keyword search.
* **Theatre & Showtime Explorer**: Browse cinemas across cities with date/time pickers and real-time seat availability tallies.
* **Interactive Cinema Seat Map**: Visual screen orientation with interactive row-column seat grid (Rows A–D, Seats 1–10).
* **Simulated Payment Gateway**: Instant transaction processing with options for Credit/Debit Cards, UPI, or NetBanking.
* **Digital Tickets & Confirmation**: Printable receipt with unique reference code (`CBK-XXXXXX`), QR-ready details, and full booking history.

### 🛡️ Administrator Operations
* **System Control Center**: Live metrics dashboard tracking total movies, scheduled showtimes, customer bookings, and gross revenue.
* **Movie Catalog Management**: Full CRUD capabilities (create, read, update, delete movies).
* **Showtime Scheduler**: Assign films to cinemas with custom date, time, pricing, and hall capacity limits.
* **Live Booking Audit Trail**: Complete audit ledger of all customer reservations across the platform.

---

## 📂 Project Directory Structure

```
cinebook/
├── pom.xml                                           # Maven dependencies (Jakarta EE 10 / Tomcat 11 / MySQL)
├── README.md                                         # Project documentation
├── .gitignore                                        # Git ignore rules for Maven & IDEs
├── sql/
│   └── schema.sql                                    # Database schema, foreign keys & seed data
├── src/
│   └── main/
│       ├── java/
│       │   └── com/
│       │       └── cinebook/
│       │           ├── model/                        # Data Entities (POJOs)
│       │           │   ├── User.java
│       │           │   ├── Movie.java
│       │           │   ├── Theatre.java
│       │           │   ├── Showtime.java
│       │           │   └── Booking.java
│       │           ├── util/                         # JDBC Connection & Exceptions
│       │           │   ├── DBUtil.java
│       │           │   └── SeatAlreadyBookedException.java
│       │           ├── dao/                          # JDBC Data Access Layer
│       │           │   ├── UserDAO.java
│       │           │   ├── MovieDAO.java
│       │           │   ├── TheatreDAO.java
│       │           │   ├── ShowtimeDAO.java
│       │           │   └── BookingDAO.java
│       │           ├── service/                      # Business Logic Layer
│       │           │   ├── UserService.java
│       │           │   ├── MovieService.java
│       │           │   ├── ShowtimeService.java
│       │           │   └── BookingService.java
│       │           ├── controller/                   # Jakarta Servlets
│       │           │   ├── HomeServlet.java          # /home
│       │           │   ├── AuthServlet.java          # /auth, /login, /register, /logout
│       │           │   ├── MovieServlet.java         # /movies
│       │           │   ├── BookingServlet.java       # /booking (seats, checkout, pay, history)
│       │           │   └── AdminServlet.java         # /admin (dashboard, movie/showtime CRUD)
│       │           ├── filter/                       # Web Filters
│       │           │   ├── AuthFilter.java           # Security guard for /admin/*
│       │           │   └── LoggingFilter.java        # Request timing logger
│       │           ├── listener/                     # Web Listeners
│       │           │   ├── AppContextListener.java   # App startup lifecycle & DB verification
│       │           │   └── UserSessionListener.java  # Active concurrent sessions counter
│       │           └── demo/                         # Standalone Advanced Java Demos
│       │               ├── SwingDemo.java            # Desktop Box Office Counter GUI
│       │               ├── SocketServerDemo.java     # Multi-threaded TCP Socket Server
│       │               ├── SocketClientDemo.java     # TCP Socket Client
│       │               ├── MovieBookingRemote.java   # RMI Remote Interface
│       │               ├── RMIServerDemo.java        # RMI Server Registry Host
│       │               ├── RMIClientDemo.java        # RMI Remote Client
│       │               ├── SerializationDemo.java    # Object persistence & transient CVV
│       │               └── I18nDemo.java             # Locale, ResourceBundle & Currency
│       ├── resources/
│       │   ├── db.properties                         # MySQL credentials
│       │   ├── messages.properties                   # Default English i18n
│       │   ├── messages_es.properties                # Spanish i18n
│       │   └── messages_fr.properties                # French i18n
│       └── webapp/
│           ├── index.jsp                             # Landing Showcase
│           ├── WEB-INF/
│           │   ├── web.xml                           # Jakarta EE 10 Deployment Descriptor
│           │   └── views/
│           │       ├── common/                       # Shared Fragments (Navbar, Footer)
│           │       ├── auth/                         # Login & Registration views
│           │       ├── movie/                        # Movie Catalog & Details views
│           │       ├── booking/                      # Seat Grid, Checkout, Receipt, History
│           │       └── admin/                        # Admin Dashboard, Movie/Showtime CRUD
│           └── assets/
│               ├── css/style.css                     # Premium Dark Cinema Styling
│               └── js/seat-selection.js              # Seat click toggle & price calculations
```

---

## 🗄️ Database Schema (MySQL)

Execute the complete script located at [`sql/schema.sql`](sql/schema.sql) in MySQL:

```bash
mysql -u root -p < sql/schema.sql
```

### Table Relationships:
* `users`: Stores registered customers and administrators (`role: ENUM('CUSTOMER', 'ADMIN')`).
* `movies`: Title, genre, duration in minutes, language, synopsis, poster URL, and release date.
* `theatres`: Theatre name, city, and street address.
* `showtimes`: Links `movies` and `theatres` with date, time, price, and seat capacity.
* `bookings`: User reference, showtime, total seats, total amount paid, payment mode, and reference ID.
* `booked_seats`: **Enforces single-seat concurrency** via compound unique constraint `(showtime_id, seat_number)`.

---

## 🚀 Getting Started & Installation

### Prerequisites
* **Java Development Kit (JDK)**: 17 or newer
* **Build Tool**: Apache Maven 3.8+
* **Database**: MySQL Server 8.x
* **Application Server**: Apache Tomcat 11.x

### Step 1: Clone the Repository
```bash
git clone https://github.com/vishwassaini6839-ui/javaproject.git
cd javaproject
```

### Step 2: Configure Database Credentials
Open `src/main/resources/db.properties` and verify your MySQL credentials:
```properties
db.driver=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/cinebook_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC
db.user=root
db.password=your_mysql_password
```

### Step 3: Build the Web Application Archive (WAR)
```bash
mvn clean package
```
Maven compiles all classes and generates `target/cinebook.war`.

### Step 4: Deploy on Apache Tomcat 11
Copy the WAR file into your Tomcat `webapps/` folder:
```bash
cp target/cinebook.war $CATALINA_HOME/webapps/
```
Start Tomcat:
* **macOS / Linux**: `$CATALINA_HOME/bin/startup.sh`
* **Windows**: `%CATALINA_HOME%\bin\startup.bat`

Access the application in your browser:
```
http://localhost:8080/cinebook/
```

---

## 🔑 Default Login Credentials

| Role | Username / Email | Password | Allowed Privileges |
|---|---|---|---|
| **Administrator** | `admin@cinebook.com` | `admin123` | Full Admin Panel, Movie CRUD, Showtime Scheduling, All Bookings |
| **Customer** | `john@example.com` | `password123` | Browsing Movies, Seat Booking, Checkout, Personal History |
| **Customer** | `sarah@example.com` | `password123` | Browsing Movies, Seat Booking, Checkout, Personal History |

---

## 🧪 Advanced Java Demos (Standalone)

Each demo under `com.cinebook.demo` contains an independent `main()` method:

### 1. Swing GUI Box Office Counter
Desktop ticketing application built with `JFrame`, `JComboBox`, `JSpinner`, and receipt generator.
```bash
mvn compile exec:java -Dexec.mainClass="com.cinebook.demo.SwingDemo"
```

### 2. Multi-threaded TCP Sockets
Client-Server socket architecture communicating on port `8088` using custom ticketing protocols (`LIST`, `CHECK <movie>`, `BOOK <movie> <qty>`).
* **Terminal 1 (Server):**
  ```bash
  mvn compile exec:java -Dexec.mainClass="com.cinebook.demo.SocketServerDemo"
  ```
* **Terminal 2 (Client):**
  ```bash
  mvn compile exec:java -Dexec.mainClass="com.cinebook.demo.SocketClientDemo"
  ```

### 3. Java RMI (Remote Method Invocation)
Distributed ticket pricing and booking service running on RMI Registry port `1099`.
* **Terminal 1 (RMI Server):**
  ```bash
  mvn compile exec:java -Dexec.mainClass="com.cinebook.demo.RMIServerDemo"
  ```
* **Terminal 2 (RMI Client):**
  ```bash
  mvn compile exec:java -Dexec.mainClass="com.cinebook.demo.RMIClientDemo"
  ```

### 4. Object Serialization & Transient Fields
Serializes a `Ticket` object to disk (`ticket.ser`); demonstrates that sensitive fields marked `transient` (such as `paymentCardCVV`) are omitted from disk persistence.
```bash
mvn compile exec:java -Dexec.mainClass="com.cinebook.demo.SerializationDemo"
```

### 5. Internationalization (i18n & l10n)
Demonstrates multi-language support across English, Spanish, and French using `ResourceBundle`, `Locale`, localized currency (`NumberFormat`), and localized date formatting (`DateFormat`).
```bash
mvn compile exec:java -Dexec.mainClass="com.cinebook.demo.I18nDemo"
```

### 6. Filters & Listeners
* **`AuthFilter`**: Intercepts requests targeting `/admin/*` and verifies administrator permissions.
* **`LoggingFilter`**: Measures HTTP execution duration in milliseconds.
* **`AppContextListener`**: Verifies database connectivity upon Servlet context initialization.
* **`UserSessionListener`**: Tracks live concurrent user sessions.

---

## 🔒 Seat Concurrency Validation

To eliminate race conditions when two customers attempt to reserve the exact same seat simultaneously, CineBook implements **two-layer concurrency protection**:

1. **Database Row Lock (`FOR UPDATE`)**:
   During booking creation, the transaction locks selected seats in `booked_seats` inside a single JDBC transaction (`conn.setAutoCommit(false)`).
2. **Compound Unique Database Constraint**:
   ```sql
   UNIQUE KEY uq_showtime_seat (showtime_id, seat_number)
   ```
   If a duplicate booking is attempted, MySQL throws error code `1062`, rolling back the transaction and triggering `SeatAlreadyBookedException` to inform the user cleanly without corrupting state.

---

## 📄 License
This project is open-source and available under the [MIT License](LICENSE).
