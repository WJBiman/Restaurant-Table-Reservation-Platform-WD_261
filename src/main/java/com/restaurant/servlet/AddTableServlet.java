package com.restaurant.servlet;

import com.restaurant.model.Table;
import com.restaurant.service.TableService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/addTable")
public class AddTableServlet extends HttpServlet {
    private TableService tableService = new TableService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("adminLoggedIn") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        request.getRequestDispatcher("admin_add_table.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("adminLoggedIn") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String tableId = request.getParameter("tableId");
        int capacity = Integer.parseInt(request.getParameter("capacity"));
        String status = request.getParameter("availabilityStatus");

        Table newTable = new Table(tableId, capacity, status);
        boolean success = tableService.addTable(newTable);

        if (success) {
            response.sendRedirect("viewAllReservations");
        } else {
            request.setAttribute("errorMessage", "Table ID already exists or failed to add.");
            request.getRequestDispatcher("admin_add_table.jsp").forward(request, response);
        }
    }
}
