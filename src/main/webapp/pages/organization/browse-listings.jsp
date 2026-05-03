<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.ecochain.user.model.User" %>
<%@ page import="com.ecochain.listing.model.Listing" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.getRole().equals("organization")) {
        response.sendRedirect("/login");
        return;
    }
    List<Listing> listings = (List<Listing>) request.getAttribute("listings");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Browse Listings</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f0f4f0; }
        .navbar {
            background: #2e7d32;
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
        }
        .navbar h1 { font-size: 22px; }
        .navbar a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
            font-size: 14px;
        }
        .container { padding: 30px; }
        h2 { color: #2e7d32; margin-bottom: 25px; }
        .listings-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }
        .listing-card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .listing-card h3 { color: #2e7d32; margin-bottom: 10px; }
        .listing-card p { color: #666; font-size: 14px; margin-bottom: 8px; }
        .badge {
            display: inline-block;
            padding: 4px 10px;
            background: #e8f5e9;
            color: #2e7d32;
            border-radius: 20px;
            font-size: 12px;
            margin-bottom: 10px;
        }
        .btn {
            padding: 8px 16px;
            background: #2e7d32;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
        }
    </style>
</head>
<body>
<div class="navbar">
    <h1>🌿 EcoChain Organization</h1>
    <div>
        <a href="/organization/dashboard">Dashboard</a>
        <a href="/organization/browse">Browse Listings</a>
        <a href="/logout">Logout</a>
    </div>
</div>
<div class="container">
    <h2>Available Food Listings</h2>
    <div class="listings-grid">
        <% if (listings != null && !listings.isEmpty()) {
            for (Listing l : listings) { %>
        <div class="listing-card">
            <span class="badge"><%= l.getCategoryName() %></span>
            <h3><%= l.getFoodName() %></h3>
            <p><strong>Quantity:</strong> <%= l.getQuantity() %> <%= l.getUnit() %></p>
            <p><strong>Expiry:</strong> <%= l.getExpiryDate() %></p>
            <% if (l.getStorageNotes() != null && !l.getStorageNotes().isEmpty()) { %>
            <p><strong>Storage:</strong> <%= l.getStorageNotes() %></p>
            <% } %>
            <% if (l.getAllergens() != null && !l.getAllergens().isEmpty()) { %>
            <p><strong>Allergens:</strong> <%= l.getAllergens() %></p>
            <% } %>
            <form action="/pickup/request" method="post" style="margin-top: 10px;">
                <input type="hidden" name="action" value="requestPickup"/>
                <input type="hidden" name="listingId" value="<%= l.getId() %>"/>
                <button type="submit" class="btn">Request Pickup</button>
            </form>
        </div>
        <% } } else { %>
        <p style="color:#666;">No listings available at the moment.</p>
        <% } %>
    </div>
</div>
</body>
</html>