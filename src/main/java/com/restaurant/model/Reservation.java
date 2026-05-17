package com.restaurant.model;

public class Reservation {
    private String reservationId;
    private String customerName;
    private String phoneNumber;
    private String reservationDate;
    private String reservationTime;
    private int guestCount;
    private String tableNumber;
    private String status;
    private String submissionTimestamp;

    public Reservation() {
    }

    public Reservation(String reservationId, String customerName, String phoneNumber, String reservationDate,
                       String reservationTime, int guestCount, String tableNumber, String status, String submissionTimestamp) {
        this.reservationId = reservationId;
        this.customerName = customerName;
        this.phoneNumber = phoneNumber;
        this.reservationDate = reservationDate;
        this.reservationTime = reservationTime;
        this.guestCount = guestCount;
        this.tableNumber = tableNumber;
        this.status = status;
        this.submissionTimestamp = submissionTimestamp;
    }

    public String getReservationId() {
        return reservationId;
    }

    public void setReservationId(String reservationId) {
        this.reservationId = reservationId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getReservationDate() {
        return reservationDate;
    }

    public void setReservationDate(String reservationDate) {
        this.reservationDate = reservationDate;
    }

    public String getReservationTime() {
        return reservationTime;
    }

    public void setReservationTime(String reservationTime) {
        this.reservationTime = reservationTime;
    }

    public int getGuestCount() {
        return guestCount;
    }

    public void setGuestCount(int guestCount) {
        this.guestCount = guestCount;
    }

    public String getTableNumber() {
        return tableNumber;
    }

    public void setTableNumber(String tableNumber) {
        this.tableNumber = tableNumber;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    public String getSubmissionTimestamp() {
        return submissionTimestamp;
    }

    public void setSubmissionTimestamp(String submissionTimestamp) {
        this.submissionTimestamp = submissionTimestamp;
    }
    @Override
    public String toString() {
        return String.join(",", reservationId, customerName, phoneNumber, reservationDate,
                reservationTime, String.valueOf(guestCount), tableNumber, status, submissionTimestamp != null ? submissionTimestamp : "---");
    }
}
