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
import java.util.UUID;

@WebServlet("/addReservation")
public class AddReservationServlet extends HttpServlet {
    private ReservationService reservationService = new ReservationService();
    private TableDAO tableDAO = new TableDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        try {
            String id = "RES-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
            String name = request.getParameter("customerName");
            String phone = request.getParameter("phoneNumber");
            
            HttpSession session = request.getSession();
            if (session.getAttribute("customerLoggedIn") != null) {
                String sessionName = (String) session.getAttribute("customerName");
                String sessionPhone = (String) session.getAttribute("customerPhone");
                if (sessionName != null && !sessionName.isEmpty()) name = sessionName;
                if (sessionPhone != null && !sessionPhone.isEmpty()) phone = sessionPhone;
            }
            
            String date = request.getParameter("reservationDate");
            String time = request.getParameter("reservationTime");
            String guestsStr = request.getParameter("guestCount");
            int guests = (guestsStr != null) ? Integer.parseInt(guestsStr) : 2;
            String table = request.getParameter("tableNumber");
            String status = "Pending";
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"message\": \"Server Error: " + e.getMessage() + "\"}");
        }
    }
}
