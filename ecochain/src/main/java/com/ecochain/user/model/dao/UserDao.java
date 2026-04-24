package com.ecochain.user.model.dao;

import com.ecochain.user.model.User;
import com.ecochain.utils.DbConnection;
import com.ecochain.utils.PasswordManager;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao {

    public boolean insertUser(String fullName, String email, String password, String role) throws SQLException {
        String query = "INSERT INTO users (full_name, email, password, role, status) VALUES (?,?,?,?,'pending')";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, role);
            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;
        }
    }

    public boolean emailExists(String email) throws SQLException {
        String query = "SELECT id FROM users WHERE email = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        }
    }

    public User loginUser(String email, String password) throws SQLException {
        String query = "SELECT * FROM users WHERE email = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String storedPassword = rs.getString("password");
                String role = rs.getString("role");
                String status = rs.getString("status");

                // use PasswordManager for all users including admin
                boolean passwordMatch = PasswordManager.checkPassword(password, storedPassword);

                if (passwordMatch) {
                    int id = rs.getInt("id");
                    String fullName = rs.getString("full_name");
                    return new User(id, fullName, email, storedPassword, role, status);
                }
            }
            return null;
        }
    }

    public boolean installAdmin() throws SQLException {
        // Check if admin already exists
        String checkSql = "SELECT id FROM users WHERE role = 'admin' LIMIT 1";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(checkSql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return false; // admin already exists
            }
        }

        // Insert admin with hashed password
        String insertSql = "INSERT INTO users (full_name, email, password, role, status) VALUES (?, ?, ?, 'admin', 'active')";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(insertSql)) {
            ps.setString(1, "Admin");
            ps.setString(2, "admin@ecochain.com");
            ps.setString(3, PasswordManager.hashPassword("admin123"));
            return ps.executeUpdate() > 0;
        }
    }
}