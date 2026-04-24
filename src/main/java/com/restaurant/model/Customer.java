package com.restaurant.model;

public class Customer extends Person {
    private String customerId;

    public Customer() {
        super();
    }

    public Customer(String id, String name, String phone, String email, String customerId) {
        super(id, name, phone, email);
        this.customerId = customerId;
    }

    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    @Override
    public String getRoleDescription() {
        return "Customer: Can make and view their own reservations.";
    }
}
