package com.restaurant.dao;

import com.restaurant.model.Reservation;
import com.restaurant.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {
    public List<Reservation> getAllReservations() {
        List<Reservation> reservations = new ArrayList<>();
        String sql = "SELECT * FROM reservations ORDER BY submission_timestamp ASC";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                reservations.add(new Reservation(
                    rs.getString("reservation_id"),
                    rs.getString("customer_name"),
                    rs.getString("phone_number"),
                    rs.getString("reservation_date"),
                    rs.getString("reservation_time"),
                    rs.getInt("guest_count"),
                    rs.getString("table_number"),
                    rs.getString("status"),
                    rs.getString("submission_timestamp")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reservations;
    }
}
