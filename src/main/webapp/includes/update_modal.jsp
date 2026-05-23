<style>
    .modal-overlay {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.6);
        z-index: 9999;
        backdrop-filter: blur(8px);
        align-items: center;
        justify-content: center;
        padding: 20px;
    }

    .modal-overlay.show {
        display: flex;
    }

    .modal-content-custom {
        background: white;
        border-radius: 24px;
        max-width: 800px;
        width: 100%;
        position: relative;
        box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
        transform: translateY(20px);
        opacity: 0;
        transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
    }

    .modal-overlay.show .modal-content-custom {
        transform: translateY(0);
        opacity: 1;
    }

    .update-modal-header {
        padding: 40px 40px 20px;
        position: relative;
    }

    .update-modal-body {
        padding: 0 40px 40px;
    }

    .modal-title-custom {
        font-family: 'Playfair Display', serif;
        color: #5a0c16;
        font-size: 2.2rem;
        font-weight: 700;
        margin-bottom: 5px;
    }

    .modal-subtitle-custom {
        color: #888;
        font-size: 1rem;
        text-transform: uppercase;
        letter-spacing: 1px;
    }

    .booking-id-highlight {
        color: #7a111e;
        font-weight: 700;
    }



    .form-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 25px;
        margin-top: 30px;
    }

    .form-group-custom {
        position: relative;
    }

    .form-group-custom label {
        display: block;
        font-size: 0.85rem;
        font-weight: 700;
        color: #666;
        margin-bottom: 8px;
    }

    .input-wrapper {
        position: relative;
    }

    .input-wrapper input,
    .input-wrapper select {
        width: 100%;
        padding: 14px 45px 14px 15px;
        border: 1px solid #e0e0e0;
        border-radius: 12px;
        font-size: 1rem;
        color: #333;
        transition: all 0.3s;
        background: #fff;
    }

    .input-wrapper select {
        -webkit-appearance: none;
        -moz-appearance: none;
        appearance: none;
        background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='%23333' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
        background-repeat: no-repeat;
        background-position: right 15px center;
        background-size: 16px;
        padding-right: 40px;
    }

    .input-wrapper input:focus,
    .input-wrapper select:focus {
        border-color: #7a111e;
        outline: none;
        box-shadow: 0 0 0 4px rgba(122, 17, 30, 0.05);
    }

    .input-wrapper i {
        position: absolute;
        right: 18px;
        top: 50%;
        transform: translateY(-50%);
        color: #bbb;
        font-size: 1.1rem;
        cursor: pointer;
        pointer-events: all;
        /* Ensure click passes through if needed, but here we'll use JS to trigger picker */
        transition: color 0.3s;
    }

    .input-wrapper i:hover {
        color: #7a111e;
    }

    /* Hide browser default icons but keep picker functional */
    input::-webkit-calendar-picker-indicator {
        position: absolute;
        right: 10px;
        top: 0;
        width: 40px;
        height: 100%;
        opacity: 0;
        /* Fully transparent but covers the area */
        cursor: pointer;
    }

    .modal-footer-custom {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding-top: 30px;
        border-top: 1px solid #f0f0f0;
        margin-top: 30px;
    }

    .btn-discard {
        background: none;
        border: none;
        color: #666;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 8px;
        transition: color 0.3s;
    }

    .btn-discard:hover {
        color: #333;
    }

    .btn-update-submit {
        background: #7a111e;
        color: white;
        border: none;
        padding: 15px 35px;
        border-radius: 12px;
        font-weight: 700;
        display: flex;
        align-items: center;
        gap: 12px;
        transition: all 0.3s;
        box-shadow: 0 10px 20px rgba(122, 17, 30, 0.2);
    }

    .btn-update-submit:hover {
        background: #5a0c16;
        transform: translateY(-2px);
    }

    /* Small success modal overrides */
    .success-modal {
        max-width: 550px;
        text-align: center;
        padding: 50px 40px;
        border-radius: 20px;
    }

    .success-icon-wrapper {
        font-size: 70px;
        color: #28a745;
        margin-bottom: 20px;
        display: inline-flex;
        justify-content: center;
        align-items: center;
    }

    .success-icon-wrapper i {
        background: white;
        border-radius: 50%;
    }

    .btn-close-custom {
        background: #9b5c65;
        color: white;
        border: none;
        padding: 12px 35px;
        border-radius: 8px;
        font-weight: 700;
        font-size: 1rem;
        letter-spacing: 1px;
        transition: background 0.3s;
        text-transform: uppercase;
    }

    .btn-close-custom:hover {
        background: #7a111e;
        color: white;
    }

    @media (max-width: 768px) {
        .form-grid {
            grid-template-columns: 1fr;
        }

        .modal-content-custom {
            padding: 0;
        }
    }

    /* Custom Dropdown Styling */
    .custom-select-wrapper { position: relative; user-select: none; width: 100%; }
    .custom-select-trigger { display: flex; align-items: center; justify-content: space-between; cursor: pointer; background-color: #fff; border: 1px solid #e0e0e0; border-radius: 12px; padding: 14px 15px; color: #333; transition: all 0.3s; width: 100%; }
    .custom-select-wrapper.open .custom-select-trigger { border-color: #7a111e; box-shadow: 0 0 0 4px rgba(122, 17, 30, 0.05); }
    .custom-options { position: absolute; display: none; top: 100%; left: 0; right: 0; z-index: 1000; margin-top: 8px; background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(20px); -webkit-backdrop-filter: blur(20px); border: 1px solid rgba(0,0,0,0.1); border-radius: 12px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); overflow: hidden; max-height: 200px; overflow-y: auto; }
    .custom-options::-webkit-scrollbar { width: 6px; }
    .custom-options::-webkit-scrollbar-thumb { background: rgba(122, 17, 30, 0.3); border-radius: 3px; }
    .custom-select-wrapper.open .custom-options { display: block; animation: fadeInDown 0.2s ease-out; }
    .custom-option { padding: 12px 18px; cursor: pointer; color: #333; transition: background 0.2s; border-bottom: 1px solid rgba(0,0,0,0.05); }
    .custom-option:last-child { border-bottom: none; }
    .custom-option:hover { background: rgba(122, 17, 30, 0.08); color: #7a111e; }
    .custom-option.selected { font-weight: 600; background: rgba(122, 17, 30, 0.05); color: #7a111e; }
    @keyframes fadeInDown { from { opacity: 0; transform: translateY(-10px); } to { opacity: 1; transform: translateY(0); } }
</style>

<script>
    function openUpdateModal(id, name, phone, date, time, guests, table, status) {
        document.getElementById('displayResId').innerText = "#" + id;
        document.getElementById('inputResId').value = id;
        document.getElementById('inputName').value = name;
        document.getElementById('inputPhone').value = phone;
        document.getElementById('inputDate').value = date;
        document.getElementById('inputTime').value = time;
        document.getElementById('inputGuests').value = guests;
        document.getElementById('inputGuests').dispatchEvent(new Event('change'));
        document.getElementById('inputStatus').value = status;

        // Ensure table selection is set correctly after list is loaded
        const tableSelect = document.getElementById('inputTable');
        if (tableSelect.options.length > 0) {
            tableSelect.value = table;
            tableSelect.dispatchEvent(new Event('change'));
        } else {
            // Wait for data if using the JSON fallback
            setTimeout(() => { tableSelect.value = table; tableSelect.dispatchEvent(new Event('change')); }, 100);
        }

        document.getElementById('updateModal').classList.add('show');
    }

    function closeUpdateModal() {
        document.getElementById('updateModal').classList.remove('show');
    }

    function reloadPage() {
        window.location.href = "myAccount";
    }

    document.addEventListener("DOMContentLoaded", function () {
        // Initialize custom selects for glassmorphism dropdown menus
        document.querySelectorAll('.input-wrapper select').forEach(function(select) {
            const wrapper = document.createElement('div');
            wrapper.className = 'custom-select-wrapper';
            select.parentNode.insertBefore(wrapper, select);
            wrapper.appendChild(select);
            
            select.style.display = 'none';
            
            const trigger = document.createElement('div');
            trigger.className = 'custom-select-trigger';
            
            const selectedOpt = select.options[select.selectedIndex];
            trigger.innerHTML = '<span>' + (selectedOpt ? selectedOpt.text : '') + '</span><i class="fa-solid fa-chevron-down" style="font-size:0.9rem; color:#bbb;"></i>';
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
            
            select.addEventListener('change', function() {
                const selOpt = select.options[select.selectedIndex];
                trigger.querySelector('span').textContent = selOpt ? selOpt.text : '';
                optionsList.querySelectorAll('.custom-option').forEach(o => o.classList.remove('selected'));
                if(select.selectedIndex >= 0 && optionsList.children[select.selectedIndex]) {
                    optionsList.children[select.selectedIndex].classList.add('selected');
                }
            });
            
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

        const updateForm = document.getElementById('updateForm');
        if (updateForm) {
            updateForm.addEventListener('submit', function (e) {
                e.preventDefault();

                const formData = new URLSearchParams(new FormData(updateForm));
                const submitBtn = updateForm.querySelector('.btn-update-submit');
                const originalBtnText = submitBtn.innerHTML;
                submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Updating...';
                submitBtn.disabled = true;
                document.getElementById('updateErrorAlert').style.display = 'none';

                fetch('updateReservation', {
                    method: 'POST',
                    body: formData,
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
                })
                    .then(response => response.json())
                    .then(data => {
                        submitBtn.innerHTML = originalBtnText;
                        submitBtn.disabled = false;

                        if (data.success) {
                            closeUpdateModal();
                            document.getElementById('successTitle').innerText = "Reservation updated successfully";
                            document.getElementById('successDesc').innerText = "Your changes have been saved. We look forward to seeing you. You can modify or cancel this reservation up to 24 hours in advance.";
                            document.getElementById('successModal').classList.add('show');
                        } else {
                            const errorAlert = document.getElementById('updateErrorAlert');
                            errorAlert.innerText = data.message || "Failed to update reservation.";
                            errorAlert.style.display = 'block';
                        }
                    })
                    .catch(error => {
                        submitBtn.innerHTML = originalBtnText;
                        submitBtn.disabled = false;
                        const errorAlert = document.getElementById('updateErrorAlert');
                        errorAlert.innerText = "Network error occurred. Please try again.";
                        errorAlert.style.display = 'block';
                    });
            });
        }

        const urlParams = new URLSearchParams(window.location.search);

        if (urlParams.get('updateSuccess') === 'true') {
            document.getElementById('successTitle').innerText = "Reservation updated successfully";
            document.getElementById('successDesc').innerText = "Your changes have been saved. We look forward to seeing you. You can modify or cancel this reservation up to 24 hours in advance.";
            document.getElementById('successModal').classList.add('show');
        }

        if (urlParams.get('cancelSuccess') === 'true') {
            document.getElementById('successTitle').innerText = "Booking Cancelled";
            document.getElementById('successDesc').innerText = "Your reservation has been successfully removed.";
            const icon = document.querySelector('.success-icon-wrapper i');
            icon.classList.remove('fa-circle-check');
            icon.classList.add('fa-circle-xmark');
            icon.style.color = "#dc3545";
            document.getElementById('successModal').classList.add('show');
        }
    });

    function confirmCancel(url) {
        const modal = document.getElementById('confirmModal');
        const cancelBtn = document.getElementById('finalCancelBtn');
        modal.classList.add('show');
        cancelBtn.onclick = function () { window.location.href = url; };
    }

    function closeConfirmModal() {
        document.getElementById('confirmModal').classList.remove('show');
    }
</script>

<!-- Modify Reservation Modal -->
<div id="updateModal" class="modal-overlay">
    <div class="modal-content-custom">
        <div class="update-modal-header">
            <h2 class="modal-title-custom">Modify Reservation</h2>
            <div class="modal-subtitle-custom">Booking ID: <span id="displayResId"
                    class="booking-id-highlight">#RES-80427ED3</span></div>

        </div>
        <div class="update-modal-body">
            <div id="updateErrorAlert" class="alert alert-danger"
                style="display: none; border-radius: 12px; margin-bottom: 20px; font-weight: 500;"></div>
            <form id="updateForm" action="updateReservation" method="post">
                <input type="hidden" name="reservationId" id="inputResId">
                <input type="hidden" name="status" id="inputStatus">

                <div class="form-grid">
                    <div class="form-group-custom">
                        <label>Customer Name</label>
                        <div class="input-wrapper">
                            <input type="text" name="customerName" id="inputName" readonly>
                        </div>
                    </div>
                    <div class="form-group-custom">
                        <label>Phone Number</label>
                        <div class="input-wrapper">
                            <input type="text" name="phoneNumber" id="inputPhone" required>
                        </div>
                    </div>
                    <div class="form-group-custom">
                        <label>Date</label>
                        <div class="input-wrapper">
                            <input type="date" name="reservationDate" id="inputDate" required>
                            <i class="fa-regular fa-calendar-days"
                                onclick="document.getElementById('inputDate').showPicker()"></i>
                        </div>
                    </div>
                    <div class="form-group-custom">
                        <label>Time</label>
                        <div class="input-wrapper">
                            <input type="time" name="reservationTime" id="inputTime" required>
                            <i class="fa-regular fa-clock"
                                onclick="document.getElementById('inputTime').showPicker()"></i>
                        </div>
                    </div>
                    <div class="form-group-custom">
                        <label>Guests</label>
                        <div class="input-wrapper">
                            <select name="guestCount" id="inputGuests" required>
                                <option value="1">1 Guest</option>
                                <option value="2">2 Guests</option>
                                <option value="3">3 Guests</option>
                                <option value="4">4 Guests</option>
                                <option value="5">5 Guests</option>
                                <option value="6">6 Guests</option>
                                <option value="8">8 Guests</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group-custom">
                        <label>Select Table</label>
                        <div class="input-wrapper">
                            <select name="tableNumber" id="inputTable" required>
                                <% java.util.List<com.restaurant.model.Table> tables = (java.util.List
                                    <com.restaurant.model.Table>) request.getAttribute("tables");
                                        if (tables != null) {
                                        for (com.restaurant.model.Table t : tables) {
                                            boolean isAvailable = "Available".equalsIgnoreCase(t.getAvailabilityStatus());
                                        %>
                                        <option value="<%= t.getTableId() %>">Table <%= t.getTableId().replace("T","")
                                                %> - <%= t.getLocation() %><%= !isAvailable ? " (Not Available)" : "" %>
                                        </option>
                                        <% } } %>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="modal-footer-custom">
                    <button type="button" class="btn-discard" onclick="closeUpdateModal()">
                        <i class="fa-solid fa-xmark"></i> Discard Changes
                    </button>
                    <button type="submit" class="btn-update-submit">
                        Update Reservation <i class="fa-solid fa-circle-check"></i>
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Success Popup Modal -->
<div id="successModal" class="modal-overlay">
    <div class="modal-content-custom success-modal">
        <div class="success-icon-wrapper">
            <i class="fa-solid fa-circle-check"></i>
        </div>
        <h3 id="successTitle"
            style="font-family: 'Playfair Display'; color: #7a111e; font-size: 2rem; font-weight: 700; margin-bottom: 10px;">
            Reservation Successful!</h3>
        <p id="successDesc" style="color: #666; font-size: 1.05rem; margin-bottom: 30px;">Your table has been reserved
            successfully. We look forward to hosting you.</p>
        <button onclick="reloadPage()" class="btn-close-custom">CLOSE</button>
    </div>
</div>