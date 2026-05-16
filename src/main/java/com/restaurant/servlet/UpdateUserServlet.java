package com.restaurant.servlet;

import com.restaurant.model.User;
import com.restaurant.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/updateUser")
public class UpdateUserServlet extends HttpServlet {
    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("adminLoggedIn") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String id = request.getParameter("userId");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User user = new User(id != null ? id.trim() : null, name, phone, email, username, password, role);
        boolean success = userService.updateUser(user);

        if (success) {
            response.sendRedirect("viewAllReservations");
        } else {
            request.setAttribute("errorMessage", "Failed to update user.");
            request.setAttribute("user", user);
            request.getRequestDispatcher("admin_update_user.jsp").forward(request, response);
        }
    }
}
