package com.restaurant.servlet;

import com.restaurant.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Simple validation
        if (name == null || username == null || password == null) {
            request.setAttribute("errorMessage", "All fields are required.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        com.restaurant.service.UserService userService = new com.restaurant.service.UserService();
        boolean exists = userService.getAllUsers().stream()
                .anyMatch(u -> u.getUsername().equals(username));
        if (exists) {
            request.setAttribute("errorMessage", "Username already exists.");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }
    }
}
