<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.restaurant.model.Reservation" %>
<jsp:include page="includes/header.jsp" />

<style>
    .bookings-hero {
        background: linear-gradient(135deg, #7a111e 0%, #3a0007 100%);
        color: white;
        padding: 50px 40px;
        border-radius: 20px;
        margin-bottom: 40px;
        box-shadow: 0 10px 30px rgba(122, 17, 30, 0.15);
    }
    .bookings-hero h2 {
        font-family: 'Playfair Display', serif;
        font-size: 2.5rem;
        margin-bottom: 10px;
    }
    .bookings-hero p {
        font-size: 1.1rem;
        opacity: 0.9;
        margin: 0;
    }
    .search-section {
        background: white;
        border-radius: 16px;
        padding: 30px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
        margin-bottom: 40px;
        border: 1px solid #eaeaea;
    }
    .search-input-wrapper {
        display: flex;
        gap: 15px;
        background: #f8f9fa;
        border: 1px solid #e0e0e0;
        border-radius: 12px;
        padding: 6px 10px 6px 20px;
        align-items: center;
    }
    .search-input-wrapper input {
        border: none;
        background: transparent;
        flex: 1;
        outline: none;
        font-size: 1rem;
        color: #333;
    }
    .search-input-wrapper button {
        background: #7a111e;
        color: white;
        border: none;
        padding: 10px 25px;
        border-radius: 8px;
        font-weight: 600;
        transition: background 0.3s;
    }
    .search-input-wrapper button:hover {
        background: #5a0c16;
    }
    .booking-card {
        background: white;
        border-radius: 20px;
        border: 1px solid #eaeaea;
        margin-bottom: 30px;
        overflow: hidden;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
    }
    .booking-card-main {
        display: flex;
        border-bottom: 1px solid #eaeaea;
    }
    .booking-image {
        width: 300px;
        background-size: cover;
        background-position: center;
    }
    .booking-info {
        padding: 40px;
        flex: 1;
    }
    .booking-status {
        display: inline-flex;
        align-items: center;
        padding: 6px 16px;
        border-radius: 30px;
        font-size: 0.85rem;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 1px;
        margin-bottom: 20px;
    }
    .status-confirmed { background: #d4edda; color: #155724; }
    .status-cancelled { background: #f8d7da; color: #721c24; }
    .status-pending { background: #fff3cd; color: #856404; }
    .booking-title {
        font-family: 'Playfair Display', serif;
        font-size: 1.8rem;
        color: #7a111e;
        margin-bottom: 5px;
    }
    .booking-id {
        color: #888;
        font-size: 0.9rem;
        text-transform: uppercase;
        letter-spacing: 1px;
        margin-bottom: 25px;
    }
    .booking-meta {
        display: flex;
        gap: 40px;
    }
    .meta-item {
        display: flex;
        align-items: center;
        gap: 15px;
    }
    .meta-icon {
        width: 45px;
        height: 45px;
        border-radius: 12px;
        background: rgba(122, 17, 30, 0.05);
        color: #7a111e;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 1.2rem;
    }
    .meta-label {
        display: block;
        font-size: 0.8rem;
        color: #888;
        text-transform: uppercase;
        font-weight: 600;
    }
    .meta-value {
        font-weight: 700;
        color: #333;
    }
    .booking-details-grid {
        display: grid;
        grid-template-columns: 1fr 1fr 1fr;
        padding: 30px 40px;
        background: #fdfdfd;
        gap: 30px;
    }
    .detail-section h6 {
        color: #7a111e;
        font-weight: 700;
        margin-bottom: 15px;
        font-size: 0.95rem;
    }
    .detail-group { margin-bottom: 12px; }
    .detail-label { font-size: 0.8rem; color: #888; }
    .detail-value { font-weight: 600; color: #333; }
    .btn-action-outline {
        border: 1px solid #7a111e;
        color: #7a111e;
        background: transparent;
        padding: 10px 20px;
        border-radius: 8px;
        font-weight: 600;
        width: 100%;
        transition: all 0.3s;
    }
    .btn-action-outline:hover {
        background: #7a111e;
        color: white;
    }
    .modification-note {
        padding: 15px 40px;
        background: rgba(122, 17, 30, 0.02);
        border-top: 1px solid #eaeaea;
        font-size: 0.85rem;
        color: #666;
    }
    @media (max-width: 992px) {
        .booking-card-main { flex-direction: column; }
        .booking-image { width: 100%; height: 200px; }
        .booking-details-grid { grid-template-columns: 1fr; }
    }
</style>

<div class="container py-4">
    <div class="bookings-hero">
        <h2>Welcome back, <%= session.getAttribute("customerName") != null ? session.getAttribute("customerName") : "Guest" %></h2>
        <p>Review and manage your curated dining experiences.</p>
    </div>

    <!-- Find Reservation Search -->
    <div class="search-section">
        <h6 class="text-center mb-3" style="color: #7a111e; font-size: 0.9rem; text-transform: uppercase; letter-spacing: 2px;">Find Your Reservation</h6>
        <form action="myAccount" method="get">
            <div class="search-input-wrapper">
                <i class="fa-solid fa-search"></i>
                <input type="text" name="searchQuery" value="<%= request.getParameter("searchQuery") != null ? request.getParameter("searchQuery") : "" %>" placeholder="Enter Booking ID (e.g. RES-8829-XL)">
                <button type="submit">Search</button>
            </div>
        </form>
    </div>

    <% 
        List<Reservation> myReservations = (List<Reservation>) request.getAttribute("myReservations");
        if (myReservations == null || myReservations.isEmpty()) {
    %>
        <div class="text-center py-5">
            <div class="link-icon-bg mx-auto mb-3" style="width: 80px; height: 80px; font-size: 2rem;">
                <i class="fa-solid fa-calendar-xmark"></i>
            </div>
            <h4 style="font-family: 'Playfair Display'; color: #7a111e;">No reservations found</h4>
            <p class="text-muted">You haven't made any curated dining plans yet.</p>
            <a href="reservation.jsp" class="btn btn-primary px-5 py-3 mt-3" style="border-radius: 8px; background: #7a111e; border: none; font-weight: 600;">Reserve a Table</a>
        </div>
    <% } else { 
        for (Reservation r : myReservations) {
            String tableId = r.getTableNumber();
            String tableImage = "images/table_" + tableId.toLowerCase().trim() + ".png";
            String fallbackImage = "images/bloom_indoor_elegance_1776880086931.png";
    %>
        <div class="booking-card">
            <div class="booking-card-main">
                <div class="booking-image" style="background-image: url('<%= tableImage %>'), url('<%= fallbackImage %>');"></div>
                <div class="booking-info">
                    <div class="booking-status <%= "Confirmed".equals(r.getStatus()) ? "status-confirmed" : ("Cancelled".equals(r.getStatus()) ? "status-cancelled" : "status-pending") %>">
                        <i class="fa-solid <%= "Confirmed".equals(r.getStatus()) ? "fa-circle-check" : ("Cancelled".equals(r.getStatus()) ? "fa-circle-xmark" : "fa-clock") %> me-1"></i>
                        <%= r.getStatus() %>
                    </div>
                    
                    <h4 class="booking-title">Bloom Fine Dining</h4>
                    <div class="booking-id">ID: <%= r.getReservationId() %></div>
                    
                    <div class="booking-meta">
                        <div class="meta-item">
                            <div class="meta-icon"><i class="fa-solid fa-calendar-days"></i></div>
                            <div>
                                <span class="meta-label">Date</span>
                                <span class="meta-value"><%= r.getReservationDate() %></span>
                            </div>
                        </div>
                        <div class="meta-item">
                            <div class="meta-icon"><i class="fa-solid fa-clock"></i></div>
                            <div>
                                <span class="meta-label">Time</span>
                                <span class="meta-value"><%= r.getReservationTime() %></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="booking-details-grid">
                <div class="detail-section">
                    <h6>Guest Details</h6>
                    <div class="detail-group">
                        <div class="detail-label">Primary Guest</div>
                        <div class="detail-value"><%= r.getCustomerName() %></div>
                    </div>
                    <div class="detail-group">
                        <div class="detail-label">Party Size</div>
                        <div class="detail-value"><%= r.getGuestCount() %> People</div>
                    </div>
                </div>
                
                <div class="detail-section">
                    <h6>Table Assignment</h6>
                    <div class="table-assignment">
                        <div class="table-icon"><i class="fa-solid fa-chair"></i></div>
                        <div>
                            <div class="detail-value">Table <%= tableId.replace("T", "") %></div>
                            <div class="detail-label" style="font-size: 0.75rem;">Premium Dining Space</div>
                        </div>
                    </div>
                </div>
                
                <div class="detail-section">
                    <h6>Action Center</h6>
                    <div class="action-center">
                        <% if (!"Cancelled".equalsIgnoreCase(r.getStatus())) { %>
                            <button type="button" class="btn-action-outline" 
                                    onclick="openUpdateModal('<%= r.getReservationId() %>', '<%= r.getCustomerName() %>', '<%= r.getPhoneNumber() %>', '<%= r.getReservationDate() %>', '<%= r.getReservationTime() %>', <%= r.getGuestCount() %>, '<%= r.getTableNumber() %>', '<%= r.getStatus() %>')">
                                <i class="fa-solid fa-pen-to-square"></i> Update Reservation
                            </button>
                            <a href="javascript:void(0)" onclick="confirmCancel('${pageContext.request.contextPath}/deleteReservation?id=<%= r.getReservationId() %>')" class="btn btn-sm btn-outline-danger w-100 mt-2" style="border-radius: 8px; font-weight: 600; text-decoration: none; display: flex; align-items: center; justify-content: center; gap: 8px;">
                                <i class="fa-solid fa-circle-xmark"></i> Cancel Booking
                            </a>
                        <% } else { %>
                            <div class="text-muted small italic">
                                <i class="fa-solid fa-lock me-1"></i> This record is inactive and cannot be modified.
                            </div>
                        <% } %>
                    </div>
                </div>
            </div>
            
            <div class="modification-note">
                <i class="fa-solid fa-circle-info"></i>
                Modifications allowed until 24 hours prior to reservation time.
            </div>
        </div>
    <% } } %>

</div>

<jsp:include page="includes/update_modal.jsp" />

<!-- Confirmation Modal -->
<div id="confirmModal" class="modal-overlay">
    <div class="modal-content-custom success-modal" style="text-align: center;">
        <div class="mb-4 text-warning" style="font-size: 80px;">
            <i class="fa-solid fa-circle-exclamation"></i>
        </div>
        <h3 class="mb-2" style="font-family: 'Playfair Display'; color: #7a111e;">Cancel Reservation?</h3>
        <p class="text-muted mb-4">Are you sure you want to cancel this booking? This action cannot be undone and your table will be released.</p>
        <div class="d-flex gap-2 justify-content-center">
            <button onclick="closeConfirmModal()" class="btn btn-outline-secondary px-4 py-2" style="border-radius: 12px;">Keep Booking</button>
            <button id="finalCancelBtn" class="btn btn-danger px-4 py-2" style="border-radius: 12px; background: #7a111e; border: none;">Yes, Cancel</button>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp" />
