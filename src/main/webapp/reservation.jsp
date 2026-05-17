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
    </style>
</head>
<body>

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
                </div>
            </div>
        </div>
    </div>
    </form>
</div>

</body>
</html>
