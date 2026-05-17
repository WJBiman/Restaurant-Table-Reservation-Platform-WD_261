package com.restaurant.servlet;

import com.restaurant.model.Reservation;
import com.restaurant.service.ReservationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/searchReservation")
public class SearchReservationServlet extends HttpServlet {
    private ReservationService reservationService = new ReservationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");
        List<Reservation> results = reservationService.searchReservation(query);
        
        request.setAttribute("reservations", results);
        request.getRequestDispatcher("search.jsp").forward(request, response);
    }
}
