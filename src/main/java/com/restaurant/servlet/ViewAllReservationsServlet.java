package com.restaurant.servlet;

import com.restaurant.service.ReservationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/viewAllReservations")
public class ViewAllReservationsServlet extends HttpServlet {
    private ReservationService reservationService = new ReservationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("adminLoggedIn") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        request.setAttribute("reservations", reservationService.getAllReservations());
        request.setAttribute("tables", reservationService.getAvailableTables());
        request.setAttribute("users", new com.restaurant.service.UserService().getAllUsers());
        
        // Fetch completed count
        int completedCount = 0;
        try (java.sql.Connection conn = com.restaurant.util.DBConnection.getConnection();
             java.sql.PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM completed_reservations");
             java.sql.ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) completedCount = rs.getInt(1);
        } catch (java.sql.SQLException e) {
            System.err.println("[ADMIN ERROR] Failed to fetch completed reservations count: " + e.getMessage());
            e.printStackTrace();
        }
        request.setAttribute("completedCount", completedCount);

        // Fetch active reservations count
        long activeCount = reservationService.getAllReservations().stream()
                .filter(r -> !"CANCELLED".equalsIgnoreCase(r.getStatus()))
                .count();
        request.setAttribute("activeCount", activeCount);

        request.getRequestDispatcher("admin.jsp").forward(request, response);
    }
}
