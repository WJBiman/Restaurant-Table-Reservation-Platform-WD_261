package com.restaurant.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import com.restaurant.util.DBConnection;

@WebServlet("/clearCancelledReservations")
public class ClearCancelledReservationsServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("adminLoggedIn") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String sql = "DELETE FROM reservations WHERE status = 'Cancelled'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            int deletedCount = pstmt.executeUpdate();
            request.getSession().setAttribute("successMessage", deletedCount + " cancelled reservations cleared permanently.");
        } catch (SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Error clearing cancelled reservations: " + e.getMessage());
        }

        response.sendRedirect("viewAllReservations");
    }
}
