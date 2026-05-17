package com.restaurant.servlet;

import com.restaurant.service.TableService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deleteTable")
public class DeleteTableServlet extends HttpServlet {
    private TableService tableService = new TableService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("adminLoggedIn") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String id = request.getParameter("id");
        if (id != null) {
            tableService.deleteTable(id);
        }
        response.sendRedirect("viewAllReservations");
    }
}
