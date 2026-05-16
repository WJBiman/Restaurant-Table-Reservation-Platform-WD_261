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
%>

<main class="container-fluid">
    <div class="tab-content">
        <div class="tab-pane fade show active" id="reservations-pane">
            <div class="content-card">
                <div class="table-responsive">
                    <table class="table table-custom mb-0">
                        <tbody>
                            <% if (reservations != null && !reservations.isEmpty()) { 
                                for (Reservation r : reservations) { 
                            %>
                            <tr class="align-middle">
                                <td class="text-muted small">#<%= r.getReservationId() %></td>
                                <td><span class="fw-bold"><%= r.getCustomerName() %></span></td>
                                <td><%= r.getReservationDate() %></td>
                                <td><%= r.getGuestCount() %></td>
                                <td><%= r.getStatus() %></td>
                            </tr>
                            <% } } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</main>
