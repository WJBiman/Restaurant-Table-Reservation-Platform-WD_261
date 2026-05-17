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
        .summary-card { background: rgba(255, 255, 255, 0.65); backdrop-filter: blur(16px); -webkit-backdrop-filter: blur(16px); border: 1px solid rgba(255, 255, 255, 0.4); border-radius: 16px; overflow: hidden; position: sticky; top: 100px; box-shadow: 0 8px 32px rgba(0,0,0,0.1); }
        .booking-card .form-control, .booking-card .form-select { background-color: rgba(255, 255, 255, 0.5); border: 1px solid rgba(255, 255, 255, 0.5); backdrop-filter: blur(4px); color: #222; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); transition: all 0.3s ease; }
        .booking-card .form-control:focus, .booking-card .form-select:focus { background-color: rgba(255, 255, 255, 0.8); box-shadow: 0 6px 20px rgba(122, 17, 30, 0.15); border-color: rgba(122, 17, 30, 0.3); outline: none; }
        .custom-select-wrapper { position: relative; user-select: none; width: 100%; }
        .custom-select-trigger { display: flex; align-items: center; justify-content: space-between; cursor: pointer; background-color: rgba(255, 255, 255, 0.5); border: 1px solid rgba(255, 255, 255, 0.5); backdrop-filter: blur(4px); border-radius: 12px; padding: 0.85rem 1rem; color: #222; box-shadow: 0 4px 15px rgba(0,0,0,0.05); transition: all 0.3s ease; height: 100%; }
        .custom-select-wrapper.open .custom-select-trigger { background-color: rgba(255, 255, 255, 0.8); box-shadow: 0 6px 20px rgba(122, 17, 30, 0.15); border-color: rgba(122, 17, 30, 0.3); }
        .custom-options { position: absolute; display: none; top: 100%; left: 0; right: 0; z-index: 1000; margin-top: 8px; background: rgba(255, 255, 255, 0.9); backdrop-filter: blur(20px); -webkit-backdrop-filter: blur(20px); border: 1px solid rgba(255,255,255,0.6); border-radius: 16px; box-shadow: 0 15px 40px rgba(0,0,0,0.15); overflow: hidden; max-height: 250px; overflow-y: auto; }
        .custom-options::-webkit-scrollbar { width: 6px; }
        .custom-options::-webkit-scrollbar-thumb { background: rgba(122, 17, 30, 0.3); border-radius: 3px; }
        .custom-select-wrapper.open .custom-options { display: block; animation: fadeInDown 0.2s ease-out; }
        .custom-option { padding: 12px 18px; cursor: pointer; color: #222; transition: background 0.2s; border-bottom: 1px solid rgba(0,0,0,0.05); }
        .custom-option:last-child { border-bottom: none; }
        .custom-option:hover { background: rgba(122, 17, 30, 0.08); color: var(--maroon-dark); }
        .custom-option.selected { font-weight: 600; background: rgba(122, 17, 30, 0.05); color: var(--maroon-dark); }
        @keyframes fadeInDown { from { opacity: 0; transform: translateY(-10px); } to { opacity: 1; transform: translateY(0); } }
        .summary-header { height: 150px; background-size: cover; background-position: center; position: relative; transition: background-image 0.5s ease; }
        .summary-header::after { content: ''; position: absolute; bottom: 0; left: 0; right: 0; top: 0; background: linear-gradient(transparent, rgba(0,0,0,0.7)); }
        .summary-header-text { position: absolute; bottom: 15px; left: 20px; z-index: 2; color: white; }
        .summary-body { padding: 25px; }
        .summary-row { display: flex; justify-content: space-between; margin-bottom: 15px; font-size: 0.95rem; }
        .summary-label { color: #555; }
        .summary-value { font-weight: 600; color: #111; }
        .notice-box { background: rgba(255, 255, 255, 0.5); backdrop-filter: blur(8px); border: 1px solid rgba(255,255,255,0.3); border-radius: 8px; padding: 15px; display: flex; gap: 12px; font-size: 0.85rem; color: #444; margin-top: 20px; box-shadow: 0 4px 15px rgba(0,0,0,0.02); }
        .recommended-table { background: white; border: 1px solid #eee; border-radius: 10px; padding: 12px; display: flex; gap: 15px; margin-bottom: 12px; cursor: pointer; }
        .rec-img { width: 80px; height: 60px; border-radius: 6px; object-fit: cover; }
        .btn-confirm { background: var(--maroon-dark); color: white; border: none; padding: 15px; border-radius: 15px; width: 100%; font-weight: 600; font-size: 1.1rem; margin-top: 20px; transition: all 0.3s ease; }
        .btn-confirm:hover { background: #5a0c16; transform: translateY(-2px); }
        
        /* Modal Styles */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.6);
            z-index: 9999;
            backdrop-filter: blur(8px);
            align-items: center;
            justify-content: center;
        }
        .modal-content-premium {
            background: #fdfdfd;
            border-radius: 20px;
            max-width: 500px;
            width: 95%;
            overflow: hidden;
            position: relative;
            box-shadow: 0 30px 70px rgba(0,0,0,0.3);
            transform: scale(0.8);
            opacity: 0;
            transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
        }
        .modal-overlay.show { display: flex; }
        .modal-overlay.show .modal-content-premium { transform: scale(1); opacity: 1; }

        .modal-header-premium { padding: 40px 40px 20px; text-align: center; }
        .modal-title-premium { font-family: 'Playfair Display', serif; color: #7a111e; font-size: 2.2rem; font-weight: 700; font-style: italic; margin-bottom: 5px; }
        .modal-subtitle-premium { color: #666; font-size: 0.95rem; }
        .info-card-premium { background: white; margin: 0 40px 30px; border-radius: 15px; padding: 25px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); border: 1px solid #f0f0f0; }
        .info-label-premium { color: #999; font-size: 0.7rem; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 5px; }
        .info-value-premium { color: #1a1a1a; font-weight: 600; font-size: 1.1rem; margin-bottom: 15px; }
        .info-row-premium { display: flex; justify-content: space-between; margin-bottom: 15px; }
        .info-item-premium { flex: 1; }
        .card-image-premium { width: 100%; height: 150px; object-fit: cover; mask-image: linear-gradient(to bottom, black 60%, transparent 100%); -webkit-mask-image: linear-gradient(to bottom, black 60%, transparent 100%); }
        .whats-next-box { background: #f8f9fa; margin: 0 40px 30px; padding: 20px; border-radius: 12px; display: flex; gap: 15px; }
        .whats-next-icon { color: #d4af37; font-size: 1.2rem; }
        .whats-next-text h6 { font-size: 0.9rem; font-weight: 700; margin-bottom: 5px; }
        .whats-next-text p { font-size: 0.8rem; color: #777; margin-bottom: 0; line-height: 1.4; }
        .modal-actions-premium { padding: 0 40px 40px; }
        .btn-premium-full { background: #7a111e; color: white; border: none; width: 100%; padding: 14px; border-radius: 15px; font-weight: 600; margin-bottom: 10px; transition: all 0.3s; }
        .btn-premium-full:hover { background: #5a0c16; transform: translateY(-2px); }
        .btn-premium-outline { background: transparent; color: #7a111e; border: 1px solid #7a111e; width: 100%; padding: 14px; border-radius: 15px; font-weight: 600; transition: all 0.3s; }
        .btn-premium-outline:hover { background: #fcf1f2; }
    </style>
</head>

<!-- Force body background via JS to avoid z-index and CSS scoping issues -->
<script>
    document.addEventListener("DOMContentLoaded", function() {
        document.body.style.backgroundImage = "url('images/samplebackground4bloom.png')";
        document.body.style.backgroundSize = "cover";
        document.body.style.backgroundPosition = "center";
        document.body.style.backgroundAttachment = "fixed";
        document.body.style.backgroundColor = "transparent";
    });
</script>

<div class="container py-5">
    <div class="mb-5">
        <h4 style="color: var(--maroon-dark); font-family: 'Playfair Display';">Your Bloom Experience</h4>
        <p class="text-muted">Join us for an evening of exquisite gastronomy and refined service.</p>
    </div>

    <%
        String preSelectedTable = request.getParameter("tableId");
        TableService tableService = new TableService();
        List<Table> tables = tableService.getAllTables();
    %>

    <form action="addReservation" method="post" id="reservationForm">
    <div class="row g-5">
        <div class="col-lg-7">
            <div class="booking-card">
                <%
                    String sessionName = (String) session.getAttribute("customerName");
                    String sessionPhone = (String) session.getAttribute("customerPhone");
                    String sessionEmail = (String) session.getAttribute("customerEmail");
                %>
                <h5 class="section-title">Guest Details</h5>
                <div class="row g-4 mb-5">
                    <div class="col-md-6">
                        <label class="form-label text-muted small">Full Name</label>
                        <input type="text" class="form-control" name="customerName" value="<%= sessionName != null ? sessionName : "" %>" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label text-muted small">Phone Number</label>
                        <input type="tel" class="form-control" name="phoneNumber" value="<%= sessionPhone != null ? sessionPhone : "" %>" required>
                    </div>
                    <div class="col-12">
                        <label class="form-label text-muted small">Email Address</label>
                        <input type="email" class="form-control" name="email" value="<%= sessionEmail != null ? sessionEmail : "" %>">
                    </div>
                </div>

                <h5 class="section-title">Reservation Info</h5>
                <div class="row g-4 mb-5">
                    <div class="col-md-6">
                        <label class="form-label text-muted small">Date</label>
                        <input type="date" class="form-control" name="reservationDate" id="resDate" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label text-muted small">Time</label>
                        <input type="time" class="form-control" name="reservationTime" id="resTime" value="20:00" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label text-muted small">Number of Guests</label>
                        <select class="form-select" name="guestCount" id="resGuests" required>
                            <option value="2">2 Guests</option>
                            <option value="3">3 Guests</option>
                            <option value="4">4 Guests</option>
                            <option value="6" selected>6 Guests</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label text-muted small">Selected Table</label>
                        <% if (preSelectedTable != null && !preSelectedTable.isEmpty()) { 
                            Table t = tableService.getTableById(preSelectedTable);
                        %>
                            <input type="text" class="form-control" value="Table <%= preSelectedTable.replace("T", "") %>" readonly style="background-color: #f1f3f4; cursor: not-allowed; font-weight: 600; color: var(--maroon-dark);">
                            <input type="hidden" name="tableNumber" id="resTable" value="<%= preSelectedTable %>" data-pax="<%= t != null ? t.getCapacity() : 2 %>" data-location="<%= t != null ? t.getLocation() : "Main Hall" %>">
                        <% } else { %>
                            <div class="d-flex gap-2">
                                <select class="form-select" name="tableNumber" id="resTable" required>
                                    <option value="">Select a table...</option>
                                    <% for (Table t : tables) { %>
                                        <option value="<%= t.getTableId() %>" data-pax="<%= t.getCapacity() %>" data-location="<%= t.getLocation() %>">
                                            Table <%= t.getTableId().replace("T", "") %> (<%= t.getCapacity() %> pax)
                                        </option>
                                    <% } %>
                                </select>
                                <a href="tables" class="btn btn-outline-primary px-3 d-flex align-items-center justify-content-center"><i class="fa-solid fa-images m-0"></i></a>
                            </div>
                        <% } %>
                        <div id="capacityWarning" class="text-danger mt-2 small fw-bold" style="display: none; border-left: 3px solid #dc3545; padding-left: 10px;"></div>
                    </div>
                </div>

                <button type="submit" class="btn-confirm">Confirm Booking</button>
            </div>
        </div>

        <div class="col-lg-5">
            <div class="summary-card mb-5">
                <div class="summary-header" id="summaryHeader" style="background-image: url('images/bloom_indoor_elegance_1776880086931.png');">
                    <div class="summary-header-text">
                        <h5 class="mb-0" id="sumHeaderTitle">Bloom Main Hall</h5>
                        <small id="sumHeaderSub">Michelin-starred Experience</small>
                    </div>
                </div>
                <div class="summary-body">
                    <h6 class="fw-bold mb-4 small text-uppercase" style="letter-spacing: 1px;">Booking Summary</h6>
                    <div class="summary-row">
                        <span class="summary-label">Date & Time</span>
                        <span class="summary-value" id="sumDateTime">--- • ---</span>
                    </div>
                    <div class="summary-row">
                        <span class="summary-label">Table Type</span>
                        <span class="summary-value" id="sumTableType">--- • ---</span>
                    </div>
                    <div class="summary-row">
                        <span class="summary-label">Recommended Plan</span>
                        <span class="summary-value text-success" id="sumPlan" style="font-size: 0.85rem;">---</span>
                    </div>
                    <div class="summary-row">
                        <span class="summary-label">Reservation Fee</span>
                        <span class="summary-value">$0.00</span>
                    </div>

                    <div class="notice-box border-0 shadow-sm">
                        <i class="fa-solid fa-circle-info mt-1 text-primary"></i>
                        <div>Free cancellation until 24 hours prior to your reservation. No booking fees applied.</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </form>
</div>

<!-- Success Popup Modal -->
<div id="successModal" class="modal-overlay">
    <div class="modal-content-premium">
        <div class="modal-header-premium">
            <h2 class="modal-title-premium">Reservation Successful!</h2>
            <p class="modal-subtitle-premium">Your table at Bloom is secured.</p>
        </div>

        <div class="info-card-premium">
            <div class="mb-3">
                <div class="info-label-premium">RESTAURANT</div>
                <div class="info-value-premium">Bloom</div>
            </div>
            
            <div class="info-row-premium">
                <div class="info-item-premium">
                    <div class="info-label-premium">DATE</div>
                    <div class="info-value-premium"><i class="fa-regular fa-calendar-days me-2" style="color: #7a111e;"></i> <span id="modalDate">---</span></div>
                </div>
                <div class="info-item-premium">
                    <div class="info-label-premium">TIME</div>
                    <div class="info-value-premium"><i class="fa-regular fa-clock me-2" style="color: #7a111e;"></i> <span id="modalTime">---</span></div>
                </div>
            </div>

            <div class="info-row-premium mb-0">
                <div class="info-item-premium">
                    <div class="info-label-premium">PARTY SIZE</div>
                    <div class="info-value-premium"><i class="fa-solid fa-user-group me-2" style="color: #7a111e;"></i> <span id="modalGuests">---</span></div>
                </div>
                <div class="info-item-premium text-end">
                    <div class="info-label-premium">BOOKING ID</div>
                    <div class="fw-bold" id="modalBookingId" style="letter-spacing: 1px; color: #7a111e; font-size: 1rem;">---</div>
                </div>
            </div>
        </div>

        <img src="images/bloom_indoor_elegance_1776880086931.png" class="card-image-premium" alt="Restaurant Interior" id="modalTableImg">

        <div class="whats-next-box">
            <div class="whats-next-icon"><i class="fa-solid fa-envelope"></i></div>
            <div class="whats-next-text">
                <h6>What's Next?</h6>
                <p>We've sent a detailed confirmation to your email. You can modify or cancel this reservation up to 24 hours in advance.</p>
            </div>
        </div>

        <div class="modal-actions-premium">
            <button onclick="goToBookings()" class="btn-premium-full">View My Bookings</button>
            <button onclick="window.location.href='index.jsp'" class="btn-premium-outline">Go to Home</button>
        </div>
    </div>
</div>

<!-- Error Popup Modal -->
<div id="errorModal" class="modal-overlay">
    <div class="modal-content-premium" style="border-top: 5px solid #d9534f;">
        <div class="modal-header-premium" style="padding-bottom: 10px;">
            <div style="font-size: 3rem; color: #d9534f; margin-bottom: 15px;"><i class="fa-solid fa-circle-xmark"></i></div>
            <h2 class="modal-title-premium" style="color: #d9534f; font-size: 1.8rem;">Booking Unsuccessful</h2>
            <p class="modal-subtitle-premium" id="errorModalMessage" style="color: #444; font-size: 1.05rem; margin-top: 10px;">We couldn't process your booking.</p>
        </div>
        <div class="modal-actions-premium" style="padding-top: 20px;">
            <button type="button" onclick="closeErrorModal()" class="btn-premium-full" style="background: #333;">Close & Try Again</button>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const dateInput = document.getElementById('resDate');
        const timeSelect = document.getElementById('resTime');
        const guestSelect = document.getElementById('resGuests');
        const tableSelect = document.getElementById('resTable');
        const sumDateTime = document.getElementById('sumDateTime');
        const sumTableType = document.getElementById('sumTableType');
        const sumPlan = document.getElementById('sumPlan');

        function formatDisplayDate(dateStr) {
            if (!dateStr) return "---";
            const date = new Date(dateStr);
            if (isNaN(date.getTime())) return dateStr;
            return date.toLocaleDateString('en-GB', { day: '2-digit', month: '2-digit', year: 'numeric' });
        }

        function updateSummary() {
            const dateStr = dateInput.value;
            const formattedDate = formatDisplayDate(dateStr);
            const timeStr = timeSelect.value || "---";
            sumDateTime.innerText = formattedDate + " \u2022 " + timeStr;

            const guests = guestSelect.value;
            let tableText = "Select Table";
            let tableId = "";
            let location = "Main Hall";

            if (tableSelect.tagName === 'INPUT') {
                tableId = tableSelect.value;
                tableText = "Table " + tableId.replace('T', '');
                location = tableSelect.getAttribute('data-location') || "Main Hall";
            } else if (tableSelect.selectedIndex > 0) {
                tableId = tableSelect.value;
                const fullText = tableSelect.options[tableSelect.selectedIndex].text;
                tableText = fullText.split('(')[0].trim();
                location = tableSelect.options[tableSelect.selectedIndex].getAttribute('data-location') || "Main Hall";
            }
            
            sumTableType.innerText = tableText + " \u2022 " + guests + " Guests";

            // Update Summary Header Image and Text
            if (tableId) {
                const imgPath = "images/table_" + tableId.toLowerCase() + ".png";
                const summaryHeader = document.getElementById('summaryHeader');
                if (summaryHeader) {
                    summaryHeader.style.backgroundImage = "url('" + imgPath + "')";
                }
                
                const sumHeaderTitle = document.getElementById('sumHeaderTitle');
                if (sumHeaderTitle) {
                    sumHeaderTitle.innerText = "Bloom " + location;
                }
                
                // Update Success Modal Image
                const successImg = document.getElementById('modalTableImg');
                if (successImg) {
                    successImg.src = imgPath;
                }
            }

            let plan = "Family & Friends Banquet";
            if (guests <= 2) plan = "Romantic Evening Package";
            else if (guests <= 4) plan = "Connoisseur's Tasting Menu";
            sumPlan.innerText = plan;

            checkCapacity();
        }

        function checkCapacity() {
            const guestCount = document.getElementById('resGuests');
            const tableElem = document.getElementById('resTable');
            const warningEl = document.getElementById('capacityWarning');
            const btn = document.querySelector('.btn-confirm');

            if (!guestCount || !tableElem) return true;

            const guests = parseInt(guestCount.value) || 0;
            let capacity = 0;

            if (tableElem.tagName.toUpperCase() === 'INPUT') {
                capacity = parseInt(tableElem.getAttribute('data-pax')) || 0;
            } else if (tableElem.tagName.toUpperCase() === 'SELECT' && tableElem.selectedIndex > 0) {
                capacity = parseInt(tableElem.options[tableElem.selectedIndex].getAttribute('data-pax')) || 0;
            }

            if (capacity > 0 && guests > capacity) {
                if (warningEl) {
                    warningEl.innerHTML = '<i class="fa-solid fa-triangle-exclamation me-2"></i> This table seats a maximum of ' + capacity + ' guests. Please select a larger table or fewer guests.';
                    warningEl.style.display = 'block';
                }
                if (btn) {
                    btn.style.opacity = '0.5';
                    btn.style.cursor = 'not-allowed';
                    btn.title = "Capacity exceeded";
                }
                return false;
            } else {
                if (warningEl) {
                    warningEl.style.display = 'none';
                    warningEl.innerHTML = "";
                }
                if (btn) {
                    btn.style.opacity = '1';
                    btn.style.cursor = 'pointer';
                    btn.title = "";
                }
                return true;
            }
        }

        [dateInput, timeSelect, guestSelect, tableSelect].forEach(el => {
            if (el) {
                el.addEventListener('input', updateSummary);
                el.addEventListener('change', updateSummary);
            }
        });

        if (!dateInput.value) {
            const today = new Date();
            dateInput.value = today.toISOString().split('T')[0];
        }
        
        // Restrict to today onwards
        const todayLimit = new Date().toISOString().split('T')[0];
        dateInput.setAttribute('min', todayLimit);
        
        updateSummary();

        // AJAX Form Submission
        const form = document.getElementById('reservationForm');
        form.addEventListener('submit', function(e) {
            e.preventDefault();

            if (!checkCapacity()) {
                const warningEl = document.getElementById('capacityWarning');
                showError(warningEl.innerText);
                return;
            }

            try {
                const formData = new FormData(form);
                
                // Show loading state
                const btn = form.querySelector('.btn-confirm');
                const originalText = btn ? btn.innerText : 'Confirm Booking';
                if (btn) {
                    btn.disabled = true;
                    btn.innerText = "Processing...";
                }

                // Explicitly construct URLSearchParams to avoid browser compatibility issues
                const searchParams = new URLSearchParams();
                for (const pair of formData) {
                    searchParams.append(pair[0], pair[1]);
                }

                fetch('addReservation', {
                    method: 'POST',
                    body: searchParams
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error(`HTTP error! status: ${response.status}`);
                    }
                    return response.json();
                })
                .then(data => {
                    if (data && data.success) {
                        // Populate Modal
                        const dateStr = document.getElementById('resDate').value;
                        const dateObj = new Date(dateStr);
                        const formattedDate = dateObj.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
                        
                        document.getElementById('modalDate').innerText = formattedDate;
                        document.getElementById('modalTime').innerText = document.getElementById('resTime').value;
                        document.getElementById('modalGuests').innerText = document.getElementById('resGuests').value + " People";
                        document.getElementById('modalBookingId').innerText = data.reservationId;
                        
                        document.getElementById('successModal').classList.add('show');
                    } else {
                        showError(data ? data.message : "Reservation failed. Please try again.");
                        if (btn) {
                            btn.disabled = false;
                            btn.innerText = originalText;
                        }
                    }
                })
                .catch(error => {
                    console.error('Fetch Error Details:', error);
                    showError("Communication Error: " + error.message);
                    if (btn) {
                        btn.disabled = false;
                        btn.innerText = originalText;
                    }
                });
            } catch (err) {
                console.error('Synchronous Error:', err);
                showError('An unexpected error occurred before submitting: ' + err.message);
            }
        });
        
        // Initialize custom selects for glassmorphism dropdown menus
        document.querySelectorAll('select.form-select').forEach(function(select) {
            const wrapper = document.createElement('div');
            wrapper.className = 'custom-select-wrapper';
            select.parentNode.insertBefore(wrapper, select);
            wrapper.appendChild(select);
            
            select.style.display = 'none';
            
            const trigger = document.createElement('div');
            trigger.className = 'custom-select-trigger form-control';
            
            const selectedOpt = select.options[select.selectedIndex];
            trigger.innerHTML = '<span>' + (selectedOpt ? selectedOpt.text : '') + '</span><i class="fa-solid fa-chevron-down ms-2" style="font-size:0.8rem; color:#666;"></i>';
            wrapper.appendChild(trigger);
            
            const optionsList = document.createElement('div');
            optionsList.className = 'custom-options';
            
            Array.from(select.options).forEach(function(option, index) {
                const customOption = document.createElement('div');
                customOption.className = 'custom-option' + (option.selected ? ' selected' : '');
                customOption.textContent = option.text;
                customOption.dataset.value = option.value;
                
                customOption.addEventListener('click', function(e) {
                    e.stopPropagation();
                    select.selectedIndex = index;
                    trigger.querySelector('span').textContent = option.text;
                    
                    optionsList.querySelectorAll('.custom-option').forEach(o => o.classList.remove('selected'));
                    this.classList.add('selected');
                    
                    wrapper.classList.remove('open');
                    
                    select.dispatchEvent(new Event('change'));
                    select.dispatchEvent(new Event('input'));
                });
                optionsList.appendChild(customOption);
            });
            
            wrapper.appendChild(optionsList);
            
            trigger.addEventListener('click', function(e) {
                e.stopPropagation();
                document.querySelectorAll('.custom-select-wrapper').forEach(w => {
                    if (w !== wrapper) w.classList.remove('open');
                });
                wrapper.classList.toggle('open');
            });
        });
        
        document.addEventListener('click', function() {
            document.querySelectorAll('.custom-select-wrapper').forEach(w => w.classList.remove('open'));
        });
    });

    function goToBookings() {
        window.location.href = 'myAccount';
    }

    function closeErrorModal() {
        document.getElementById('errorModal').classList.remove('show');
    }

    function showError(msg) {
        document.getElementById('errorModalMessage').innerText = msg;
        document.getElementById('errorModal').classList.add('show');
    }
</script>

<jsp:include page="includes/footer.jsp" />
