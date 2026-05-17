<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.restaurant.model.User" %>
<% 
    if (session.getAttribute("adminLoggedIn") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    User u = (User) request.getAttribute("user");
    String error = (String) request.getAttribute("errorMessage");
%>
<jsp:include page="includes/admin_header.jsp" />

<main class="container py-5">
    <div style="max-width: 600px; margin: 0 auto;">
        <div class="mb-5">
            <div class="text-muted small mb-1 text-uppercase fw-bold" style="letter-spacing: 1px;">Admin / Security / Edit</div>
            <h2 style="font-family: 'Playfair Display'; color: #7a111e; font-weight: 700;">Update Profile</h2>
            <p class="text-muted">Modify access levels or contact info for <%= u.getName() %>.</p>
        </div>

        <% if (error != null) { %>
            <div class="alert alert-danger mb-4"><%= error %></div>
        <% } %>

        <div class="card border-0 shadow-sm p-4 p-md-5" style="border-radius: 20px;">
            <form action="updateUser" method="post">
                <input type="hidden" name="userId" value="<%= u.getId() %>">
                
                <div class="mb-4">
                    <label class="form-label small fw-bold text-muted">Full Name</label>
                    <input type="text" name="name" class="form-control" value="<%= u.getName() %>" required style="border-radius: 10px;">
                </div>

                <div class="row g-4 mb-4">
                    <div class="col-md-6">
                        <label class="form-label small fw-bold text-muted">Username</label>
                        <input type="text" name="username" class="form-control" value="<%= u.getUsername() %>" required style="border-radius: 10px;">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small fw-bold text-muted">Password</label>
                        <input type="password" name="password" class="form-control" value="<%= u.getPassword() %>" required style="border-radius: 10px;">
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label small fw-bold text-muted">Email Address</label>
                    <input type="email" name="email" class="form-control" value="<%= u.getEmail() %>" required style="border-radius: 10px;">
                </div>

                <div class="row g-4 mb-5">
                    <div class="col-md-12">
                        <label class="form-label small fw-bold text-muted">Phone Number</label>
                        <input type="text" name="phone" class="form-control" value="<%= u.getPhone() %>" required style="border-radius: 10px;">
                    </div>
                    <input type="hidden" name="role" value="<%= u.getRole() %>">
                </div>

                <div class="d-flex justify-content-between align-items-center">
                    <a href="viewAllReservations" class="text-muted text-decoration-none small fw-bold">Cancel</a>
                    <button type="submit" class="btn btn-primary px-5 py-3" style="background: #7a111e; border: none; border-radius: 15px; font-weight: 600;">
                        Save Changes
                    </button>
                </div>
            </form>
        </div>
    </div>
</main>

<jsp:include page="includes/admin_footer.jsp" />
