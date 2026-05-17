package com.restaurant.servlet;

import com.restaurant.service.ReservationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deleteReservation")
public class DeleteReservationServlet extends HttpServlet {
    private ReservationService reservationService = new ReservationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean isAdmin = request.getSession().getAttribute("adminLoggedIn") != null;
        boolean isCustomer = request.getSession().getAttribute("customerLoggedIn") != null;

        if (!isAdmin && !isCustomer) {
            response.sendRedirect("login.jsp");
            return;
        }

        String id = request.getParameter("id");
        if (id != null && !id.trim().isEmpty()) {
            com.restaurant.model.Reservation res = reservationService.getReservationById(id);
            if (res != null && !"Cancelled".equalsIgnoreCase(res.getStatus())) {
                reservationService.deleteReservation(id);
            }
        }

        if (isAdmin) {
            response.sendRedirect("viewAllReservations");
        } else {
            response.sendRedirect("myAccount?cancelSuccess=true");
        }
    }
}
