
<h1 align="center">🌹 Bloom - Restaurant Table Reservation Platform 🌹</h1>

<p align="center">
  <strong>A Premium Java OOP Web Application for Seamless Dining Experiences</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Java-17%2B-orange?style=for-the-badge&logo=java" alt="Java"/>
  <img src="https://img.shields.io/badge/Servlet%20%26%20JSP-4.0-blue?style=for-the-badge&logo=jakartaee" alt="Servlets"/>
  <img src="https://img.shields.io/badge/MySQL-8.0-blue?style=for-the-badge&logo=mysql&logoColor=white" alt="MySQL"/>
  <img src="https://img.shields.io/badge/Apache%20Tomcat-9.0-orange?style=for-the-badge&logo=apachetomcat&logoColor=white" alt="Tomcat"/>
  <img src="https://img.shields.io/badge/Maven-Build%20Tool-red?style=for-the-badge&logo=apachemaven" alt="Maven"/>
  <img src="https://img.shields.io/badge/OOP-Concepts-green?style=for-the-badge" alt="OOP"/>
  <img src="https://img.shields.io/badge/License-MIT-brightgreen?style=for-the-badge" alt="License"/>
</p>

---

## 📌 Table of Contents
* [📖 Project Description](#-project-description)
* [✨ Features](#-features)
* [🛠️ Technologies Used](#%EF%B8%8F-technologies-used)
* [🧩 OOP Concepts Demonstrated](#-oop-concepts-demonstrated)
* [📊 Class Diagram](#-class-diagram)
* [📁 Project Structure](#-project-structure)
* [⚙️ Installation & Setup Guide](#%EF%B8%8F-installation--setup-guide)
* [📱 Screenshots & Demo](#-screenshots--demo)
* [🌿 Git Branch Strategy](#-git-branch-strategy)
* [👥 Contributors & Roles](#-contributors--roles)
* [🙏 Acknowledgments](#-acknowledgments)
* [📄 License](#-license)

---

## 📖 Project Description
**Bloom** is a premium, full-featured Restaurant Table Reservation Platform built as a Java OOP university group project. The platform bridges the gap between sophisticated dining establishments and their guests, offering a seamless booking flow, visual table selection, user account self-service, and a master administrative control board. 

Prioritizing robust backend logic and elegant interface aesthetics, the application addresses the common friction points in standard restaurant management systems, such as double-booking conflicts, suboptimal table capacity mapping, and laggy administrative interfaces. By applying strict Object-Oriented Programming (OOP) design patterns, Bloom provides an extensible, modular architecture that separates key domains—Authentication, Users, Tables, Reservations, Profiles, and Global Administration.

<div align="center">
  <blockquote>
    "An elegant dining experience begins long before you sit at the table. Bloom ensures the journey starts with ease, simplicity, and visual delight."
  </blockquote>
</div>

[🔼 Back to Top](#-table-of-contents)

---

## ✨ Features

### 👤 Customer Features
* **🔐 Secure Authentication**: Multi-layered session management, custom password verification, and routing filters to prevent unauthorized access.
* **📝 Self-Registration**: Quick, interactive signup with autofocus forms and real-time input trim formatting.
* **📅 Smart Reservation Engine**: Real-time conflict resolution by validating date, time, and table availability, ensuring zero double-bookings.
* **👤 Interactive User Profile**: Complete dashboard to review, cancel, or modify active reservations, alongside real-time personal detail updates.

### 💼 Admin Features
* **📊 Visual KPI Metrics**: Core dashboard cards calculating real-time metrics, including active reservations, total customer accounts, occupied tables count, and total tables.
* **🎛️ Control Panel**: Full list structures with custom tabs for reservation oversight (approve/reject actions) and user account management.
* **🗃️ Table Inventory**: Complete administrator suite to add, modify, or delete dining tables with dedicated capacity and status controls.

[🔼 Back to Top](#-table-of-contents)

---

## 🛠️ Technologies Used

| Category | Technology | Logo / Icon | Description |
|---|---|---|---|
| **Core** | **Java (JDK 17)** | <img src="https://img.shields.io/badge/Java-ED8B00?style=flat&logo=openjdk&logoColor=white" alt="Java"/> | Primary object-oriented logic & backend controller code. |
| **Web Server** | **Jakarta Servlet & JSP** | <img src="https://img.shields.io/badge/Jakarta%20EE-0073C1?style=flat&logo=eclipseche&logoColor=white" alt="Jakarta"/> | Dynamic request handling, filtering, routing, and UI rendering. |
| **Database** | **MySQL Server 8.0** | <img src="https://img.shields.io/badge/MySQL-00000F?style=flat&logo=mysql&logoColor=white" alt="MySQL"/> | Relational database schema for secure, persistent storage. |
| **Build & Dependencies** | **Apache Maven** | <img src="https://img.shields.io/badge/Maven-C71A36?style=flat&logo=apachemaven&logoColor=white" alt="Maven"/> | Dependency management, compilation, and WAR packaging. |
| **Server Engine** | **Apache Tomcat 9.0** | <img src="https://img.shields.io/badge/Tomcat-F8991D?style=flat&logo=apachetomcat&logoColor=white" alt="Tomcat"/> | Local Servlet container and hosting server. |
| **Frontend Styling** | **HTML5 & Vanilla CSS** | <img src="https://img.shields.io/badge/CSS3-1572B6?style=flat&logo=css3&logoColor=white" alt="CSS"/> | Custom glassmorphism, responsive grids, and micro-animations. |

[🔼 Back to Top](#-table-of-contents)

---

## 🧩 OOP Concepts Demonstrated

The core foundation of the **Bloom** system lies in the strict application of major Object-Oriented Programming (OOP) principles:

### 1. Encapsulation
Data hiding is enforced by keeping class properties `private` and exposing access strictly through standardized getter and setter methods. This safeguards the integrity of data within domain models.
```java
// Example from src/main/java/com/restaurant/model/Reservation.java
public class Reservation {
    private int reservationId;
    private int userId;
    private String guestName;
    private String reservationDate;
    private String status; // Pending, Confirmed, Cancelled

    // Getters and Setters ensuring data integrity
    public int getReservationId() { return this.reservationId; }
    public void setReservationId(int reservationId) { this.reservationId = reservationId; }

    public String getStatus() { return this.status; }
    public void setStatus(String status) { this.status = status; }
}
```

### 2. Inheritance
Hierarchical structures eliminate code redundancy. The `User` class inherits shared identity fields from the base `Person` class, while specialized roles like `Admin` and `Customer` extend `User`.
```java
// Base class (Person)
public class Person {
    protected String firstName;
    protected String lastName;
    protected String email;
}

// Subclass inheriting Person (User)
public class User extends Person {
    protected int userId;
    protected String role;
}

// Specialized subclass inheriting User (Customer)
public class Customer extends User {
    private String loyaltyTier;
}
```

### 3. Polymorphism
Polymorphic behavior is widely utilized through method overriding (e.g. standard Servlet `doGet` and `doPost` implementations) and dynamic method invocation within service layers.
```java
// Overriding generic Servlet life-cycle methods
@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    List<Reservation> reservations = reservationService.getAllReservations();
    request.setAttribute("reservations", reservations);
    request.getRequestDispatcher("/admin.jsp").forward(request, response);
}
```

### 4. Abstraction
High-level architectural contracts are defined via Service interfaces, keeping controller layers decoupled from the underlying DAO database operations.
```java
// Interface abstraction
public interface TableService {
    List<Table> getAvailableTables(String date, String time);
    boolean addTable(Table table);
    boolean deleteTable(int tableId);
}

// Implementation detail hidden from view
public class TableServiceImpl implements TableService {
    private TableDAO tableDAO = new TableDAOImpl();

    @Override
    public List<Table> getAvailableTables(String date, String time) {
        return tableDAO.findAvailable(date, time);
    }
}
```

[🔼 Back to Top](#-table-of-contents)

---

## 📊 Class Diagram
The architectural mapping of all models, servlets, and services is visually represented below:

<p align="center">
  <img src="[Link to your UML Class Diagram Image / doc/diagram.png]" alt="UML Class Diagram" width="700" style="border: 1px solid #ddd; border-radius: 8px;"/>
</p>

[🔼 Back to Top](#-table-of-contents)

---

## 📁 Project Structure
The organized directory structure of the Maven-based **Bloom** web application:

```text
RestaurantReservation/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/
│   │   │       └── restaurant/
│   │   │           ├── dao/          # Database Access Objects (UserDAO, ReservationDAO, TableDAO)
│   │   │           ├── model/        # Domain Models (Person, User, Admin, Customer, Reservation, Table)
│   │   │           ├── service/      # Business Logic Services
│   │   │           ├── servlet/      # Web Controllers (Login, Signup, Tables, MyAccount, ViewAll)
│   │   │           └── util/         # DBConnection, RoutingFilter, Test Utilities
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       │   ├── lib/              # Database Connector Libraries
│   │       │   └── web.xml           # Servlet Mappings & Routing Config
│   │       ├── css/                  # Excluded local stylesheets
│   │       ├── images/               # Project Visual Assets
│   │       ├── includes/             # Shared JSP Layouts (header, footer, update_modal)
│   │       ├── admin.jsp             # Administrative Dashboard
│   │       ├── my_reservations.jsp   # Customer self-service panel
│   │       ├── index.jsp             # Public landing page
│   │       ├── login.jsp             # System authentication portal
│   │       └── signup.jsp            # User registration portal
├── pom.xml                           # Maven Configuration
├── database_schema.sql               # MySQL Initialization Schema
└── README.md                         # Project documentation
```

[🔼 Back to Top](#-table-of-contents)

---

## ⚙️ Installation & Setup Guide

### 📋 Prerequisites
* **Java Development Kit (JDK 17 or higher)**
* **Apache Tomcat 9.x**
* **MySQL Server 8.0**
* **Apache Maven 3.8+** or integrated IDE compiler (Eclipse, IntelliJ, NetBeans)

---

### 💻 Step-by-Step Installation

#### 1. Clone the Repository
```bash
git clone https://github.com/WJBiman/Restaurant-Table-Reservation-Platform-WD_261.git
cd Restaurant-Table-Reservation-Platform-WD_261
```

#### 2. Set Up Database Schema
Launch your MySQL command-line client or administration UI (e.g. Workbench), and run the sql script to initialize tables:
```sql
CREATE DATABASE IF NOT EXISTS bloom_db;
USE bloom_db;
SOURCE database_schema.sql;
```

#### 3. Build & Package the Application
Use Maven to download dependencies and package the web application into a `.war` file:
```bash
mvn clean package
```

#### 4. Deploy to Apache Tomcat
* Copy the generated `RestaurantReservation.war` file from the `target/` directory.
* Paste it into the `webapps/` folder of your Apache Tomcat installation.
* Start the Tomcat server. The WAR file will automatically deploy and expand.

#### 5. Access the Application
Open your web browser and navigate to:
```text
http://localhost:8080/RestaurantReservation/
```

[🔼 Back to Top](#-table-of-contents)

---

## 📱 Screenshots & Demo

### 💻 Main Landing Page
<p align="center">
  <img src="[Link to Landing Page Screenshot / doc/landing_demo.png]" alt="Main Landing Page" width="700" style="border-radius: 8px;"/>
</p>

### 🔐 User Login Portal & Booking Engine
<p align="center">
  <img src="[Link to Booking Flow / doc/booking_demo.png]" alt="Booking & Login Portal" width="700" style="border-radius: 8px;"/>
</p>

### 📊 Master Administrative Board
<p align="center">
  <img src="[Link to Admin Dashboard / doc/admin_demo.png]" alt="Admin Panel Layout" width="700" style="border-radius: 8px;"/>
</p>

[🔼 Back to Top](#-table-of-contents)

---

## 🌿 Git Branch Strategy

For organic and systematic parallel development, the group implemented a rigid feature-branch separation strategy. All changes were isolated, tested, and resolved for Committer co-authorship before final integration:

```mermaid
gitGraph
    commit id: "initial repository setup"
    branch Authentication-Management
    branch User-Management
    branch Reservation-Management
    branch Table-Management
    branch Profile-Management
    branch Admin-Management
    
    checkout Authentication-Management
    commit id: "added login validations"
    commit id: "added route filter rules"
    
    checkout User-Management
    commit id: "created signup layout"
    commit id: "implemented UserDAO logic"
    
    checkout Reservation-Management
    commit id: "created booking page"
    commit id: "added date checks"
    
    checkout main
    merge Authentication-Management id: "Merged Auth"
    merge User-Management id: "Merged User"
    merge Reservation-Management id: "Merged Reservation"
```

* **`main` Branch**: Contains the stable, 100% integrated finished product.
* **Module Branches**: Dedicated feature development branches isolated by student member assignments (`Authentication`, `User`, `Reservation`, `Table`, `Profile`, `Admin`).

[🔼 Back to Top](#-table-of-contents)

---

## 👥 Contributors & Roles

The project was completed through collaborative teamwork by **Group WD_261**:

| Member Profile | Student ID | Dedicated Git Branch | Primary Contributions & Roles |
|---|---|---|---|
| **Perera P.H.M** | `it25103439` | `User-Management` | **User Domain Architecture**: Designed `User`, `Person`, `Admin`, and `Customer` model inheritance. Coded `UserDAO`, registration logic, and admin customer tables. |
| **Gajaweera G.A.S.N** | `it25102707` | `Authentication-Management` | **Security & Access Control**: Designed application routing filters, session validators, secure signout flow, and Web configuration mappings. |
| **Siriwardana H.D.K.P** | `it25101476` | `Reservation-Management` | **Booking Engine Logic**: Created reservation workflows, validation handlers for booking slots, and table availability models. |
| **Pushpakumara A.S.P.W.A** | `it25103286` | `Table-Management` | **Table Inventory Subsystem**: Developed capacity checkers, administrator table controls, and service layers for table allocation. |
| **Chathushka A.H.S** | `it25101421` | `Profile-Management` | **User Panel & Modals**: Built the responsive custom modals, personal information update servlet, and historical reservation list controllers. |
| **Warushawithana J.B** | `wjbiman` | `Admin-Management` | **Global Systems & Assets**: Coded the master administrative dashboard servlets, SQL schemas, public page assets, and global database connectors. |

[🔼 Back to Top](#-table-of-contents)

---

## 🙏 Acknowledgments
* **Sri Lanka Institute of Information Technology (SLIIT)**: For the comprehensive OOP curriculum, guidelines, and assignment specifications.
* **Course Lecturers & Instructors**: For their invaluable feedback, mentoring, and support throughout the module lifecycle.
* **Open Source Community**: For the powerful tools and frameworks (Tomcat, Maven, MySQL) enabling student enterprise architectures.

---

## 📄 License
This project is licensed under the MIT License - see the LICENSE details:

```text
MIT License

Copyright (c) 2026 Group WD_261

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.
```

[🔼 Back to Top](#-table-of-contents)
