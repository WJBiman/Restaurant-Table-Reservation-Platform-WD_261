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

<% 
    List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
    List<Table> tables = (List<Table>) request.getAttribute("tables");
    List<User> users = (List<User>) request.getAttribute("users");
    
    int totalRes = reservations != null ? reservations.size() : 0;
    int confirmedRes = 0, pendingRes = 0, cancelledRes = 0;
    if (reservations != null) {
        for (Reservation r : reservations) {
            if ("Confirmed".equalsIgnoreCase(r.getStatus())) confirmedRes++;
            else if ("Pending".equalsIgnoreCase(r.getStatus())) pendingRes++;
            else if ("Cancelled".equalsIgnoreCase(r.getStatus())) cancelledRes++;
        }
    }
    int totalTab = tables != null ? tables.size() : 0;
    int totalUsr = users != null ? users.size() : 0;
%>

<main class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-5">
        <div>
            <h2 style="font-family: 'Playfair Display'; color: #7a111e;">Service Overview</h2>
            <p class="text-muted small mb-0">Real-time status of curated dining.</p>
        </div>
    </div>
</main>
