package com.restaurant.servlet;

import com.restaurant.service.ReservationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/viewAllReservations")
public class ViewAllReservationsServlet extends HttpServlet {
    private ReservationService reservationService = new ReservationService();
}
