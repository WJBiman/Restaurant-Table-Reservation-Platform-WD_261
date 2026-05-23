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

<!-- Main Content -->

<main class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-5">
        <div>
            <h2 style="font-family: 'Playfair Display'; color: #7a111e;">Service Overview</h2>
            <p class="text-muted small mb-0">Real-time status of curated dining.</p>
        </div>
        <div class="d-flex gap-3">
            <div class="search-wrapper">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text" id="adminSearch" class="search-input" placeholder="Search guests, IDs...">
            </div>
        </div>
    </div>


    <!-- Stats Cards -->
    <div class="row g-4 mb-5">
        <div class="col">
            <div class="stats-card filter-card active" data-filter="all" onclick="filterReservations('all', this)">
                <div class="d-flex justify-content-between align-items-start mb-3">
                    <h6 class="text-muted small text-uppercase fw-bold mb-0">Total Bookings</h6>
                    <div class="stats-icon-small bg-soft-maroon"><i class="fa-solid fa-calendar-check"></i></div>
                </div>
                <h2 class="mb-2 fw-bold"><%= totalRes %></h2>
                <span class="text-muted small">All Active</span>
            </div>
        </div>
        <div class="col">
            <div class="stats-card filter-card" data-filter="Completed" onclick="filterReservations('Completed', this)">
                <div class="d-flex justify-content-between align-items-start mb-3">
                    <h6 class="text-muted small text-uppercase fw-bold mb-0">Completed</h6>
                    <div class="stats-icon-small bg-soft-success"><i class="fa-solid fa-check-double"></i></div>
                </div>
                <h2 class="mb-2 fw-bold"><%= request.getAttribute("completedCount") != null ? request.getAttribute("completedCount") : 0 %></h2>
                <span class="text-success small fw-medium">Archived</span>
            </div>
        </div>
        <div class="col">
            <div class="stats-card filter-card" data-filter="Confirmed" onclick="filterReservations('Confirmed', this)">
                <div class="d-flex justify-content-between align-items-start mb-3">
                    <h6 class="text-muted small text-uppercase fw-bold mb-0">Confirmed</h6>
                    <div class="stats-icon-small bg-soft-primary" style="background: rgba(13, 110, 253, 0.1); color: #0d6efd;"><i class="fa-solid fa-circle-check"></i></div>
                </div>
                <h2 class="mb-2 fw-bold"><%= confirmedRes %></h2>
                <span class="text-primary small">On Guest List</span>
            </div>
        </div>
        <div class="col">
            <div class="stats-card filter-card" data-filter="Pending" onclick="filterReservations('Pending', this)">
                <div class="d-flex justify-content-between align-items-start mb-3">
                    <h6 class="text-muted small text-uppercase fw-bold mb-0">Pending</h6>
                    <div class="stats-icon-small bg-soft-warning"><i class="fa-solid fa-clock-rotate-left"></i></div>
                </div>
                <h2 class="mb-2 fw-bold"><%= pendingRes %></h2>
                <span class="text-warning small fw-medium">Action Required</span>
            </div>
        </div>
        <div class="col">
            <div class="stats-card filter-card" data-filter="Cancelled" onclick="filterReservations('Cancelled', this)">
                <div class="d-flex justify-content-between align-items-start mb-3">
                    <h6 class="text-muted small text-uppercase fw-bold mb-0">Cancelled</h6>
                    <div class="stats-icon-small bg-soft-danger"><i class="fa-solid fa-circle-xmark"></i></div>
                </div>
                <h2 class="mb-2 fw-bold"><%= cancelledRes %></h2>
                <span class="text-danger small">Cancelled</span>
            </div>
        </div>
    </div>

    <!-- Tab Contents -->
    <div class="tab-content">
        
        <!-- Reservations Tab -->
        <div class="tab-pane fade show active" id="reservations-pane">
            <div class="content-card">
                <div class="p-4 border-bottom d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 fw-bold">Guest List</h5>
                    <div class="d-flex gap-2">
                        <% if (cancelledRes > 0) { %>
                            <button type="button" class="btn btn-sm btn-outline-danger border-0" onclick="showClearCancelledModal(<%= cancelledRes %>)">
                                <i class="fa-solid fa-broom me-1"></i> Clear Cancelled
                            </button>
                        <% } %>
                        <button onclick="window.location.reload()" class="btn btn-sm btn-outline-secondary border-0"><i class="fa-solid fa-rotate-right"></i></button>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table table-custom mb-0">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Customer Name</th>
                                <th>Date/Time</th>
                                <th>Guests</th>
                                <th>Table</th>
                                <th>Submitted On</th>
                                <th>Status</th>
                                <th class="text-end">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (reservations != null && !reservations.isEmpty()) { 
                                for (Reservation r : reservations) { 
                                    String badgeClass = "badge-confirmed";
                                    if(r.getStatus().equalsIgnoreCase("Pending")) badgeClass = "badge-pending";
                                    if(r.getStatus().equalsIgnoreCase("Cancelled")) badgeClass = "badge-cancelled";
                            %>
                            <tr class="align-middle status-row" data-status="<%= r.getStatus() %>" data-id="<%= r.getReservationId() %>" data-name="<%= r.getCustomerName() %>" data-phone="<%= r.getPhoneNumber() %>" data-date="<%= r.getReservationDate() %>" data-time="<%= r.getReservationTime() %>" data-guests="<%= r.getGuestCount() %>" data-table="<%= r.getTableNumber() %>">
                                <td class="text-muted small">#<%= r.getReservationId() %></td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="rounded-circle bg-light d-flex align-items-center justify-content-center me-3" style="width: 32px; height: 32px; font-size: 0.8rem; color: #7a111e; font-weight: 700;">
                                            <%= r.getCustomerName().substring(0, 1).toUpperCase() %>
                                        </div>
                                        <span class="fw-bold"><%= r.getCustomerName() %></span>
                                    </div>
                                </td>
                                <td>
                                    <div><%= r.getReservationDate() %></div>
                                    <small class="text-muted"><%= r.getReservationTime() %></small>
                                </td>
                                <td><i class="fa-solid fa-user-group me-2 small text-muted"></i><%= r.getGuestCount() %></td>
                                <td>Table <%= r.getTableNumber().replace("T", "") %></td>
                                <td class="small text-muted">---</td>
                                <td><span class="status-badge-custom <%= badgeClass %>">• <%= r.getStatus() %></span></td>
                                <td class="text-end">
                                    <div class="d-flex justify-content-end gap-2">
                                            <% if ("Confirmed".equalsIgnoreCase(r.getStatus())) { %>
                                                <button type="button" class="btn-action btn-approve-action" style="background: #2e7d32; color: white;" 
                                                        onclick="showCompleteModal('<%= r.getReservationId() %>', '<%= r.getCustomerName() %>')" title="Complete">
                                                    <i class="fa-solid fa-check-double"></i>
                                                </button>
                                            <% } %>
                                            <% if ("Pending".equalsIgnoreCase(r.getStatus())) { %>
                                                <button type="button" class="btn-action btn-approve-action" title="Approve" 
                                                        onclick="approveReservationAjax('<%= r.getReservationId() %>', this)">
                                                    <i class="fa-solid fa-check"></i>
                                                </button>
                                            <% } %>
                                            <% if (!"Cancelled".equalsIgnoreCase(r.getStatus())) { %>
                                                <button type="button" class="btn-action" title="Edit" onclick="openUpdateModalFromRow(this)"><i class="fa-solid fa-pen"></i></button>
                                                <button type="button" class="btn-action btn-delete-action" onclick="showCancelSingleModal('<%= r.getReservationId() %>', '<%= r.getCustomerName() %>')" title="Cancel">
                                                    <i class="fa-solid fa-xmark"></i>
                                                </button>
                                            <% } %>
                                    </div>
                                </td>
                            </tr>
                            <% } } else { %>
                            <tr class="no-res-row"><td colspan="8" class="text-center text-muted py-5">No reservations scheduled for tonight.</td></tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>



        <!-- Users Tab -->
        <div class="tab-pane fade" id="users-pane">
            <div class="content-card">
                <div class="p-4 border-bottom d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 fw-bold">System Access Control</h5>
                    <a href="addUser" class="btn btn-sm btn-primary px-3" style="background: #7a111e; border: none;">Add Staff</a>
                </div>
                <div class="table-responsive">
                    <table class="table table-custom mb-0">
                        <thead>
                            <tr>
                                <th>User</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th class="text-end">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (users != null) { 
                                for (User u : users) { 
                            %>
                            <tr class="align-middle">
                                <td>
                                    <div class="fw-bold"><%= u.getName() %></div>
                                    <small class="text-muted">@<%= u.getUsername() %></small>
                                </td>
                                <td><%= u.getEmail() %></td>
                                <td>
                                    <span class="badge <%= u.getRole().equalsIgnoreCase("Admin") ? "bg-maroon-light" : "bg-light text-dark" %> px-3 py-2 border">
                                        <%= u.getRole() %>
                                    </span>
                                </td>
                                <td class="text-end">
                                    <div class="d-flex justify-content-end gap-2">
                                        <a href="updateUser?id=<%= u.getId() %>" class="btn-action" title="Edit"><i class="fa-solid fa-user-gear"></i></a>
                                        <form action="deleteUser" method="post" style="display:inline;" onsubmit="return confirm('Remove this staff member?');">
                                            <input type="hidden" name="id" value="<%= u.getId() %>">
                                            <button type="submit" class="btn-action btn-delete-action border-0 bg-transparent" title="Delete"><i class="fa-solid fa-trash"></i></button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                            <% } } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>

<%-- Main closed in footer --%>

<!-- Custom Liquid Glass Clear Cancelled Modal -->
<div id="clearCancelledModal" class="custom-modal-overlay" style="display: none;">
    <div class="custom-modal-content liquid-glass-panel">
        <div class="text-center mb-4">
            <div class="modal-icon-circle mb-3 bg-danger">
                <i class="fa-solid fa-broom text-white"></i>
            </div>
            <h4 style="font-family: 'Playfair Display'; color: #7a111e;">Clear Reservations</h4>
            <p id="clearModalMessage" class="text-muted"></p>
        </div>
        
        <div class="d-flex gap-3 justify-content-center">
            <button onclick="closeClearCancelledModal()" class="btn-modal-cancel">No, Keep them</button>
            <form action="clearCancelledReservations" method="post">
                <button type="submit" class="btn-modal-confirm">Yes, Remove</button>
            </form>
        </div>
    </div>
</div>

<!-- Custom Liquid Glass Complete Modal -->
<div id="completeModal" class="custom-modal-overlay" style="display: none;">
    <div class="custom-modal-content liquid-glass-panel">
        <div class="text-center mb-4">
            <div class="modal-icon-circle mb-3" style="background: #2e7d32;">
                <i class="fa-solid fa-check-double text-white"></i>
            </div>
            <h4 style="font-family: 'Playfair Display'; color: #7a111e;">Complete Reservation</h4>
            <p id="completeModalMessage" class="text-muted">Mark this reservation as completed and archive it?</p>
            <p id="completeModalDetail" class="text-maroon fw-bold mb-0"></p>
        </div>
        
        <div class="d-flex gap-3 justify-content-center">
            <button onclick="closeCompleteModal()" class="btn-modal-cancel">No, Not yet</button>
            <form action="completeReservation" method="post" id="completeForm">
                <input type="hidden" name="id" id="completeIdInput">
                <button type="submit" class="btn-modal-confirm" style="background: #2e7d32;">Yes, Complete</button>
            </form>
        </div>
    </div>
</div>

<!-- Custom Liquid Glass Cancel Single Modal -->
<div id="cancelSingleModal" class="custom-modal-overlay" style="display: none;">
    <div class="custom-modal-content liquid-glass-panel">
        <div class="text-center mb-4">
            <div class="modal-icon-circle mb-3" style="background: #7a111e;">
                <i class="fa-solid fa-xmark text-white"></i>
            </div>
            <h4 style="font-family: 'Playfair Display'; color: #7a111e;">Cancel Reservation</h4>
            <p id="cancelSingleMessage" class="text-muted"></p>
        </div>
        
        <div class="d-flex gap-3 justify-content-center">
            <button onclick="closeCancelSingleModal()" class="btn-modal-cancel">No, Keep it</button>
            <form action="deleteReservation" method="post" id="cancelSingleForm">
                <input type="hidden" name="id" id="cancelSingleIdInput">
                <button type="submit" class="btn-modal-confirm" style="background: #7a111e;">Yes, Cancel</button>
            </form>
        </div>
    </div>
</div>

<style>
    .filter-card { cursor: pointer; transition: all 0.3s ease; border: 1px solid transparent; }
    .filter-card:hover { transform: translateY(-5px); box-shadow: 0 10px 20px rgba(0,0,0,0.1); border-color: rgba(122, 17, 30, 0.2); }
    .filter-card.active { background: white; border-color: #7a111e; box-shadow: 0 10px 25px rgba(122, 17, 30, 0.1); }
    .filter-card.active h6 { color: #7a111e !important; }
    
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
        max-width: 420px;
        box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        animation: slideUp 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
    }
    .modal-icon-circle {
        width: 60px; height: 60px;
        border-radius: 50%;
        display: flex; align-items: center; justify-content: center;
        margin: 0 auto;
        font-size: 1.5rem;
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
    }
    .btn-modal-confirm {
        background: #7a111e;
        color: white; border: none;
        padding: 12px 24px; border-radius: 12px;
        font-weight: 600; cursor: pointer;
        transition: all 0.3s ease;
    }
    .btn-modal-confirm:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2); }
    
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
    let activeReservationsHtml = null;

    function filterReservations(status, element) {
        // Update active card UI
        document.querySelectorAll('.filter-card').forEach(card => card.classList.remove('active'));
        element.classList.add('active');

        const tableBody = document.querySelector('.table-custom tbody');
        
        // If "all", "Pending", "Confirmed", "Cancelled" - they are all in the current table
        if (status !== 'Completed') {
            // Restore original rows if we were looking at completed
            if (activeReservationsHtml) {
                tableBody.innerHTML = activeReservationsHtml;
                activeReservationsHtml = null;
            }

            const rows = document.querySelectorAll('.status-row');
            rows.forEach(row => {
                if (status === 'all' || row.getAttribute('data-status') === status) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
            
            // Handle "No reservations" message
            const visibleRows = Array.from(rows).filter(r => r.style.display !== 'none');
            const existingNoRes = document.querySelector('.no-res-row');
            if (visibleRows.length === 0) {
                if (!existingNoRes) {
                    tableBody.insertAdjacentHTML('beforeend', '<tr class="no-res-row"><td colspan="8" class="text-center text-muted py-5">No reservations matching this status.</td></tr>');
                } else {
                    existingNoRes.style.display = '';
                }
            } else if (existingNoRes) {
                existingNoRes.style.display = 'none';
            }
        } else {
            // Special case: Completed reservations are in a different table
            if (!activeReservationsHtml) activeReservationsHtml = tableBody.innerHTML;
            
            tableBody.innerHTML = '<tr><td colspan="8" class="text-center py-5"><div class="spinner-border text-maroon" role="status"></div></td></tr>';
            
            fetch('getCompletedReservations')
                .then(response => response.text())
                .then(html => {
                    tableBody.innerHTML = html;
                })
                .catch(err => {
                    tableBody.innerHTML = '<tr><td colspan="8" class="text-center text-danger py-5">Error loading archived data.</td></tr>';
                });
        }
    }

    function showClearCancelledModal(count) {
        document.getElementById('clearModalMessage').innerHTML = 'Permanently remove all <b>' + count + '</b> cancelled reservations from the database?';
        document.getElementById('clearCancelledModal').style.display = 'flex';
    }
    function closeClearCancelledModal() {
        document.getElementById('clearCancelledModal').style.display = 'none';
    }

    function showCompleteModal(id, name) {
        document.getElementById('completeIdInput').value = id;
        document.getElementById('completeModalDetail').innerText = name;
        document.getElementById('completeModal').style.display = 'flex';
    }
    function closeCompleteModal() {
        document.getElementById('completeModal').style.display = 'none';
    }

    function approveReservationAjax(id, btnElement) {
        const row = btnElement.closest('tr');
        const formData = new URLSearchParams();
        formData.append('id', id);
        formData.append('ajax', 'true');

        fetch('approveReservation', {
            method: 'POST',
            body: formData,
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
        })
        .then(response => response.text())
        .then(result => {
            if (result === 'success') {
                // Update Row Status UI
                row.setAttribute('data-status', 'Confirmed');
                const badge = row.querySelector('.status-badge-custom');
                if (badge) {
                    badge.className = 'status-badge-custom';
                    badge.style.background = 'rgba(13, 110, 253, 0.1)';
                    badge.style.color = '#0d6efd';
                    badge.innerHTML = '• Confirmed';
                }

                // Update Action Buttons
                const actionsDiv = row.querySelector('.d-flex.justify-content-end');
                actionsDiv.innerHTML = `
                    <button type="button" class="btn-action btn-approve-action" style="background: #2e7d32; color: white;" 
                            onclick="showCompleteModal('${id}', '${row.querySelector('.fw-bold').innerText}')" title="Complete">
                        <i class="fa-solid fa-check-double"></i>
                    </button>
                    <button type="button" class="btn-action" title="Edit" onclick="openUpdateModalFromRow(this)"><i class="fa-solid fa-pen"></i></button>
                    <button type="button" class="btn-action btn-delete-action" onclick="showCancelSingleModal('${id}', '${row.querySelector('.fw-bold').innerText}')" title="Cancel">
                        <i class="fa-solid fa-xmark"></i>
                    </button>
                `;

                // Update Stats Counters (Dynamic)
                updateStatsCount('Pending', -1);
                updateStatsCount('Confirmed', 1);

                // If currently filtered to Pending, hide the row
                const activeFilter = document.querySelector('.filter-card.active').getAttribute('data-filter');
                if (activeFilter === 'Pending') {
                    row.style.animation = 'fadeOut 0.3s ease forwards';
                    setTimeout(() => {
                        row.style.display = 'none';
                        checkEmptyTable();
                    }, 300);
                }
            }
        });
    }

    function updateStatsCount(status, delta) {
        const card = document.querySelector(`.filter-card[data-filter="${status}"] h2`);
        if (card) {
            let current = parseInt(card.innerText);
            card.innerText = current + delta;
        }
    }

    function checkEmptyTable() {
        const tableBody = document.querySelector('.table-custom tbody');
        const visibleRows = Array.from(document.querySelectorAll('.status-row')).filter(r => r.style.display !== 'none');
        if (visibleRows.length === 0) {
            if (!document.querySelector('.no-res-row')) {
                tableBody.insertAdjacentHTML('beforeend', '<tr class="no-res-row"><td colspan="8" class="text-center text-muted py-5">No reservations matching this status.</td></tr>');
            }
        }
    }

    function showCancelSingleModal(id, name) {
        document.getElementById('cancelSingleIdInput').value = id;
        document.getElementById('cancelSingleMessage').innerHTML = 'Are you sure you want to cancel the reservation for <b>' + name + '</b> (# ' + id + ')?';
        document.getElementById('cancelSingleModal').style.display = 'flex';
    }
    function closeCancelSingleModal() {
        document.getElementById('cancelSingleModal').style.display = 'none';
    }

    // Close on outside click
    window.onclick = function(event) {
        if (event.target.classList.contains('custom-modal-overlay')) {
            closeClearCancelledModal();
            closeCompleteModal();
            closeCancelSingleModal();
        }
    }

    // Real-time Search Logic
    const searchInput = document.getElementById('adminSearch');
    if (searchInput) {
        searchInput.addEventListener('input', function() {
            const query = this.value.toLowerCase();
            const rows = document.querySelectorAll('.table-custom tbody tr:not(.no-res-row)');
            rows.forEach(row => {
                const text = row.innerText.toLowerCase();
                row.style.display = text.includes(query) ? '' : 'none';
            });
        });
    }
    function openUpdateModalFromRow(btn) {
        const row = btn.closest('tr');
        openUpdateModal(
            row.dataset.id, row.dataset.name, row.dataset.phone, 
            row.dataset.date, row.dataset.time, row.dataset.guests, 
            row.dataset.table, row.dataset.status
        );
    }
</script>
<jsp:include page="includes/update_modal.jsp" />
<script>
    // Override reloadPage for admin dashboard to reload the current page properly
    function reloadPage() {
        window.location.reload();
    }
</script>
<jsp:include page="includes/admin_footer.jsp" />


