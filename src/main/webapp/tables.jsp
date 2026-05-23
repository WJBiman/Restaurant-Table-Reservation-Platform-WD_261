<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.restaurant.model.Table" %>
<%@ page import="com.restaurant.dao.TableDAO" %>
<jsp:include page="includes/header.jsp" />

<head>
    <title>Bloom - Our Tables</title>
    <style>
        body {
            background: url('images/tablepage_bg.png') no-repeat center center fixed;
            background-size: cover;
            margin: 0;
            padding: 0;
        }
        .tables-hero {
            padding: 80px 0 40px;
            text-align: center;
        }
        .tables-hero h2 {
            font-family: 'Playfair Display', serif;
            color: #7a111e;
            font-size: 3rem;
            margin-bottom: 15px;
            font-weight: 700;
        }
        .table-card {
            background: rgba(255, 255, 255, 0.25); /* More transparent for deeper effect */
            backdrop-filter: blur(25px) saturate(200%);
            -webkit-backdrop-filter: blur(25px) saturate(200%);
            border: 1px solid rgba(255, 255, 255, 0.5); 
            border-top: 1px solid rgba(255, 255, 255, 0.8); /* "Shine" from top */
            border-left: 1px solid rgba(255, 255, 255, 0.8); 
            border-radius: 32px; /* Softer, more organic corners */
            overflow: hidden;
            box-shadow: 
                0 20px 50px rgba(0,0,0,0.1), 
                inset 0 0 80px rgba(255, 255, 255, 0.1),
                inset 0 0 1px 1px rgba(255, 255, 255, 0.5); /* Internal glass edge */
            transition: all 0.6s cubic-bezier(0.16, 1, 0.3, 1);
            margin-bottom: 30px;
            height: 100%;
            display: flex;
            flex-direction: column;
            position: relative;
        }
        .table-card:hover {
            transform: translateY(-12px);
            box-shadow: 0 30px 60px rgba(122, 17, 30, 0.12), 0 0 20px rgba(122, 17, 30, 0.03);
            background: rgba(255, 255, 255, 0.85); /* Smoothly becomes more opaque on hover */
            border-color: rgba(122, 17, 30, 0.15);
        }
        .table-img-wrapper {
            position: relative;
            height: 220px;
            overflow: hidden;
        }
        .table-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.6s ease;
        }
        .table-card:hover .table-img {
            transform: scale(1.05);
        }
        .table-info {
            padding: 25px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }
        .table-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            color: #1a1a1a;
            margin-bottom: 8px;
            font-weight: 700;
        }
        .table-location {
            font-size: 0.8rem;
            color: #7a111e;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 15px;
        }
        .table-meta {
            color: #666;
            font-size: 0.95rem;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .status-pill {
            padding: 4px 12px;
            border-radius: 50px;
            font-size: 0.7rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .status-available { background: rgba(40, 167, 69, 0.1); color: #28a745; border: 1px solid rgba(40, 167, 69, 0.2); }
        .status-occupied { background: rgba(211, 47, 47, 0.1); color: #d32f2f; border: 1px solid rgba(211, 47, 47, 0.2); }
        .btn-reserve {
            border-radius: 12px;
            font-weight: 600;
            padding: 16px 12px;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 0.85rem;
            border: none;
        }
        .btn-available { background: #800020; color: white; }
        .btn-available:hover { background: #680018; color: white; transform: translateY(-2px); }
        .btn-unavailable { background: #f4f4f4; color: #666; border: 1px solid #ddd; }
    </style>
</head>

<div class="container pb-5">
    <div class="tables-hero">
        <h2>Our Curated Dining Spaces</h2>
        <p class="text-muted">Discover the perfect setting for your next culinary journey.</p>
    </div>

    <div class="row g-4">
        <%
            TableDAO tableDAO = new TableDAO();
            List<Table> tables = tableDAO.getAllTables();
            if (tables != null) {
                for (Table t : tables) {
                    String tableId = t.getTableId();
                    String imgPath = "images/table_" + tableId.toLowerCase() + ".png";
                    boolean isAvailable = "Available".equalsIgnoreCase(t.getAvailabilityStatus());
        %>
        <div class="col-md-4">
            <div class="table-card">
                <div class="table-img-wrapper">
                    <img src="<%= imgPath %>" class="table-img" alt="Table <%= tableId %>" onerror="this.src='images/bloom_indoor_elegance_1776880086931.png'">
                </div>
                <div class="table-info">
                    <h4 class="table-title">Table <%= tableId.replace("T", "") %></h4>
                    <div class="table-location"><%= t.getLocation() %></div>
                    
                    <div class="table-meta">
                        <div class="d-flex align-items-center gap-2">
                            <i class="fa-solid fa-user-group text-muted"></i>
                            <span>Seats <b><%= t.getCapacity() %></b></span>
                        </div>
                        <span class="status-pill <%= isAvailable ? "status-available" : "status-occupied" %>">
                            <%= isAvailable ? "Available" : "Not Available" %>
                        </span>
                    </div>

                    <div class="mt-auto">
                        <% if (isAvailable) { %>
                            <a href="reservation.jsp?tableId=<%= tableId %>" class="btn btn-available w-100">Reserve Table</a>
                        <% } else { %>
                            <button type="button" class="btn btn-unavailable w-100" onclick="showUnavailableModal()">Not Available</button>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
        <%      } 
            } %>
    </div>
</div>

<!-- Custom Unavailable Modal -->
<div id="unavailableModal" class="custom-modal-overlay" style="display: none;">
    <div class="custom-modal-content">
        <div class="text-center mb-4">
            <h4 style="font-family: 'Playfair Display'; color: #7a111e;">Table Unavailable</h4>
            <p class="text-muted">This table is currently not available for bookings. Please select another table.</p>
        </div>
        <div class="text-center">
            <button onclick="closeUnavailableModal()" class="btn btn-available" style="width: 100%;">OK</button>
        </div>
    </div>
</div>

<style>
    .custom-modal-overlay {
        position: fixed; top: 0; left: 0; width: 100%; height: 100%;
        background: rgba(0,0,0,0.5); display: flex; align-items: center; justify-content: center; z-index: 9999;
    }
    .custom-modal-content {
        background: white; border-radius: 20px; padding: 40px; width: 100%; max-width: 400px;
        box-shadow: 0 15px 35px rgba(0,0,0,0.2);
    }
</style>

<script>
    function showUnavailableModal() { document.getElementById('unavailableModal').style.display = 'flex'; }
    function closeUnavailableModal() { document.getElementById('unavailableModal').style.display = 'none'; }
    document.getElementById('nav-tables').classList.add('active');
</script>

<jsp:include page="includes/footer.jsp" />
