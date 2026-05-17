package com.restaurant.service;

import com.restaurant.dao.TableDAO;
import com.restaurant.model.Table;

import java.util.List;
import java.util.stream.Collectors;

public class TableService {
    private TableDAO tableDAO;

    public TableService() {
        this.tableDAO = new TableDAO();
    }

    public List<Table> getAllTables() {
        return tableDAO.getAllTables();
    }

    public Table getTableById(String tableId) {
        return tableDAO.getTableById(tableId);
    }

    public boolean addTable(Table table) {
        Table existing = getTableById(table.getTableId());
        if (existing != null) {
            return false;
        }
        tableDAO.addTable(table);
        return true;
    }

    public boolean updateTable(Table updatedTable) {
        Table existing = getTableById(updatedTable.getTableId());
        if (existing == null) {
            return false;
        }
        tableDAO.updateTable(updatedTable);
        return true;
    }

    public boolean isValidCapacity(int capacity) {
        return capacity >= 2 && capacity <= 20;
    }

    public int getOccupiedTablesCount() {
        return (int) getAllTables().stream()
                .filter(t -> "Occupied".equalsIgnoreCase(t.getAvailabilityStatus()))
                .count();
    }

    public List<Table> getTablesByLocation(String location) {
        if (location == null || location.trim().isEmpty()) {
            return getAllTables();
        }
        return getAllTables().stream()
                .filter(t -> location.equalsIgnoreCase(t.getLocation()))
                .collect(Collectors.toList());
    }

    public boolean deleteTable(String tableId) {
        Table existing = getTableById(tableId);
        if (existing == null) {
            return false;
        }
        try {
            tableDAO.deleteTable(tableId);
            return true;
        } catch (java.sql.SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
