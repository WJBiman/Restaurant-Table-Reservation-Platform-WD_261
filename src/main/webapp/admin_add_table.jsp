<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.restaurant.model.Table" %>
<% 
    if (session.getAttribute("adminLoggedIn") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    Table t = (Table) request.getAttribute("table");
    boolean isEdit = (t != null);
    
    String tableId = isEdit ? t.getTableId() : "";
    String capacity = isEdit ? String.valueOf(t.getCapacity()) : "4";
    String location = isEdit ? t.getLocation() : "Main Dining";
    boolean isAvailable = isEdit ? "Available".equalsIgnoreCase(t.getAvailabilityStatus()) : true;
%>
<jsp:include page="includes/admin_header.jsp" />
<script>document.getElementById('admin-nav-tables').classList.add('active');</script>

<style>
    .config-card {
        background: white;
        border-radius: 12px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.08);
        overflow: hidden;
        max-width: 700px;
        margin: 0 auto;
    }
    .config-header {
        background: #7a111e;
        padding: 40px;
        position: relative;
    }
    .config-badge {
        background: #e6c86a;
        color: #7a111e;
        font-weight: 800;
        font-size: 0.7rem;
        letter-spacing: 1px;
        padding: 6px 12px;
        border-radius: 20px;
        text-transform: uppercase;
    }
    .config-body {
        padding: 40px;
    }
    .image-upload-area {
        border: 2px dashed #ddd;
        border-radius: 8px;
        padding: 40px;
        text-align: center;
        background: #fafafa;
        cursor: pointer;
        transition: all 0.3s;
        position: relative;
    }
    .image-upload-area:hover {
        border-color: #7a111e;
        background: #fff;
    }
    .file-input {
        position: absolute;
        top: 0; left: 0; width: 100%; height: 100%;
        opacity: 0;
        cursor: pointer;
    }
    .form-control, .form-select {
        border: 1px solid #ddd;
        border-radius: 8px;
        padding: 12px 15px;
        font-size: 0.95rem;
    }
    .form-control:focus, .form-select:focus {
        border-color: #7a111e;
        box-shadow: 0 0 0 0.25rem rgba(122, 17, 30, 0.1);
    }
    /* Custom Toggle Switch */
    .switch {
        position: relative;
        display: inline-block;
        width: 50px;
        height: 24px;
    }
    .switch input { 
        opacity: 0;
        width: 0;
        height: 0;
    }
    .slider {
        position: absolute;
        cursor: pointer;
        top: 0; left: 0; right: 0; bottom: 0;
        background-color: #ccc;
        transition: .4s;
        border-radius: 34px;
    }
    .slider:before {
        position: absolute;
        content: "";
        height: 18px;
        width: 18px;
        left: 3px;
        bottom: 3px;
        background-color: white;
        transition: .4s;
        border-radius: 50%;
    }
    input:checked + .slider {
        background-color: #7a111e;
    }
    input:checked + .slider:before {
        transform: translateX(26px);
    }
</style>

<main class="container-fluid py-4">
    <div style="max-width: 700px; margin: 0 auto 30px;">
        <div class="text-muted small mb-2 text-uppercase fw-bold" style="letter-spacing: 1px; font-size: 0.75rem;">
            Admin / Floor Plan / <span class="text-maroon"><%= isEdit ? "EDIT TABLE" : "ADD TABLE" %></span>
        </div>
        <h2 style="font-family: 'Playfair Display'; color: #7a111e; font-weight: 700;">Configure <%= isEdit ? "Table" : "New Table" %></h2>
    </div>

    <div class="config-card">
        <div class="config-header">
            <span class="config-badge">CONFIGURATION PHASE</span>
            <div style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; background: radial-gradient(circle at right top, rgba(255,255,255,0.1), transparent); pointer-events: none;"></div>
        </div>
        
        <div class="config-body">
            <form action="adminTablePost" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="action" value="<%= isEdit ? "edit" : "add" %>">
                
                <div class="mb-4">
                    <label class="form-label fw-bold small text-dark mb-3">Table Image</label>
                    <div class="image-upload-area" id="uploadArea">
                        <i class="fa-solid fa-camera mb-3 text-muted" style="font-size: 2rem;"></i>
                        <h6 class="fw-bold mb-1 text-dark">Add Photo</h6>
                        <p class="small text-muted mb-0 fw-bold" style="letter-spacing: 1px;">JPG, PNG OR GIF (MAX. 2MB)</p>
                        <input type="file" name="tableImage" class="file-input" accept="image/*" id="fileInput">
                        <div id="fileName" class="mt-2 text-maroon small fw-bold" style="display:none;"></div>
                    </div>
                </div>

                <div class="row g-4 mb-4">
                    <div class="col-md-6">
                        <label class="form-label fw-bold small text-dark">Table Number / Name</label>
                        <input type="text" name="tableId" class="form-control" placeholder="e.g., Table 12 or Terrace-01" value="<%= tableId %>" <%= isEdit ? "readonly" : "required" %>>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-bold small text-dark">Seating Capacity</label>
                        <div class="position-relative">
                            <input type="number" name="capacity" class="form-control pe-5" min="1" value="<%= capacity %>" required>
                            <i class="fa-solid fa-user-group position-absolute text-muted" style="top: 50%; right: 15px; transform: translateY(-50%);"></i>
                        </div>
                    </div>
                </div>

                <div class="mb-5">
                    <label class="form-label fw-bold small text-dark">Location / Section</label>
                    <select name="location" class="form-select">
                        <option value="Main Dining" <%= "Main Dining".equals(location) ? "selected" : "" %>>Main Dining Room</option>
                        <option value="Terrace" <%= "Terrace".equals(location) ? "selected" : "" %>>Terrace</option>
                        <option value="Chef's Table" <%= "Chef's Table".equals(location) ? "selected" : "" %>>Chef's Table</option>
                        <option value="Bar Area" <%= "Bar Area".equals(location) ? "selected" : "" %>>Bar Area</option>
                    </select>
                </div>

                <div class="d-flex justify-content-between align-items-center mb-5 pb-3 border-bottom">
                    <div>
                        <h5 class="fw-bold mb-1" style="font-family: 'Playfair Display';">Initial Status</h5>
                        <p class="small text-muted mb-0">Should this table be immediately open for bookings?</p>
                    </div>
                    <div class="d-flex align-items-center gap-3">
                        <label class="switch">
                            <input type="checkbox" name="availabilityStatus" value="Available" <%= isAvailable ? "checked" : "" %>>
                            <span class="slider"></span>
                        </label>
                        <span class="fw-bold text-maroon text-uppercase small" style="letter-spacing: 1px;">Available</span>
                    </div>
                </div>

                <div class="d-flex justify-content-end align-items-center gap-4">
                    <a href="adminTables" class="text-muted text-decoration-none small fw-bold">Cancel</a>
                    <button type="submit" class="btn btn-primary" style="background: #7a111e; border: none; border-radius: 8px; padding: 12px 30px; font-weight: 600;">
                        <i class="fa-solid fa-circle-plus me-2"></i> <%= isEdit ? "Save Changes" : "Add Table" %>
                    </button>
                </div>
            </form>
        </div>
    </div>
</main>

<script>
    document.getElementById('fileInput').addEventListener('change', function(e) {
        if(e.target.files.length > 0) {
            const name = e.target.files[0].name;
            const size = (e.target.files[0].size / (1024*1024)).toFixed(2);
            const fileNameDiv = document.getElementById('fileName');
            fileNameDiv.innerText = "Selected: " + name + " (" + size + "MB)";
            fileNameDiv.style.display = 'block';
        }
    });
</script>

<jsp:include page="includes/admin_footer.jsp" />
