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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("adminLoggedIn") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String id = request.getParameter("id");
        User user = userService.getUserById(id);
        if (user != null) {
            request.setAttribute("user", user);
            request.getRequestDispatcher("admin_update_user.jsp").forward(request, response);
        } else {
            response.sendRedirect("viewAllReservations");
        }
    }
}
