package com.restaurant.servlet;

import com.restaurant.service.ReservationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Comparator;
import java.util.stream.Collectors;

@WebServlet("/viewAllReservations")
public class ViewAllReservationsServlet extends HttpServlet {
    private ReservationService reservationService = new ReservationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("adminLoggedIn") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Sort reservations chronologically descending for admin view
        request.setAttribute("reservations", reservationService.getAllReservations().stream()
                .sorted(Comparator.comparing(com.restaurant.model.Reservation::getReservationDate, Comparator.nullsLast(Comparator.reverseOrder())))
                .collect(Collectors.toList()));
                
        request.setAttribute("tables", reservationService.getAvailableTables());
        
        com.restaurant.service.UserService userService = new com.restaurant.service.UserService();
        request.setAttribute("users", userService.getAllUsers());
        
        com.restaurant.service.TableService tableService = new com.restaurant.service.TableService();
        
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

        // Fetch total registered customers count
        long customerCount = userService.getAllUsers().stream()
                .filter(u -> "CUSTOMER".equalsIgnoreCase(u.getRole()))
                .count();
        request.setAttribute("customerCount", customerCount);

        // Fetch total tables count
        long tablesCount = tableService.getAllTables().size();
        request.setAttribute("tablesCount", tablesCount);

        // Fetch occupied tables count
        long occupiedTablesCount = tableService.getAllTables().stream()
                .filter(t -> "Occupied".equalsIgnoreCase(t.getAvailabilityStatus()))
                .count();
        request.setAttribute("occupiedTablesCount", occupiedTablesCount);

        request.getRequestDispatcher("admin.jsp").forward(request, response);
    }
}
