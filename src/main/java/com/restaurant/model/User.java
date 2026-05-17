package com.restaurant.model;

public class User extends Person {
    private String username;
    private String password;
    private String role; // "ADMIN" or "CUSTOMER"

    public User(String id, String name, String phone, String email, String username, String password, String role) {
        super(id, name, phone, email);
        this.username = username;
        this.password = password;
        this.role = role;
    }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    @Override
    public String getRoleDescription() {
        return "User Role: " + role;
    }
}
