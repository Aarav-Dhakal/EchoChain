<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.ecochain.user.model.User" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.getRole().equals("admin")) {
        response.sendRedirect("/login");
        return;
    }
    List<String> categories = (List<String>) request.getAttribute("categories");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Category Management</title>
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
        .add-form {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        .add-form input {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            margin-right: 10px;
            width: 300px;
        }
        .btn-add {
            padding: 10px 20px;
            background: #2e7d32;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }
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
        .btn-delete {
            padding: 6px 12px;
            background: #c62828;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
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
    <h2>Category Management</h2>
    <div class="add-form">
        <form action="/admin/categories" method="post">
            <input type="hidden" name="action" value="addCategory"/>
            <input type="text" name="name" placeholder="Category name" required/>
            <button type="submit" class="btn-add">Add Category</button>
        </form>
    </div>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Action</th>
        </tr>
        <% if (categories != null && !categories.isEmpty()) {
            for (String cat : categories) {
                String[] parts = cat.split(":");
                int id = Integer.parseInt(parts[0]);
                String name = parts[1];
        %>
        <tr>
            <td><%= id %></td>
            <td><%= name %></td>
            <td>
                <form action="/admin/categories" method="post" style="display:inline">
                    <input type="hidden" name="action" value="deleteCategory"/>
                    <input type="hidden" name="categoryId" value="<%= id %>"/>
                    <button type="submit" class="btn-delete"
                            onclick="return confirm('Delete?')">Delete</button>
                </form>
            </td>
        </tr>
        <% } } %>
    </table>
</div>
</body>
</html>