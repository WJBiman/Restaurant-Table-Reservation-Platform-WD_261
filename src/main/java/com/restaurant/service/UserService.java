package com.restaurant.service;

import com.restaurant.dao.UserDAO;
import com.restaurant.model.User;

import java.util.List;

public class UserService {
    private UserDAO userDAO;

    public UserService() {
        this.userDAO = new UserDAO();
    }
}
