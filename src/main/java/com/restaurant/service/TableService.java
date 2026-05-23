package com.restaurant.service;

import com.restaurant.dao.TableDAO;
import com.restaurant.model.Table;

import java.util.List;

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
