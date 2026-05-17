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
        try {
            this.reservationService = new ReservationService();
        } catch (Exception e) {
            System.err.println("[ERROR] Failed to initialize reservation service in MyAccountServlet: " + e.getMessage());
            e.printStackTrace();
        }
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
        if (phone == null && email == null) {
            request.setAttribute("errorMessage", "Session attributes are missing. Please re-login.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        
        final String searchPhone = phone != null ? phone.trim() : "";
        final String searchEmail = email != null ? email.trim() : "";
        
        List<Reservation> myReservations = reservationService.getAllReservations().stream()
                .filter(r -> (!searchPhone.isEmpty() && r.getPhoneNumber() != null && r.getPhoneNumber().trim().equals(searchPhone)) || (!searchEmail.isEmpty() && r.getEmail() != null && r.getEmail().trim().equalsIgnoreCase(searchEmail)))
                .sorted(Comparator.comparing(Reservation::getReservationDate, Comparator.nullsLast(Comparator.reverseOrder())))
                .limit(50) // Safeguard maximum records displayed in dashboard
                .collect(Collectors.toList());

        long activeCount = myReservations.stream().filter(r -> !"CANCELLED".equalsIgnoreCase(r.getStatus())).count();
        long cancelledCount = myReservations.stream().filter(r -> "CANCELLED".equalsIgnoreCase(r.getStatus())).count();
        
        // Log diagnostics details for session validation
        System.out.println("[DIAGNOSTIC] Loaded myAccount dashboard for user: " + session.getAttribute("customerUsername") + " | Active reservations: " + activeCount);

        request.setAttribute("activeReservationsCount", activeCount);
        request.setAttribute("cancelledReservationsCount", cancelledCount);

        List<com.restaurant.model.Table> tables = new com.restaurant.service.TableService().getAllTables();
        request.setAttribute("tables", tables);
        request.setAttribute("myReservations", myReservations);
        request.getRequestDispatcher("my_reservations.jsp").forward(request, response);
    }
}
