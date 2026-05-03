package com.ecochain.listing.model.dao;

import com.ecochain.listing.model.Listing;
import com.ecochain.utils.DbConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ListingDao {
    public static boolean insertListing(Listing listing) throws SQLException {
        String query = "INSERT INTO listings (donor_id, category_id, food_name, quantity, unit, expiry_date, storage_notes, allergens, status) VALUES (?,?,?,?,?,?,?,?,'available')";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, listing.getDonorId());
            st.setInt(2, listing.getCategoryId());
            st.setString(3, listing.getFoodName());
            st.setDouble(4, listing.getQuantity());
            st.setString(5, listing.getUnit());
            st.setDate(6, (Date) listing.getExpiryDate());
            st.setString(7, listing.getStorageNotes());
            st.setString(8, listing.getAllergens());
            int rowsInserted = st.executeUpdate();
            return rowsInserted > 0;
        }
    }

    public static List<Listing> fetchListingsByDonorId(int donorId) throws SQLException {
        String query = "SELECT l.*, c.name as category_name FROM listings l JOIN categories c ON l.category_id = c.id WHERE l.donor_id = ? ORDER BY l.created_at DESC";
        List<Listing> listings = new ArrayList<>();
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, donorId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Listing listing = new Listing();
                listing.setId(rs.getInt("id"));
                listing.setDonorId(rs.getInt("donor_id"));
                listing.setCategoryId(rs.getInt("category_id"));
                listing.setFoodName(rs.getString("food_name"));
                listing.setQuantity(rs.getDouble("quantity"));
                listing.setUnit(rs.getString("unit"));
                listing.setExpiryDate(rs.getDate("expiry_date"));
                listing.setStorageNotes(rs.getString("storage_notes"));
                listing.setAllergens(rs.getString("allergens"));
                listing.setStatus(rs.getString("status"));
                listing.setCategoryName(rs.getString("category_name"));
                listings.add(listing);
            }
        }
        return listings;
    }

    public static List<Listing> fetchAllAvailableListings() throws SQLException {
        String query = "SELECT l.*, c.name as category_name FROM listings l JOIN categories c ON l.category_id = c.id WHERE l.status = 'available' ORDER BY l.created_at DESC";
        List<Listing> listings = new ArrayList<>();
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Listing listing = new Listing();
                listing.setId(rs.getInt("id"));
                listing.setDonorId(rs.getInt("donor_id"));
                listing.setCategoryId(rs.getInt("category_id"));
                listing.setFoodName(rs.getString("food_name"));
                listing.setQuantity(rs.getDouble("quantity"));
                listing.setUnit(rs.getString("unit"));
                listing.setExpiryDate(rs.getDate("expiry_date"));
                listing.setStorageNotes(rs.getString("storage_notes"));
                listing.setAllergens(rs.getString("allergens"));
                listing.setStatus(rs.getString("status"));
                listing.setCategoryName(rs.getString("category_name"));
                listings.add(listing);
            }
        }
        return listings;
    }

    public static boolean deleteListing(int listingId) throws SQLException {
        String query = "DELETE FROM listings WHERE id = ?";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, listingId);
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        }
    }

    public static List<String> fetchAllCategories() throws SQLException {
        String query = "SELECT * FROM categories";
        List<String> categories = new ArrayList<>();
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                categories.add(id + ":" + name);
            }
        }
        return categories;
    }
}
