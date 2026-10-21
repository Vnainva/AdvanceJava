# ☕ Advanced Java Experiments and 🎬 CineBook – Movie Ticket Booking System project

🖥️ Java Swing • 🗄️ JDBC • 🌐 Sockets • 🔗 RMI • 🌍 Jakarta Servlet • 📄 JSP • 🐬 MySQL
A structured Advanced Java laboratory repository containing practical experiments covering MVC Architecture, Socket Programming, JDBC, RMI, Swing GUI, and Jakarta Servlet programming, together with CineBook, an Advanced Java movie ticket booking application.

## 📁 Project Structure

```
advanceJava-main/
├── Calculator/               → MVC-based GUI Calculator
├── clientServer/             → Socket Programming (Client-Server)
├── JDBC/                     → Java Database Connectivity (MySQL)
├── RMI/                      → Remote Method Invocation
├── StudentRegistrationForm/  → Swing GUI Registration Form
└── servlet/                  → Servlet, Filter & Listener (Maven Web App)
```

---

## 📂 Experiment Details

---

### 1. 🧮 Calculator — MVC Architecture
**Folder:** `Calculator/`

A GUI-based Calculator built using the **MVC (Model-View-Controller)** design pattern with Java Swing.

| File | Role |
|------|------|
| `CalculatorModel.java` | Handles arithmetic logic (add, subtract, multiply, divide) |
| `CalculatorView.java` | Builds the Swing UI with input fields and operation buttons |
| `CalculatorController.java` | Listens to button events and connects View ↔ Model |
| `Main.java` | Entry point — launches the MVC Calculator app |

**Key Concepts:** MVC Pattern, Java Swing, `ActionListener`, `JFrame`, `JTextField`, `JButton`

---

### 2. 🌐 Client-Server — Socket Programming
**Folder:** `clientServer/`

Demonstrates **TCP Socket Communication** between a server and a client over `localhost` on port `5000`.

| File | Role |
|------|------|
| `server.java` | Creates a `ServerSocket`, waits for client, receives message, sends `"Hello Client"` back |
| `client.java` | Connects to server, sends `"Hello Server"`, reads and prints the server's response |

**How it works:**
1. Run `server.java` first → waits for connection on port `5000`
2. Run `client.java` → connects, exchanges messages, disconnects

**Key Concepts:** `Socket`, `ServerSocket`, `BufferedReader`, `PrintWriter`, TCP/IP networking

---

### 3. 🗄️ JDBC — Java Database Connectivity
**Folder:** `JDBC/`

Demonstrates connecting Java to a **MySQL database**, inserting a record, and fetching all records.

| File | Role |
|------|------|
| `JdbcDemo.java` | Connects to MySQL, inserts a student record, and displays all student records |
| `App.java` | Alternate entry / helper class |

**Database Config:**
- Database: `college1`
- Table: `student (id INT, name VARCHAR, branch VARCHAR)`
- Driver: `com.mysql.cj.jdbc.Driver`

**Key Concepts:** `DriverManager`, `Connection`, `PreparedStatement`, `Statement`, `ResultSet`

> ⚠️ Update the MySQL credentials (`root` / `Admin_21`) in `JdbcDemo.java` before running.

---

### 4. 📡 RMI — Remote Method Invocation
**Folder:** `RMI/`

Demonstrates **Java RMI** — calling methods on a remote object running on a server from a client.

| File | Role |
|------|------|
| `calculator.java` | Remote interface — declares `add()` and `subtract()` methods |
| `calculatorImpl.java` | Implements the remote interface, extends `UnicastRemoteObject` |
| `server.java` | Registers the remote object in the RMI registry |
| `client.java` | Looks up the remote object and invokes `add()` / `subtract()` remotely |

**How it works:**
1. Compile all files
2. Start `server.java` → binds the remote calculator to the RMI registry
3. Run `client.java` → calls methods remotely as if they were local

**Key Concepts:** `Remote`, `RemoteException`, `UnicastRemoteObject`, `Naming`, RMI Registry

---

### 5. 📝 Student Registration Form — Java Swing GUI
**Folder:** `StudentRegistrationForm/`

A **form-based Swing application** for student registration with full validation.

| File | Role |
|------|------|
| `StudentRegistration.java` | Complete registration form with fields, validation, and dialogs |

**Form Fields:**
- 👤 Student Name
- 🔢 Roll Number
- ⚧ Gender (Radio Buttons — Male / Female)
- 🏫 Branch
- ☑️ Terms & Conditions (CheckBox)

**Features:**
- ✅ Field-level validation with `JOptionPane` error dialogs
- 🔄 Reset button clears all fields
- 📋 Submit button shows a confirmation summary dialog

**Key Concepts:** `JFrame`, `JTextField`, `JRadioButton`, `JCheckBox`, `JButton`, `JOptionPane`, `ActionListener`

---

### 6. 🌍 Servlet — Servlet, Filter & Listener
**Folder:** `servlet/`

A **Maven-based Java Web Application** demonstrating core Java EE Servlet concepts including request handling, session management, authentication filtering, and lifecycle listening.

| File | Role |
|------|------|
| `HelloServlet.java` | Handles `GET` (prints welcome message) and `POST` (greets user by name) at `/hello` |
| `LoginServlet.java` | Handles `POST` login at `/login` — validates credentials (`admin`/`1234`), creates `HttpSession` on success |
| `HomeServlet.java` | Handles `GET` at `/home` — reads username from session and displays personalized welcome page |
| `AuthFilter.java` | `@WebFilter("/home")` — checks if user is logged in (session exists); redirects to `index.html` if not |
| `AppListener.java` | `@WebListener` — `ServletContextListener` that prints `"Application Started"` / `"Application Stopped"` on deploy/undeploy |
| `index.html` | Login form UI — submits credentials to `/login` |
| `pom.xml` | Maven config — manages Jakarta Servlet dependencies |

**Request Flow:**
```
index.html → POST /login → LoginServlet → (session created) → GET /home
                                                              ↑
                                                         AuthFilter checks session
```

**Key Concepts:** `HttpServlet`, `HttpSession`, `Filter`, `FilterChain`, `ServletContextListener`, `@WebServlet`, `@WebFilter`, `@WebListener`, Jakarta EE, Maven

---

## 🛠️ Prerequisites

| Tool | Version |
|------|---------|
| Java JDK | 8 or above |
| MySQL Server | 5.7 or above (for JDBC experiment) |
| MySQL JDBC Driver | `mysql-connector-java.jar` |
| Apache Tomcat | 10+ (for Servlet experiment) |
| Maven | 3.6+ (for Servlet experiment) |
| IDE | IntelliJ IDEA / Eclipse / VS Code |

---

## ▶️ How to Run

### Calculator / Student Registration Form
```bash
cd Calculator
javac *.java
java Main
```

### Client-Server
```bash
# Terminal 1
cd clientServer
javac server.java
java server

# Terminal 2
cd clientServer
javac client.java
java client
```

### JDBC
```bash
cd JDBC
javac JdbcDemo.java
java -cp ".;mysql-connector-java.jar" JdbcDemo
```

### RMI
```bash
cd RMI
javac *.java
rmiregistry &      # Start RMI registry
java RMI.server    # Start server
java RMI.client    # Run client
```

### Servlet (Maven Web App)
```bash
cd servlet/servlet
mvn clean package
# Deploy generated .war file from target/ to Apache Tomcat webapps/
# Then open: http://localhost:8080/servlet/
```

---

## 👨‍💻 Author

**Vishal** —(https://github.com/Vnainva)

---

## 📄 License

# 🎬 CineBook – Movie Ticket Booking System

CineBook is an **Advanced Java movie ticket booking web application** built using **MVC Architecture** with JSP, Servlets, JDBC and MySQL. It runs on **Apache Tomcat 11** and Jakarta EE 10.

## ✨ Features

- 👤 User Registration & Login
- 🎬 Movie Browsing & Search
- 🎭 Theatre & Showtime Selection
- 💺 Interactive Seat Booking
- 💳 Payment Simulation
- 🎟️ Digital Ticket & Booking History
- 🛠️ Admin Dashboard
- 🔒 Secure Seat Concurrency Validation

## 🛠️ Technologies

**Java 17 • Jakarta EE 10 • Tomcat 11 • MySQL 8 • Maven • JDBC • JSP • Bootstrap 5**

## 🔄 Application Workflow

```text
User
 ↓
JSP / Web Page
 ↓
Servlet (Controller)
 ↓
Service Layer
 ↓
DAO Layer
 ↓
JDBC
 ↓
MySQL Database
 ↓
DAO → Service → Servlet
 ↓
JSP Response
 ↓
User
```

### 🎟️ Booking Flow

```text
Login
  ↓
Browse Movies
  ↓
Select Theatre & Showtime
  ↓
Select Seats
  ↓
Checkout & Payment
  ↓
Booking Saved in MySQL
  ↓
Generate Digital Ticket
  ↓
Booking History
```

The application follows a multi-tier MVC structure: **JSP → Servlet → Service → DAO → JDBC → MySQL**.

## 📂 File Structure

```text
cinebook/
├── pom.xml
├── README.md
├── sql/
│   └── schema.sql
│
├── src/main/java/com/cinebook/
│   ├── model/
│   │   ├── User.java
│   │   ├── Movie.java
│   │   ├── Theatre.java
│   │   ├── Showtime.java
│   │   └── Booking.java
│   │
│   ├── util/
│   │   └── DBUtil.java
│   │
│   ├── dao/
│   │   ├── UserDAO.java
│   │   ├── MovieDAO.java
│   │   ├── TheatreDAO.java
│   │   ├── ShowtimeDAO.java
│   │   └── BookingDAO.java
│   │
│   ├── service/
│   │   ├── UserService.java
│   │   ├── MovieService.java
│   │   ├── ShowtimeService.java
│   │   └── BookingService.java
│   │
│   ├── controller/
│   │   ├── HomeServlet.java
│   │   ├── AuthServlet.java
│   │   ├── MovieServlet.java
│   │   ├── BookingServlet.java
│   │   └── AdminServlet.java
│   │
│   ├── filter/
│   ├── listener/
│   └── demo/
│
├── src/main/resources/
│   ├── db.properties
│   └── messages.properties
│
└── src/main/webapp/
    ├── index.jsp
    ├── WEB-INF/
    │   ├── web.xml
    │   └── views/
    │       ├── auth/
    │       ├── movie/
    │       ├── booking/
    │       └── admin/
    └── assets/
        ├── css/
        └── js/
```

The project separates **Models, DAO, Services, Controllers, Filters, Listeners, JSP Views, resources and database scripts** for clean maintainability.

## 🚀 Run

```bash
mvn clean package
```

Deploy `target/cinebook.war` to **Tomcat 11** and open:

```text
http://localhost:8080/cinebook/
```



This project is for **educational purposes** only.
