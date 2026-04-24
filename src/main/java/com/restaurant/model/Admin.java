package com.restaurant.model;

public class Admin extends Person {
    private String role;

    public Admin() {
        super();
    }

    public Admin(String id, String name, String phone, String email, String role) {
        super(id, name, phone, email);
        this.role = role;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Override
    public String getRoleDescription() {
        return "Admin: Has full access to manage all reservations and tables.";
    }
}
