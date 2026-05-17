<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.restaurant.model.User" %>
<% 
    if (session.getAttribute("adminLoggedIn") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<jsp:include page="includes/admin_header.jsp" />
<script>document.getElementById('admin-nav-cust').classList.add('active');</script>

<%
    List<User> customers = (List<User>) request.getAttribute("customers");
    int totalCustomers = (customers != null) ? customers.size() : 0;
%>

<main class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-5">
        <div>

            <h2 style="font-family: 'Playfair Display'; color: #7a111e;">Customer Database</h2>
            <p class="text-muted small mb-0">View and manage your registered guest profiles and contact information.</p>
        </div>

    </div>



    <!-- Table Content -->
    <div class="content-card">
        <div class="p-4 border-bottom d-flex justify-content-between align-items-center">
            <div class="search-wrapper">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text" id="customerSearch" class="search-input" placeholder="Search by name, email or phone...">
            </div>

        </div>
        <div class="table-responsive">
            <table class="table table-custom mb-0">
                <thead>
                    <tr>
                        <th>Customer Details</th>
                        <th>Username</th>
                        <th>Contact Number</th>
                        <th>Email Address</th>
                        <th class="text-end">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (customers != null && !customers.isEmpty()) { 
                        for (User c : customers) { 
                    %>
                    <tr class="align-middle">
                        <td>
                            <div class="d-flex align-items-center gap-3">
                                <div class="avatar-circle">
                                    <%= c.getName().substring(0,1).toUpperCase() %>
                                </div>
                                <div>
                                    <div class="fw-bold"><%= c.getName() %></div>
                                    <div class="text-muted small">Registered Guest</div>
                                </div>
                            </div>
                        </td>
                        <td class="text-muted">@<%= c.getUsername() %></td>
                        <td class="fw-medium"><%= c.getPhone() %></td>
                        <td><%= c.getEmail() %></td>
                        <td class="text-end">
                            <div class="d-flex justify-content-end gap-3">
                                <a href="updateUser?id=<%= c.getId() %>" class="btn btn-sm btn-light text-maroon" title="Edit Profile"><i class="fa-solid fa-user-pen"></i></a>
                                <form action="deleteUser" method="post" style="display:inline;" onsubmit="return confirm('Delete this customer profile?');">
                                    <input type="hidden" name="id" value="<%= c.getId() %>">
                                    <button type="submit" class="btn btn-sm btn-light text-danger" title="Delete"><i class="fa-solid fa-trash"></i></button>
                                </form>
                            </div>
                        </td>
                    </tr>
                    <% } } else { %>
                    <tr><td colspan="5" class="text-center text-muted py-5">No registered customers found.</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>

    </div>
</main>

<style>
    .avatar-circle {
        width: 40px;
        height: 40px;
        background: #f8f1f2;
        color: #7a111e;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 700;
        font-size: 1.1rem;
    }
</style>

<script>
    // Search functionality
    const searchInput = document.getElementById('customerSearch');
    const tableRows = document.querySelectorAll('.table-custom tbody tr');

    if (searchInput) {
        searchInput.addEventListener('input', function() {
            const query = this.value.toLowerCase();
            tableRows.forEach(row => {
                const text = row.innerText.toLowerCase();
                if (text.includes(query)) row.style.display = '';
                else row.style.display = 'none';
            });
        });
    }
</script>

<jsp:include page="includes/admin_footer.jsp" />
