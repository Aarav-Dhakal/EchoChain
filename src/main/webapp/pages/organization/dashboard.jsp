<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.ecochain.user.model.User" %>
<%@ page import="com.ecochain.organization.model.Organization" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.getRole().equals("organization")) {
        response.sendRedirect("/login");
        return;
    }
    Organization org = (Organization) request.getAttribute("org");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Organization Dashboard</title>
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
            grid-template-columns: repeat(3, 1fr);
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
    <h1>🌿 EcoChain Organization</h1>
    <div>
        <a href="/organization/dashboard">Dashboard</a>
        <a href="/organization/browse">Browse Listings</a>
        <a href="/logout">Logout</a>
    </div>
</div>
<div class="container">
    <h2>Welcome, <%= org.getOrgName() %>!</h2>
    <div class="stats">
        <div class="stat-card">
            <h3><%= request.getAttribute("totalRequests") %></h3>
            <p>Total Requests</p>
        </div>
        <div class="stat-card">
            <h3><%= request.getAttribute("completedPickups") %></h3>
            <p>Completed Pickups</p>
        </div>
        <div class="stat-card">
            <h3><%= String.format("%.2f", org.getTotalFoodReceived()) %> kg</h3>
            <p>Total Food Received</p>
        </div>
    </div>
    <div class="quick-links">
        <div class="quick-link-card">
            <h3>Browse Listings</h3>
            <p>Find available food donations.</p>
            <a href="/organization/browse" class="btn">Browse</a>
        </div>
    </div>
</div>
</body>
</html>