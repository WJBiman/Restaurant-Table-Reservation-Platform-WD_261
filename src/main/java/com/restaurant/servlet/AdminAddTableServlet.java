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

@WebServlet("/adminAddTable")
public class AdminAddTableServlet extends HttpServlet {
    private TableDAO tableDAO = new TableDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminLoggedIn") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String editId = request.getParameter("edit");
        if (editId != null && !editId.isEmpty()) {
            Table existingTable = tableDAO.getTableById(editId);
            if (existingTable != null) {
                request.setAttribute("table", existingTable);
            }
        }

        request.getRequestDispatcher("/admin_add_table.jsp").forward(request, response);
    }
}
