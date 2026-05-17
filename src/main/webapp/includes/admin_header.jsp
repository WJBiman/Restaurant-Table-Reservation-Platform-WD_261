<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <link href="css/admin.css" rel="stylesheet">
</head>
<body class="bg-light">

<aside class="sidebar">
    <div class="sidebar-logo">
        <h4>Bloom Portal</h4>
    </div>
    <ul class="nav-menu">
        <li class="nav-item-custom">
            <a href="index.jsp" class="nav-link-custom">
                <i class="fa-solid fa-house"></i> View Site
            </a>
        </li>
        <li class="nav-item-custom">
            <a href="adminTables" class="nav-link-custom" id="admin-nav-tables">
                <i class="fa-solid fa-border-all"></i> Floor Plan
            </a>
        </li>
        <li class="nav-item-custom">
            <a href="viewAllReservations" class="nav-link-custom" id="admin-nav-res">
                <i class="fa-solid fa-calendar-check"></i> Reservations
            </a>
        </li>
        <li class="nav-item-custom">
            <a href="customers" class="nav-link-custom" id="admin-nav-cust">
                <i class="fa-solid fa-users"></i> Customers
            </a>
        </li>
        <li class="nav-item-custom mt-5">
            <a href="logout" class="nav-link-custom text-danger">
                <i class="fa-solid fa-right-from-bracket"></i> Sign Out
            </a>
        </li>
    </ul>
</aside>

<div class="main-content">
