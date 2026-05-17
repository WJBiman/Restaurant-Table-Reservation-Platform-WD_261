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
</style>

<div id="updateModal" class="modal-overlay">
    <div class="modal-content-custom">
        <div class="update-modal-header">
            <h2 class="modal-title-custom">Modify Reservation</h2>
            <div class="modal-subtitle-custom">Booking ID: <span id="displayResId" class="booking-id-highlight">#RES-80427ED3</span></div>
        </div>
        <div class="update-modal-body">
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
                </div>
            </form>
        </div>
    </div>
</div>