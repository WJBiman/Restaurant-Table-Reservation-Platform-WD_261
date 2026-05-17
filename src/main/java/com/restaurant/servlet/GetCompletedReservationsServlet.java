package com.restaurant.servlet;

import com.restaurant.model.Reservation;
import com.restaurant.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/getCompletedReservations")
public class GetCompletedReservationsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("adminLoggedIn") == null) {
            response.setStatus(401);
            return;
        }

        List<Reservation> completed = new ArrayList<>();
        String sql = "SELECT * FROM completed_reservations ORDER BY completed_at DESC";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                completed.add(new Reservation(
                    rs.getString("reservation_id"),
                    rs.getString("customer_name"),
                    rs.getString("phone_number"),
                    rs.getString("reservation_date"),
                    rs.getString("reservation_time"),
                    rs.getInt("guest_count"),
                    rs.getString("table_number"),
                    "Completed",
                    rs.getString("submission_timestamp")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Return as JSON or just handle in JS. For simplicity, we'll return a simple HTML snippet
        StringBuilder html = new StringBuilder();
        if (completed.isEmpty()) {
            html.append("<tr><td colspan='8' class='text-center text-muted py-5'>No completed reservations found in archive.</td></tr>");
        } else {
            for (Reservation r : completed) {
                html.append("<tr class='align-middle status-row' data-status='Completed'>");
                html.append("<td class='text-muted small'>#").append(r.getReservationId()).append("</td>");
                html.append("<td><div class='d-flex align-items-center'>");
                html.append("<div class='rounded-circle bg-light d-flex align-items-center justify-content-center me-3' style='width: 32px; height: 32px; font-size: 0.8rem; color: #7a111e; font-weight: 700;'>");
                html.append(r.getCustomerName().substring(0, 1).toUpperCase());
                html.append("</div><span class='fw-bold'>").append(r.getCustomerName()).append("</span></div></td>");
                html.append("<td><div>").append(r.getReservationDate()).append("</div><small class='text-muted'>").append(r.getReservationTime()).append("</small></td>");
                html.append("<td><i class='fa-solid fa-user-group me-2 small text-muted'></i>").append(r.getGuestCount()).append("</td>");
                html.append("<td>Table ").append(r.getTableNumber().replace("T", "")).append("</td>");
                html.append("<td class='small text-muted'>---</td>");
                html.append("<td><span class='status-badge-custom' style='background: rgba(46, 125, 50, 0.1); color: #2e7d32; padding: 6px 12px; border-radius: 20px; font-size: 0.75rem; font-weight: 600;'><span style='display:inline-block; width:6px; height:6px; background:#2e7d32; border-radius:50%; margin-right:5px; vertical-align:middle;'></span> Completed</span></td>");
                html.append("<td class='text-end'><span class='text-muted small'><i class='fa-solid fa-archive'></i> Archived</span></td>");
                html.append("</tr>");
            }
        }
        
        response.setContentType("text/html");
        response.getWriter().write(html.toString());
    }
}
