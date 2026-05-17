package com.restaurant.servlet;

import com.restaurant.dao.TableDAO;
import com.restaurant.model.Table;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/adminTables")
public class AdminTablesServlet extends HttpServlet {
    private TableDAO tableDAO = new TableDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminLoggedIn") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Table> tables = tableDAO.getAllTables();
        
        int totalTables = 0;
        int totalCapacity = 0;
        int availableTables = 0;
        int occupiedTables = 0;
        
        if (tables != null) {
            totalTables = tables.size();
            for (Table t : tables) {
                totalCapacity += t.getCapacity();
                if ("Available".equalsIgnoreCase(t.getAvailabilityStatus())) {
                    availableTables++;
                } else {
                    occupiedTables++;
                }
            }
        }
        
        request.setAttribute("tables", tables);
        request.setAttribute("totalTables", totalTables);
        request.setAttribute("totalCapacity", totalCapacity);
        request.setAttribute("availableTables", availableTables);
        request.setAttribute("occupiedTables", occupiedTables);
        
        request.getRequestDispatcher("/admin_tables.jsp").forward(request, response);
    }
}
