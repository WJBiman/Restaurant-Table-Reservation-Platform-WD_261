package com.restaurant.service;

import com.restaurant.dao.UserDAO;
import com.restaurant.model.User;

import java.util.List;

/**
 * Service layer for User operations.
 * Coordinates between Servlets and Data Access Layer.
 */
public class UserService {
    private UserDAO userDAO;

    public UserService() {
        this.userDAO = new UserDAO();
    }

    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }

    public User getUserById(String userId) {
        return userDAO.getUserById(userId);
    }

    public boolean isUsernameTaken(String username) {
        if (username == null || username.trim().isEmpty()) {
            return false;
        }
        return getAllUsers().stream().anyMatch(u -> username.equalsIgnoreCase(u.getUsername()));
    }

    public boolean isEmailTaken(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        return getAllUsers().stream().anyMatch(u -> email.equalsIgnoreCase(u.getEmail()));
    }

    public boolean isValidPhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            return false;
        }
        // Match numbers, spaces, plus signs
        return phone.matches("^[\\d\\s\\+\\-]{7,15}$");
    }

    public boolean validateUserFields(User user) {
        if (user == null) return false;
        if (user.getUsername() == null || user.getUsername().trim().isEmpty()) return false;
        if (user.getName() == null || user.getName().trim().isEmpty()) return false;
        if (user.getEmail() == null || !user.getEmail().contains("@")) return false;
        return true;
    }

    public boolean addUser(User user) {
        User existing = getUserById(user.getId());
        if (existing != null) {
            return false;
        }
        if (!validateUserFields(user)) {
            return false;
        }
        userDAO.addUser(user);
        return true;
    }

    public boolean updateUser(User updatedUser) {
        User existing = getUserById(updatedUser.getId());
        if (existing == null) {
            return false;
        }
        if (!validateUserFields(updatedUser)) {
            return false;
        }
        userDAO.updateUser(updatedUser);
        return true;
    }

    public boolean deleteUser(String userId) {
        User existing = getUserById(userId);
        if (existing == null) {
            return false;
        }
        userDAO.deleteUser(userId);
        return true;
    }

    public List<User> getUsersByRole(String role) {
        return userDAO.getUsersByRole(role);
    }
}
