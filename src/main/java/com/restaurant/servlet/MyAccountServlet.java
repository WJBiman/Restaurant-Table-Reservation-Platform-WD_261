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
import java.util.Comparator;
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
        String email = (String) session.getAttribute("customerEmail");
        final String searchPhone = phone != null ? phone.trim() : null;
        final String searchEmail = email != null ? email.trim() : null;
        
        List<Reservation> myReservations = reservationService.getAllReservations().stream()
                .filter(r -> (r.getPhoneNumber() != null && r.getPhoneNumber().trim().equals(searchPhone)) || (r.getEmail() != null && r.getEmail().trim().equalsIgnoreCase(searchEmail)))
                .sorted(Comparator.comparing(Reservation::getReservationDate, Comparator.nullsLast(Comparator.reverseOrder())))
                .limit(50) // Safeguard maximum records displayed in dashboard
                .collect(Collectors.toList());

        long activeCount = myReservations.stream().filter(r -> !"CANCELLED".equalsIgnoreCase(r.getStatus())).count();
        long cancelledCount = myReservations.stream().filter(r -> "CANCELLED".equalsIgnoreCase(r.getStatus())).count();
        
        request.setAttribute("activeReservationsCount", activeCount);
        request.setAttribute("cancelledReservationsCount", cancelledCount);

        List<com.restaurant.model.Table> tables = new com.restaurant.service.TableService().getAllTables();
        request.setAttribute("tables", tables);
        request.setAttribute("myReservations", myReservations);
        request.getRequestDispatcher("my_reservations.jsp").forward(request, response);
    }
}
