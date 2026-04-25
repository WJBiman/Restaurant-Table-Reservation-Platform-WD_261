package com.restaurant.model;

public class Table {
    private String tableId;
    private int capacity;
    private String availabilityStatus;
    private String location;

    public Table() {
    }

    public Table(String tableId, int capacity, String availabilityStatus) {
        this.tableId = tableId;
        this.capacity = capacity;
        this.availabilityStatus = availabilityStatus;
        this.location = "Main Dining"; // Default
    }

    public Table(String tableId, int capacity, String availabilityStatus, String location) {
        this.tableId = tableId;
        this.capacity = capacity;
        this.availabilityStatus = availabilityStatus;
        this.location = location;
    }

    public String getTableId() {
        return tableId;
    }

    public void setTableId(String tableId) {
        this.tableId = tableId;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public String getAvailabilityStatus() {
        return availabilityStatus;
    }

    public void setAvailabilityStatus(String availabilityStatus) {
        this.availabilityStatus = availabilityStatus;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }
}
