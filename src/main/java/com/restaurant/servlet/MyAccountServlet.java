package com.restaurant.servlet;

import com.restaurant.model.Reservation;
import com.restaurant.service.ReservationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/myAccount")
public class MyAccountServlet extends HttpServlet {
    private ReservationService reservationService;

    @Override
    public void init() {
        this.reservationService = new ReservationService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("customerLoggedIn") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String phone = (String) session.getAttribute("customerPhone");
        if (phone != null) phone = phone.trim();
        
        final String searchPhone = phone;
        List<Reservation> allReservations = reservationService.getAllReservations();
        List<Reservation> myReservations = allReservations.stream()
                .filter(r -> r.getPhoneNumber() != null && r.getPhoneNumber().trim().equals(searchPhone))
                .collect(Collectors.toList());
        request.setAttribute("myReservations", myReservations);
    }
}
