<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.ecochain.user.model.User" %>
<%
  User user = (User) session.getAttribute("user");
  if (user == null || !user.getRole().equals("organization")) {
    response.sendRedirect("/login");
    return;
  }
%>
<!DOCTYPE html>
<html>
<head>
  <title>Complete Profile</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: Arial, sans-serif;
      background: #f0f4f0;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
    }
    .container {
      background: white;
      padding: 40px;
      border-radius: 10px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
      width: 100%;
      max-width: 500px;
    }
    h2 { color: #2e7d32; margin-bottom: 20px; text-align: center; }
    .form-group { margin-bottom: 20px; }
    label {
      display: block;
      margin-bottom: 6px;
      color: #333;
      font-weight: bold;
      font-size: 14px;
    }
    input {
      width: 100%;
      padding: 10px 14px;
      border: 1px solid #ccc;
      border-radius: 6px;
      font-size: 14px;
    }
    .btn {
      width: 100%;
      padding: 12px;
      background: #2e7d32;
      color: white;
      border: none;
      border-radius: 6px;
      font-size: 16px;
      cursor: pointer;
    }
    .error {
      background: #ffebee;
      color: #c62828;
      padding: 10px;
      border-radius: 6px;
      margin-bottom: 20px;
      font-size: 14px;
    }
  </style>
</head>
<body>
<div class="container">
  <h2>Complete Your Organization Profile</h2>

  <% if (request.getAttribute("error") != null) { %>
  <div class="error"><%= request.getAttribute("error") %></div>
  <% } %>

  <form action="/organization/complete-profile" method="post">
    <input type="hidden" name="action" value="completeProfile"/>

    <div class="form-group">
      <label>Organization Name</label>
      <input type="text" name="orgName" placeholder="Shelter / Food Bank name" required />
    </div>

    <div class="form-group">
      <label>Address</label>
      <input type="text" name="address" placeholder="Organization address" required />
    </div>

    <div class="form-group">
      <label>Phone</label>
      <input type="text" name="phone" placeholder="Contact phone number" required />
    </div>

    <div class="form-group">
      <label>Area of Service</label>
      <input type="text" name="areaOfService" placeholder="e.g., Downtown, City Center" required />
    </div>

    <div class="form-group">
      <label>Registration Certificate</label>
      <input type="text" name="regCertificate" placeholder="Registration number" required />
    </div>

    <button type="submit" class="btn">Complete Profile</button>
  </form>
</div>
</body>
</html>