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
}
