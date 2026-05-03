package com.ecochain.pickup.model.dao;

import com.ecochain.pickup.model.Pickup;
import com.ecochain.utils.DbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class PickupDao {
    public static boolean insertPickup(Pickup pickup) throws SQLException {
        String query = "INSERT INTO pickups (listing_id, org_id, quantity, pickup_time, status, notes) VALUES (?,?,?,?,?,?)";
        try (Connection conn = DbConnection.getConnection();
             PreparedStatement st = conn.prepareStatement(query)) {
            st.setInt(1, pickup.getListingId());
            st.setInt(2, pickup.getOrgId());
            st.setDouble(3, pickup.getQuantity());
            st.setTimestamp(4, pickup.getPickupTime());
            st.setString(5, pickup.getStatus());
            st.setString(6, pickup.getNotes());
            int rowsInserted = st.executeUpdate();

            if (rowsInserted > 0) {
                String updateListing = "UPDATE listings SET status = 'requested' WHERE id = ?";
                try (PreparedStatement ps = conn.prepareStatement(updateListing)) {
                    ps.setInt(1, pickup.getListingId());
                    ps.executeUpdate();
                }
                return true;
            }
        }
        return false;
    }
}
