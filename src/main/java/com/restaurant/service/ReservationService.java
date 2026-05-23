package com.restaurant.service;

import com.restaurant.dao.ReservationDAO;
import com.restaurant.dao.TableDAO;
import com.restaurant.model.Reservation;
import com.restaurant.model.Table;

import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

public class ReservationService {
    private ReservationDAO reservationDAO;
    private TableDAO tableDAO;

    public ReservationService() {
        this.reservationDAO = new ReservationDAO();
        this.tableDAO = new TableDAO();
    }

    public boolean addReservation(Reservation reservation) {
        // Validate table existence and capacity
        Table selectedTable = tableDAO.getTableById(reservation.getTableNumber());
        if (selectedTable == null) return false;
        
        if (!"Available".equalsIgnoreCase(selectedTable.getAvailabilityStatus())) {
            return false; // Table is marked as Not Available
        }
        
        if (selectedTable.getCapacity() < reservation.getGuestCount()) {
            return false; // Insufficient capacity
        }

        List<Reservation> existingReservations = reservationDAO.getAllReservations();

        // Validate table availability for the exact date and time
        boolean isBooked = existingReservations.stream()
                .anyMatch(r -> r.getTableNumber().equals(reservation.getTableNumber()) &&
                               r.getReservationDate().equals(reservation.getReservationDate()) &&
                               r.getReservationTime().equals(reservation.getReservationTime()));
        
        if (isBooked) {
            return false; // Table is already booked for this time
        }

        // Validate uniqueness of reservation ID
        boolean exists = existingReservations.stream()
                .anyMatch(r -> r.getReservationId().equals(reservation.getReservationId()));
        if (exists) {
            return false;
        }

        // Add reservation
        reservationDAO.addReservation(reservation);

        return true;
    }

    public List<Reservation> searchReservation(String query) {
        List<Reservation> all = reservationDAO.getAllReservations();
        if (query == null || query.trim().isEmpty()) {
            return all;
        }
        return all.stream()
                .filter(r -> r.getReservationId().equalsIgnoreCase(query) || r.getCustomerName().toLowerCase().contains(query.toLowerCase()))
                .collect(Collectors.toList());
    }

    public Reservation getReservationById(String reservationId) {
        return reservationDAO.getReservationById(reservationId);
    }

    public boolean updateReservation(Reservation updatedReservation) {
        Reservation existing = getReservationById(updatedReservation.getReservationId());
        if (existing == null) {
            return false;
        }

        // Validate table existence and capacity
        Table selectedTable = tableDAO.getTableById(updatedReservation.getTableNumber());
        if (selectedTable == null) return false;

        // Block if table is Not Available, unless it's already assigned to THIS reservation
        // and we are just updating other details (though even then, it's safer to block).
        // User requested to prevent updates TO an unavailable table.
        if (!"Available".equalsIgnoreCase(selectedTable.getAvailabilityStatus())) {
             // If it's a DIFFERENT table than current, definitely block.
             // If it's the SAME table, but now it's unavailable, we still block to force a move.
             return false; 
        }

        if (selectedTable.getCapacity() < updatedReservation.getGuestCount()) {
            return false; // Insufficient capacity
        }

        // Check if the updated table/date/time conflicts with ANY OTHER reservation
        List<Reservation> existingReservations = reservationDAO.getAllReservations();
        boolean isBooked = existingReservations.stream()
                .anyMatch(r -> !r.getReservationId().trim().equals(updatedReservation.getReservationId().trim()) &&
                               r.getTableNumber().equals(updatedReservation.getTableNumber()) &&
                               r.getReservationDate().equals(updatedReservation.getReservationDate()) &&
                               r.getReservationTime().equals(updatedReservation.getReservationTime()));
                               
        if (isBooked) {
            return false; // The new time slot is already taken by someone else
        }

        reservationDAO.updateReservation(updatedReservation);
        return true;
    }

    public boolean deleteReservation(String reservationId) {
        Reservation existing = getReservationById(reservationId);
        if (existing == null) {
            return false;
        }
        existing.setStatus("Cancelled");
        reservationDAO.updateReservation(existing);
        return true;
    }


    public List<Reservation> getAllReservations() {
        return reservationDAO.getAllReservations().stream()
                .sorted(Comparator.comparing(Reservation::getSubmissionTimestamp, Comparator.nullsFirst(Comparator.naturalOrder())))
                .collect(Collectors.toList());
    }

    public List<Table> getAvailableTables() {
        return tableDAO.getAllTables().stream()
                .filter(t -> "Available".equalsIgnoreCase(t.getAvailabilityStatus()))
                .collect(Collectors.toList());
    }
}
