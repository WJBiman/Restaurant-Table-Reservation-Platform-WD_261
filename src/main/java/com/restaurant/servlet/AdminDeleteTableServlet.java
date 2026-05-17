package com.restaurant.servlet;

import com.restaurant.dao.TableDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/adminDeleteTable")
public class AdminDeleteTableServlet extends HttpServlet {
    private TableDAO tableDAO = new TableDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminLoggedIn") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String tableId = request.getParameter("id");
        if (tableId != null && !tableId.isEmpty()) {
            try {
                tableDAO.deleteTable(tableId);
                session.setAttribute("successMessage", "Table " + tableId + " removed successfully.");
            } catch (Exception e) {
                session.setAttribute("errorMessage", "Cannot remove Table " + tableId + ". It might have active reservations.");
            }
        }

        response.sendRedirect("adminTables");
    }
}
