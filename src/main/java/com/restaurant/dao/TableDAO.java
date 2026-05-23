package com.restaurant.dao;

import com.restaurant.model.Table;
import com.restaurant.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TableDAO {
    public List<Table> getAllTables() {
        List<Table> tables = new ArrayList<>();
        String sql = "SELECT * FROM restaurant_tables";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                tables.add(new Table(
                    rs.getString("table_id"),
                    rs.getInt("capacity"),
                    rs.getString("availability_status"),
                    rs.getString("location")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tables;
    }

    public void addTable(Table table) {
        String sql = "INSERT INTO restaurant_tables (table_id, capacity, availability_status, location) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, table.getTableId());
            pstmt.setInt(2, table.getCapacity());
            pstmt.setString(3, table.getAvailabilityStatus());
            pstmt.setString(4, table.getLocation());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateTable(Table table) {
        String sql = "UPDATE restaurant_tables SET capacity=?, availability_status=?, location=? WHERE table_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, table.getCapacity());
            pstmt.setString(2, table.getAvailabilityStatus());
            pstmt.setString(3, table.getLocation());
            pstmt.setString(4, table.getTableId());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteTable(String tableId) throws SQLException {
        String sql = "DELETE FROM restaurant_tables WHERE table_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, tableId);
            pstmt.executeUpdate();
        }
    }

    public Table getTableById(String tableId) {
        String sql = "SELECT * FROM restaurant_tables WHERE table_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, tableId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new Table(
                        rs.getString("table_id"),
                        rs.getInt("capacity"),
                        rs.getString("availability_status"),
                        rs.getString("location")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
