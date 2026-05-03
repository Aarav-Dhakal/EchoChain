<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.ecochain.user.model.User" %>
<%@ page import="com.ecochain.admin.model.Admin" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.getRole().equals("admin")) {
        response.sendRedirect("/login");
        return;
    }
    List<Admin> users = (List<Admin>) request.getAttribute("users");
%>
<!DOCTYPE html>
<html>
<head>
    <title>User Management</title>
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
        table {
            width: 100%;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            border-collapse: collapse;
        }
        th {
            background: #2e7d32;
            color: white;
            padding: 14px;
            text-align: left;
        }
        td {
            padding: 12px 14px;
            border-bottom: 1px solid #eee;
        }
        .badge {
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
        }
        .badge-pending { background: #fff8e1; color: #f57f17; }
        .badge-active { background: #e8f5e9; color: #2e7d32; }
        .badge-suspended { background: #ffebee; color: #c62828; }
        .btn {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
            color: white;
            margin-right: 4px;
        }
        .btn-approve { background: #2e7d32; }
        .btn-suspend { background: #f57f17; }
        .btn-delete { background: #c62828; }
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
    <h2>User Management</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Role</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        <% if (users != null && !users.isEmpty()) {
            for (Admin u : users) { %>
        <tr>
            <td><%= u.getId() %></td>
            <td><%= u.getFullName() %></td>
            <td><%= u.getEmail() %></td>
            <td><%= u.getRole() %></td>
            <td><span class="badge badge-<%= u.getStatus() %>"><%= u.getStatus() %></span></td>
            <td>
                <% if (u.getStatus().equals("pending") || u.getStatus().equals("suspended")) { %>
                <form action="/admin/users" method="post" style="display:inline">
                    <input type="hidden" name="action" value="approve"/>
                    <input type="hidden" name="userId" value="<%= u.getId() %>"/>
                    <button type="submit" class="btn btn-approve">Approve</button>
                </form>
                <% } %>
                <% if (u.getStatus().equals("active")) { %>
                <form action="/admin/users" method="post" style="display:inline">
                    <input type="hidden" name="action" value="suspend"/>
                    <input type="hidden" name="userId" value="<%= u.getId() %>"/>
                    <button type="submit" class="btn btn-suspend">Suspend</button>
                </form>
                <% } %>
                <form action="/admin/users" method="post" style="display:inline">
                    <input type="hidden" name="action" value="delete"/>
                    <input type="hidden" name="userId" value="<%= u.getId() %>"/>
                    <button type="submit" class="btn btn-delete"
                            onclick="return confirm('Delete this user?')">Delete</button>
                </form>
            </td>
        </tr>
        <% } } %>
    </table>
</div>
</body>
</html>