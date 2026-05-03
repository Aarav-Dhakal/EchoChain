<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.ecochain.user.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.getRole().equals("admin")) {
        response.sendRedirect("/login");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
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
        .stats {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 30px;
        }
        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            text-align: center;
        }
        .stat-card h3 { font-size: 36px; color: #2e7d32; }
        .stat-card p { color: #666; font-size: 14px; margin-top: 8px; }
        .quick-links {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }
        .quick-link-card {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background: #2e7d32;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            margin-top: 10px;
        }
    </style>
</head>
<body>
<div class="navbar">
    <h1>🌿 EcoChain Admin</h1>
    <div>
        <a href="/admin/dashboard">Dashboard</a>
        <a href="/admin/users">Users</a>
        <a href="/admin/categories">Categories</a>
        <a href="/logout">Logout</a>
    </div>
</div>
<div class="container">
    <h2>Welcome, <%= user.getFullName() %>!</h2>
    <div class="stats">
        <div class="stat-card">
            <h3><%= request.getAttribute("totalUsers") %></h3>
            <p>Total Users</p>
        </div>
        <div class="stat-card">
            <h3><%= request.getAttribute("pendingUsers") %></h3>
            <p>Pending Approvals</p>
        </div>
        <div class="stat-card">
            <h3><%= request.getAttribute("totalListings") %></h3>
            <p>Total Listings</p>
        </div>
        <div class="stat-card">
            <h3><%= request.getAttribute("totalPickups") %></h3>
            <p>Completed Pickups</p>
        </div>
    </div>
    <div class="quick-links">
        <div class="quick-link-card">
            <h3>User Management</h3>
            <p>Approve, suspend or delete accounts.</p>
            <a href="/admin/users" class="btn">Manage Users</a>
        </div>
        <div class="quick-link-card">
            <h3>Category Management</h3>
            <p>Add or remove food categories.</p>
            <a href="/admin/categories" class="btn">Manage Categories</a>
        </div>
    </div>
</div>
</body>
</html>