<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.restaurant.service.TableService" %>
<%@ page import="com.restaurant.model.Table" %>
<%@ page import="java.util.List" %>
<jsp:include page="includes/header.jsp" />
<%
    if (session.getAttribute("customerLoggedIn") == null) {
        response.sendRedirect("login.jsp?error=please_login");
        return;
    }
%>
<head>
    <title>Reserve Your Experience - Bloom</title>
    <style>
        :root { --maroon-dark: #7a111e; }
        .section-title { color: var(--maroon-dark); font-family: 'Playfair Display', serif; font-size: 1.2rem; margin-bottom: 20px; border-bottom: 1px solid rgba(0,0,0,0.1); padding-bottom: 10px; }
        .booking-card { background: rgba(255, 255, 255, 0.65); backdrop-filter: blur(16px); -webkit-backdrop-filter: blur(16px); border: 1px solid rgba(255, 255, 255, 0.4); border-radius: 16px; padding: 35px; box-shadow: 0 8px 32px rgba(0,0,0,0.1); }
    </style>
</head>
<body>
</body>
</html>
