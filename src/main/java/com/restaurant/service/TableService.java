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
}
