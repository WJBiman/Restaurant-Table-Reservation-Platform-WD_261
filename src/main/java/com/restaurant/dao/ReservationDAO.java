package com.restaurant.dao;

import com.restaurant.model.Reservation;
import com.restaurant.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {
    public Reservation getReservationById(String reservationId) {
        String sql = "SELECT * FROM reservations WHERE reservation_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, reservationId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new Reservation(
                        rs.getString("reservation_id"),
                        rs.getString("customer_name"),
                        rs.getString("phone_number"),
                        rs.getString("reservation_date"),
                        rs.getString("reservation_time"),
                        rs.getInt("guest_count"),
                        rs.getString("table_number"),
                        rs.getString("status"),
                        rs.getString("submission_timestamp")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
