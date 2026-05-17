package com.restaurant.servlet;

import com.restaurant.model.Table;
import com.restaurant.service.TableService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/updateTable")
public class UpdateTableServlet extends HttpServlet {
    private TableService tableService = new TableService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("adminLoggedIn") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String id = request.getParameter("id");
        Table table = tableService.getTableById(id);
        if (table != null) {
            request.setAttribute("table", table);
            request.getRequestDispatcher("admin_update_table.jsp").forward(request, response);
        } else {
            response.sendRedirect("viewAllReservations");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("adminLoggedIn") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    }
}
