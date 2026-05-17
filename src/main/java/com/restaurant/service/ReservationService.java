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
                .anyMatch(r -> tableId.equalsIgnoreCase(r.getTableId()) && date.equals(r.getReservationDate()) && !"CANCELLED".equalsIgnoreCase(r.getStatus()));
    }

    public List<Reservation> getReservationsByDate(String date) {
        if (date == null || date.trim().isEmpty()) {
            return getAllReservations();
        }
        return getAllReservations().stream()
                .filter(r -> date.equals(r.getReservationDate()))
                .collect(Collectors.toList());
    }
}
