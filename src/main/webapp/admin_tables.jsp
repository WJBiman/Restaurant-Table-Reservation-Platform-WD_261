<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.restaurant.model.Table" %>
<% 
    if (session.getAttribute("adminLoggedIn") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<jsp:include page="includes/admin_header.jsp" />
<script>document.getElementById('admin-nav-tables').classList.add('active');</script>

<%
    List<Table> tables = (List<Table>) request.getAttribute("tables");
    Integer totalTables = (Integer) request.getAttribute("totalTables");
    Integer totalCapacity = (Integer) request.getAttribute("totalCapacity");
    Integer availableTables = (Integer) request.getAttribute("availableTables");
    Integer occupiedTables = (Integer) request.getAttribute("occupiedTables");
    
    if (totalTables == null) totalTables = 0;
    if (totalCapacity == null) totalCapacity = 0;
    if (availableTables == null) availableTables = 0;
    if (occupiedTables == null) occupiedTables = 0;
    
    String successMsg = (String) session.getAttribute("successMessage");
    String errorMsg = (String) session.getAttribute("errorMessage");
    session.removeAttribute("successMessage");
    session.removeAttribute("errorMessage");
%>

<main class="container-fluid">
    <% if (successMsg != null) { %>
        <div class="alert alert-success alert-dismissible fade show mb-4" role="alert">
            <i class="fa-solid fa-circle-check me-2"></i> <%= successMsg %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>
    
    <% if (errorMsg != null) { %>
        <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
            <i class="fa-solid fa-triangle-exclamation me-2"></i> <%= errorMsg %>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>
    
    <div class="d-flex justify-content-between align-items-center mb-5">
        <div>
            <h2 style="font-family: 'Playfair Display'; color: #7a111e;">Table Management</h2>
            <p class="text-muted small mb-0">Configure floor plans and oversee seating capacity across dining zones.</p>
        </div>
        <div>
            <a href="adminAddTable" class="btn btn-primary" style="background: #7a111e; border: none; border-radius: 8px; padding: 10px 20px;">
                <i class="fa-solid fa-circle-plus me-2"></i> Add New Table
            </a>
        </div>
    </div>

    <!-- Stats Cards -->
    <div class="row g-4 mb-5">
        <div class="col-md-3">
            <div class="stats-card">
                <h6 class="text-muted small text-uppercase fw-bold mb-3">Total Tables</h6>
                <h2 class="mb-0 fw-bold" style="color: #7a111e;"><%= totalTables %></h2>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stats-card">
                <h6 class="text-muted small text-uppercase fw-bold mb-3">Total Capacity</h6>
                <h2 class="mb-0 fw-bold" style="color: #7a111e;"><%= totalCapacity %></h2>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stats-card">
                <h6 class="text-muted small text-uppercase fw-bold mb-3">Available</h6>
                <h2 class="mb-0 fw-bold d-flex align-items-center gap-2">
                    <%= availableTables %>
                </h2>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stats-card">
                <h6 class="text-muted small text-uppercase fw-bold mb-3">Not Available</h6>
                <h2 class="mb-0 fw-bold text-muted"><%= occupiedTables %></h2>
            </div>
        </div>
    </div>

    <!-- Table Content -->
    <div class="content-card">
        <div class="p-4 border-bottom d-flex justify-content-between align-items-center">
            <div class="d-flex gap-3">
                <div class="search-wrapper">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <input type="text" id="tableSearch" class="search-input" placeholder="Search tables...">
                </div>
            </div>
        </div>
        <div class="table-responsive">
            <table class="table table-custom mb-0">
                <thead>
                    <tr>
                        <th>Table Name</th>
                        <th>Capacity</th>
                        <th>Section</th>
                        <th>Status</th>
                        <th class="text-end">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (tables != null && !tables.isEmpty()) { 
                        for (Table t : tables) { 
                            boolean isAvailable = "Available".equalsIgnoreCase(t.getAvailabilityStatus());
                    %>
                    <tr class="align-middle">
                        <td>
                            <span class="fw-bold"><%= t.getTableId() %></span>
                        </td>
                        <td class="text-muted"><%= t.getCapacity() %> Guests</td>
                        <td>
                            <span class="badge bg-light text-muted border text-uppercase" style="font-size: 0.7rem; font-weight: 600;"><%= t.getLocation() %></span>
                        </td>
                        <td>
                            <% if (isAvailable) { %>
                                <span style="color: #28a745; font-weight: 600; font-size: 0.9rem;">
                                    <i class="fa-solid fa-circle" style="font-size: 0.5rem; vertical-align: middle; margin-right: 5px;"></i> Available
                                </span>
                            <% } else { %>
                                <span style="color: #d32f2f; font-weight: 600; font-size: 0.9rem;">
                                    <i class="fa-solid fa-circle" style="font-size: 0.5rem; vertical-align: middle; margin-right: 5px;"></i> Not Available
                                </span>
                            <% } %>
                        </td>
                        <td class="text-end">
                            <div class="d-flex justify-content-end gap-3">
                                <a href="adminAddTable?edit=<%= t.getTableId() %>" class="text-maroon text-decoration-none fw-bold" style="font-size: 0.9rem;">
                                    <i class="fa-solid fa-pen me-1"></i> Edit
                                </a>
                                <button type="button" class="border-0 bg-transparent text-danger fw-bold p-0" style="font-size: 0.9rem; cursor: pointer;" 
                                        onclick="showDeleteModal('<%= t.getTableId() %>')">
                                    <i class="fa-solid fa-trash-can me-1"></i> Remove
                                </button>
                            </div>
                        </td>
                    </tr>
                    <% } } else { %>
                    <tr><td colspan="5" class="text-center text-muted py-5">No tables configured.</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>

    </div>
</main>

<!-- Custom Liquid Glass Delete Modal -->
<div id="deleteModal" class="custom-modal-overlay" style="display: none;">
    <div class="custom-modal-content liquid-glass-panel">
        <div class="text-center mb-4">
            <div class="modal-icon-circle mb-3">
                <i class="fa-solid fa-trash-can text-white"></i>
            </div>
            <h4 style="font-family: 'Playfair Display'; color: #7a111e;">Remove Table</h4>
            <p class="text-muted small">Are you sure you want to remove this table?</p>
            <h5 id="deleteTableIdDisplay" class="fw-bold text-maroon mb-0"></h5>
        </div>
        
        <div class="d-flex gap-3 justify-content-center">
            <button onclick="closeDeleteModal()" class="btn-modal-cancel">No, Keep it</button>
            <form action="adminDeleteTable" method="post" id="deleteForm">
                <input type="hidden" name="id" id="deleteTableIdInput">
                <button type="submit" class="btn-modal-confirm">Yes, Remove</button>
            </form>
        </div>
    </div>
</div>

<style>
    .custom-modal-overlay {
        position: fixed;
        top: 0; left: 0; width: 100%; height: 100%;
        background: rgba(0,0,0,0.4);
        backdrop-filter: blur(8px);
        display: flex; align-items: center; justify-content: center;
        z-index: 9999;
        animation: fadeIn 0.3s ease;
    }
    .liquid-glass-panel {
        background: rgba(255, 255, 255, 0.9);
        border: 1px solid rgba(255, 255, 255, 0.4);
        border-radius: 24px;
        padding: 40px;
        width: 100%;
        max-width: 400px;
        box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        transform: translateY(0);
        animation: slideUp 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
    }
    .modal-icon-circle {
        width: 60px; height: 60px;
        background: #7a111e;
        border-radius: 50%;
        display: flex; align-items: center; justify-content: center;
        margin: 0 auto;
        font-size: 1.5rem;
        box-shadow: 0 8px 16px rgba(122, 17, 30, 0.2);
    }
    .btn-modal-confirm {
        background: #7a111e;
        color: white; border: none;
        padding: 12px 24px; border-radius: 12px;
        font-weight: 600; cursor: pointer;
        transition: all 0.3s ease;
    }
    .btn-modal-confirm:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(122, 17, 30, 0.3); }
    
    .btn-modal-cancel {
        background: #f5f5f5;
        color: #666; border: none;
        padding: 12px 24px; border-radius: 12px;
        font-weight: 600; cursor: pointer;
        transition: all 0.3s ease;
    }
    .btn-modal-cancel:hover { background: #eee; }

    @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
    @keyframes slideUp { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
</style>

<script>
    function showDeleteModal(id) {
        const modal = document.getElementById('deleteModal');
        const input = document.getElementById('deleteTableIdInput');
        const display = document.getElementById('deleteTableIdDisplay');
        
        if (modal && input && display) {
            input.value = id;
            display.innerText = id;
            modal.style.display = 'flex';
        }
    }

    function closeDeleteModal() {
        const modal = document.getElementById('deleteModal');
        if (modal) modal.style.display = 'none';
    }

    // Close on outside click
    window.onclick = function(event) {
        const modal = document.getElementById('deleteModal');
        if (event.target == modal) closeDeleteModal();
    }

    // Search functionality
    const searchInput = document.getElementById('tableSearch');
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
