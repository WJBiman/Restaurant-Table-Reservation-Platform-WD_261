package com.restaurant.servlet;

import com.restaurant.dao.ReservationDAO;
import com.restaurant.model.Reservation;
import com.restaurant.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/completeReservation")
public class CompleteReservationServlet extends HttpServlet {
    private ReservationDAO reservationDAO = new ReservationDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("adminLoggedIn") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String reservationId = request.getParameter("id");
        if (reservationId != null && !reservationId.isEmpty()) {
            Reservation res = reservationDAO.getReservationById(reservationId);
            if (res != null) {
                String insertSql = "INSERT INTO completed_reservations (reservation_id, customer_name, phone_number, reservation_date, reservation_time, guest_count, table_number, status, submission_timestamp) VALUES (?, ?, ?, ?, ?, ?, ?, 'Completed', ?)";
                String deleteSql = "DELETE FROM reservations WHERE reservation_id = ?";

                try (Connection conn = DBConnection.getConnection()) {
                    conn.setAutoCommit(false);
                    try {
                        // 1. Copy to completed_reservations
                        try (PreparedStatement pstmt = conn.prepareStatement(insertSql)) {
                            pstmt.setString(1, res.getReservationId());
                            pstmt.setString(2, res.getCustomerName());
                            pstmt.setString(3, res.getPhoneNumber());
                            pstmt.setString(4, res.getReservationDate());
                            pstmt.setString(5, res.getReservationTime());
                            pstmt.setInt(6, res.getGuestCount());
                            pstmt.setString(7, res.getTableNumber());
                            pstmt.setString(8, res.getSubmissionTimestamp());
                            pstmt.executeUpdate();
                        }

                        // 2. Remove from active reservations
                        try (PreparedStatement pstmt = conn.prepareStatement(deleteSql)) {
                            pstmt.setString(1, res.getReservationId());
                            pstmt.executeUpdate();
                        }

                        conn.commit();
                        request.getSession().setAttribute("successMessage", "Reservation #" + reservationId + " marked as completed and archived.");
                    } catch (SQLException e) {
                        conn.rollback();
                        throw e;
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    request.getSession().setAttribute("errorMessage", "Error completing reservation: " + e.getMessage());
                }
            }
        }

        response.sendRedirect("viewAllReservations");
    }
}
