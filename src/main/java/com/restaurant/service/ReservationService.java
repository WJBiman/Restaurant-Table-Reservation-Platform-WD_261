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

    public boolean canTableAccommodate(String tableId, int guestsCount) {
        Table table = tableDAO.getAllTables().stream()
                .filter(t -> t.getTableId().equalsIgnoreCase(tableId))
                .findFirst()
                .orElse(null);
        if (table == null) {
            return false;
        }
        return table.getCapacity() >= guestsCount;
    }

    public boolean isTableReservedOnDate(String tableId, String date) {
        if (tableId == null || date == null) {
            return false;
        }
        return getAllReservations().stream()
                .anyMatch(r -> tableId.equalsIgnoreCase(r.getTableNumber()) && date.equals(r.getReservationDate()) && !"CANCELLED".equalsIgnoreCase(r.getStatus()));
    }

    public List<Reservation> getReservationsByDate(String date) {
        if (date == null || date.trim().isEmpty()) {
            return getAllReservations();
        }
        return getAllReservations().stream()
                .filter(r -> date.equals(r.getReservationDate()))
                .collect(Collectors.toList());
    }

    public boolean isValidStatusTransition(String currentStatus, String nextStatus) {
        if (currentStatus == null || nextStatus == null) return false;
        // CANCELLED status is terminal
        if ("CANCELLED".equalsIgnoreCase(currentStatus)) return false;
        return true;
    }

    public int getActiveBookingsCount() {
        return (int) getAllReservations().stream()
                .filter(r -> !"CANCELLED".equalsIgnoreCase(r.getStatus()))
                .count();
    }

    public Reservation getReservationById(String reservationId) {
        return reservationDAO.getReservationById(reservationId);
    }

    public boolean addReservation(Reservation reservation) {
        return reservationDAO.addReservation(reservation);
    }

    public boolean updateReservation(Reservation reservation) {
        return reservationDAO.updateReservation(reservation);
    }

    public boolean deleteReservation(String reservationId) {
        return reservationDAO.deleteReservation(reservationId);
    }

    public List<Reservation> searchReservation(String query) {
        if (query == null || query.trim().isEmpty()) {
            return getAllReservations();
        }
        String lowerQuery = query.toLowerCase().trim();
        return getAllReservations().stream()
                .filter(r -> (r.getReservationId() != null && r.getReservationId().toLowerCase().contains(lowerQuery)) ||
                             (r.getCustomerName() != null && r.getCustomerName().toLowerCase().contains(lowerQuery)) ||
                             (r.getPhoneNumber() != null && r.getPhoneNumber().toLowerCase().contains(lowerQuery)) ||
                             (r.getTableNumber() != null && r.getTableNumber().toLowerCase().contains(lowerQuery)))
                .collect(Collectors.toList());
    }
}
