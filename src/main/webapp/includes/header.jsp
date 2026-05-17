<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    
    <% 
        String uri = request.getRequestURI();
        boolean isHome = uri.endsWith("index.jsp") || uri.endsWith("/") || uri.endsWith("RestaurantReservation/");
    %>
    
    <style>
        .navbar {
            transition: all 0.4s ease-in-out;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
        }
        .navbar-brand {
            color: #7a111e !important;
            font-size: 1.6rem;
            font-family: 'Playfair Display', serif;
            font-weight: 700;
            letter-spacing: 1.5px;
            transition: all 0.4s ease;
        }
        .nav-link {
            color: #333333 !important;
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1.2px;
            margin: 0 12px;
            transition: all 0.4s ease;
        }
        .nav-link.active {
            border-bottom: 2px solid currentColor;
        }
        .navbar .fa-regular, .navbar .fa-solid {
            color: #333333 !important;
            transition: all 0.4s ease;
        }
        .header-home:not(.header-scrolled) {
            background-color: transparent !important;
            border-bottom: none !important;
            padding: 25px 0;
        }
        .header-home:not(.header-scrolled) .navbar-brand {
            color: #ffffff !important;
            font-size: 1.8rem;
        }
        .header-home:not(.header-scrolled) .nav-link {
            color: rgba(255, 255, 255, 0.85) !important;
        }
        .header-home:not(.header-scrolled) .fa-regular, 
        .header-home:not(.header-scrolled) .fa-solid {
            color: #ffffff !important;
        }
        .header-solid, .header-scrolled {
            background-color: #ffffff !important;
            padding: 18px 0;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            border-bottom: 1px solid #eaeaea;
        }
        .body-home { padding-top: 0 !important; }
        .body-standard { padding-top: 90px !important; }
    </style>
</head>
<body class="<%= isHome ? "body-home" : "body-standard" %>">

<nav class="navbar navbar-expand-lg <%= isHome ? "header-home" : "header-solid" %>">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">Bloom</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item"><a class="nav-link" href="index.jsp" id="nav-home">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="tables" id="nav-tables">Tables</a></li>
                <% if (session.getAttribute("customerLoggedIn") != null) { %>
                    <li class="nav-item"><a class="nav-link" href="myAccount" id="nav-bookings">My Bookings</a></li>
                <% } %>
            </ul>
            <div class="d-flex align-items-center">
                <a href="reservation.jsp" class="btn btn-primary px-4 py-2 me-4">Book a Table</a>
                <% if (session.getAttribute("customerLoggedIn") != null) { %>
                    <a href="logout" class="text-dark fs-5" title="Logout"><i class="fa-solid fa-right-from-bracket"></i></a>
                <% } else { %>
                    <a href="login.jsp" class="text-dark fs-5" title="Login"><i class="fa-regular fa-user-circle"></i></a>
                <% } %>
            </div>
        </div>
    </div>
</nav>

<% if (isHome) { %>
<script>
    window.addEventListener('scroll', function() {
        const navbar = document.querySelector('.navbar');
        if (window.scrollY > 50) {
            navbar.classList.add('header-scrolled');
        } else {
            navbar.classList.remove('header-scrolled');
        }
    });
</script>
<% } %>

<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        if(typeof flatpickr !== 'undefined') {
            flatpickr("input[type=date]", {
                dateFormat: "Y-m-d",
                minDate: "today",
                disableMobile: true
            });
            flatpickr("input[type=time]", {
                enableTime: true,
                noCalendar: true,
                dateFormat: "H:i",
                time_24hr: true,
                disableMobile: true
            });
        }
    });
</script>
