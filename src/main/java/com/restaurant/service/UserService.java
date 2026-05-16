package com.restaurant.service;

import com.restaurant.dao.UserDAO;
import com.restaurant.model.User;

import java.util.List;

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

    public boolean addUser(User user) {
        User existing = getUserById(user.getId());
        if (existing != null) {
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
