<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.restaurant.model.Reservation" %>
<%@ page import="com.restaurant.model.Table" %>
<%@ page import="com.restaurant.model.User" %>
<% 
    if (request.getAttribute("reservations") == null) {
        response.sendRedirect("viewAllReservations");
        return;
    }
%>
<jsp:include page="includes/admin_header.jsp" />
<script>document.getElementById('admin-nav-res').classList.add('active');</script>
