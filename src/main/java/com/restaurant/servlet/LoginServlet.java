package com.restaurant.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        // Hardcoded admin
        if ("admin".equals(user) && "admin123".equals(pass)) {
            HttpSession session = request.getSession();
            session.setAttribute("adminLoggedIn", true);
            response.sendRedirect("viewAllReservations");
            return;
        }

        // Check against Database
        com.restaurant.service.UserService userService = new com.restaurant.service.UserService();
        com.restaurant.model.User matchedUser = userService.getAllUsers().stream()
                .filter(u -> u.getUsername().equals(user) && u.getPassword().equals(pass))
                .findFirst()
                .orElse(null);
        
        if (matchedUser != null) {
            HttpSession session = request.getSession();
            if ("ADMIN".equalsIgnoreCase(matchedUser.getRole())) {
                session.setAttribute("adminLoggedIn", true);
                response.sendRedirect("viewAllReservations");
            } else {
                session.setAttribute("customerLoggedIn", true);
                session.setAttribute("customerUsername", matchedUser.getUsername());
                session.setAttribute("customerName", matchedUser.getName());
                session.setAttribute("customerPhone", matchedUser.getPhone());
                session.setAttribute("customerEmail", matchedUser.getEmail());
                response.sendRedirect("myAccount");
            }
        } else {
            request.setAttribute("errorMessage", "Invalid username or password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
