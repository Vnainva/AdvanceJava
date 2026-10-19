# ☕ Advanced Java Experiments

A collection of **Advanced Java** practical experiments covering core concepts like MVC Architecture, Socket Programming, JDBC, RMI, and Swing GUI — implemented as part of academic coursework.

---

## 📁 Project Structure

```
advanceJava-main/
├── Calculator/               → MVC-based GUI Calculator
├── clientServer/             → Socket Programming (Client-Server)
├── JDBC/                     → Java Database Connectivity (MySQL)
├── RMI/                      → Remote Method Invocation
└── StudentRegistrationForm/  → Swing GUI Registration Form
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

## 🛠️ Prerequisites

| Tool | Version |
|------|---------|
| Java JDK | 8 or above |
| MySQL Server | 5.7 or above (for JDBC experiment) |
| MySQL JDBC Driver | `mysql-connector-java.jar` |
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

---

## 👨‍💻 Author

**Vishal** — [GitHub: Vnainva](https://github.com/Vnainva)

---

## 📄 License

This project is for **educational purposes** only.
