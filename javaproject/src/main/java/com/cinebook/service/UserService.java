package com.cinebook.service;

import com.cinebook.dao.UserDAO;
import com.cinebook.model.User;

public class UserService {
    private final UserDAO userDAO = new UserDAO();

    public User login(String email, String password) {
        if (email == null || password == null) {
            return null;
        }
        return userDAO.authenticate(email.trim(), password.trim());
    }

    public boolean register(User user) {
        if (user == null || user.getEmail() == null || user.getPassword() == null) {
            return false;
        }
        // Check if email already exists
        if (userDAO.findByEmail(user.getEmail().trim()) != null) {
            return false;
        }
        return userDAO.register(user);
    }

    public User getUserById(int id) {
        return userDAO.findById(id);
    }
}
