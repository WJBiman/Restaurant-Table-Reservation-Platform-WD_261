package com.restaurant.servlet;

import com.restaurant.model.Reservation;
import com.restaurant.service.ReservationService;
import com.restaurant.model.Table;
import com.restaurant.dao.TableDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/addReservation")
public class AddReservationServlet extends HttpServlet {
    private ReservationService reservationService = new ReservationService();
    private TableDAO tableDAO = new TableDAO();
}
