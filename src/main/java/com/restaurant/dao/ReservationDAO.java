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

    public List<Reservation> getAllReservations() {
        List<Reservation> list = new ArrayList<>();
        String sql = "SELECT * FROM reservations ORDER BY submission_timestamp ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                list.add(new Reservation(
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
        return list;
    }

    public boolean addReservation(Reservation res) {
        String sql = "INSERT INTO reservations (reservation_id, customer_name, phone_number, reservation_date, reservation_time, guest_count, table_number, status, submission_timestamp) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, res.getReservationId());
            pstmt.setString(2, res.getCustomerName());
            pstmt.setString(3, res.getPhoneNumber());
            pstmt.setString(4, res.getReservationDate());
            pstmt.setString(5, res.getReservationTime());
            pstmt.setInt(6, res.getGuestCount());
            pstmt.setString(7, res.getTableNumber());
            pstmt.setString(8, res.getStatus());
            pstmt.setString(9, res.getSubmissionTimestamp());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateReservation(Reservation res) {
        String sql = "UPDATE reservations SET customer_name=?, phone_number=?, reservation_date=?, reservation_time=?, guest_count=?, table_number=?, status=? WHERE reservation_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, res.getCustomerName());
            pstmt.setString(2, res.getPhoneNumber());
            pstmt.setString(3, res.getReservationDate());
            pstmt.setString(4, res.getReservationTime());
            pstmt.setInt(5, res.getGuestCount());
            pstmt.setString(6, res.getTableNumber());
            pstmt.setString(7, res.getStatus());
            pstmt.setString(8, res.getReservationId());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteReservation(String reservationId) {
        String sql = "DELETE FROM reservations WHERE reservation_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, reservationId);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
