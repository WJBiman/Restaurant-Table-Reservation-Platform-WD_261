package com.restaurant.servlet;

import com.restaurant.model.Reservation;
import com.restaurant.model.Table;
import com.restaurant.service.ReservationService;
import com.restaurant.service.TableService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDate;


@WebServlet("/updateReservation")
public class UpdateReservationServlet extends HttpServlet {
    private ReservationService reservationService = new ReservationService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        boolean isAdmin = session.getAttribute("adminLoggedIn") != null;
        boolean isCustomer = session.getAttribute("customerLoggedIn") != null;

        if (!isAdmin && !isCustomer) {
            response.sendRedirect("login.jsp");
            return;
        }

        response.sendRedirect(isAdmin ? "viewAllReservations" : "myAccount");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        boolean isAdmin = request.getSession().getAttribute("adminLoggedIn") != null;
        boolean isCustomer = request.getSession().getAttribute("customerLoggedIn") != null;

        if (!isAdmin && !isCustomer) {
            response.getWriter().write("{\"success\": false, \"message\": \"Authentication required.\"}");
            return;
        }

        String id = request.getParameter("reservationId");
        String name = request.getParameter("customerName");
        String phone = request.getParameter("phoneNumber");
        String date = request.getParameter("reservationDate");
        String time = request.getParameter("reservationTime");
        int guests = Integer.parseInt(request.getParameter("guestCount"));
        String table = request.getParameter("tableNumber");
        String status = request.getParameter("status");

        Reservation existing = reservationService.getReservationById(id);
        if (existing != null && "Cancelled".equalsIgnoreCase(existing.getStatus())) {
            response.getWriter().write("{\"success\": false, \"message\": \"Cannot update a cancelled reservation.\"}");
            return;
        }

        Reservation reservation = new Reservation(id != null ? id.trim() : null, name, phone, date, time, guests, table, status, null);

        // Validate that the date is not in the past
        try {
            LocalDate resDate = LocalDate.parse(date);
            if (resDate.isBefore(LocalDate.now())) {
                response.getWriter().write("{\"success\": false, \"message\": \"Cannot update to a date in the past.\"}");
                return;
            }
        } catch (Exception e) {}
        
        // Validate table capacity and status
        Table selectedTable = new TableService().getTableById(table);
        if (selectedTable == null) {
            response.getWriter().write("{\"success\": false, \"message\": \"Selected table does not exist.\"}");
            return;
        }

        if (!"Available".equalsIgnoreCase(selectedTable.getAvailabilityStatus())) {
            response.getWriter().write("{\"success\": false, \"message\": \"Table " + table.replace("T", "") + " is currently Not Available for service. Please choose an available table.\"}");
            return;
        }

        if (guests > selectedTable.getCapacity()) {
            response.getWriter().write("{\"success\": false, \"message\": \"Guest count (" + guests + ") exceeds the capacity of Table " + table.replace("T", "") + ".\"}");
            return;
        }

        boolean success = reservationService.updateReservation(reservation);
        
        if (success) {
            response.getWriter().write("{\"success\": true}");
        } else {
            response.getWriter().write("{\"success\": false, \"message\": \"Failed to update reservation. Please check table availability.\"}");
        }
    }
}
