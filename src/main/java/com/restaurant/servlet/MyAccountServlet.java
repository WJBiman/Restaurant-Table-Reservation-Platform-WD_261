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
        
        String searchQuery = request.getParameter("searchQuery");
        if (searchQuery != null) searchQuery = searchQuery.trim();

        final String searchPhone = phone;
        final String finalSearchQuery = searchQuery;
        
        List<Reservation> allReservations = reservationService.getAllReservations();
        List<Reservation> myReservations = allReservations.stream()
                .filter(r -> r.getPhoneNumber() != null && r.getPhoneNumber().trim().equals(searchPhone))
                .filter(r -> {
                    if (finalSearchQuery == null || finalSearchQuery.isEmpty()) return true;
                    return r.getReservationId().toLowerCase().contains(finalSearchQuery.toLowerCase());
                })
                .collect(Collectors.toList());

        List<com.restaurant.model.Table> tables = new com.restaurant.service.TableService().getAllTables();
        request.setAttribute("tables", tables);
        request.setAttribute("myReservations", myReservations);
        request.getRequestDispatcher("my_reservations.jsp").forward(request, response);
    }
}
