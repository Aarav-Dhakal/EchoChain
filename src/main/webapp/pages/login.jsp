<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - EcoChain</title>
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
            max-width: 400px;
        }
        .logo { text-align: center; margin-bottom: 30px; }
        .logo h1 { color: #2e7d32; font-size: 32px; }
        .logo p { color: #666; font-size: 14px; }
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
        input:focus { outline: none; border-color: #2e7d32; }
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
        .btn:hover { background: #1b5e20; }
        .error {
            background: #ffebee;
            color: #c62828;
            padding: 10px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 14px;
        }
        .success {
            background: #e8f5e9;
            color: #2e7d32;
            padding: 10px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-size: 14px;
        }
        .link { text-align: center; margin-top: 20px; font-size: 14px; color: #666; }
        .link a { color: #2e7d32; text-decoration: none; }
        .link a:hover { text-decoration: underline; }
    </style>
</head>
<body>
<div class="container">
    <div class="logo">
        <h1>🌿 EcoChain</h1>
        <p>Reducing food waste, feeding communities</p>
    </div>

    <% if (request.getAttribute("error") != null) { %>
    <div class="error"><%= request.getAttribute("error") %></div>
    <% } %>

    <% if (request.getAttribute("success") != null) { %>
    <div class="success"><%= request.getAttribute("success") %></div>
    <% } %>

    <form action="/login" method="post">
        <div class="form-group">
            <label>Email</label>
            <input type="email" name="email" placeholder="Enter your email" required />
        </div>
        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" placeholder="Enter your password" required />
        </div>
        <button type="submit" class="btn">Login</button>
    </form>

    <div class="link">
        Don't have an account? <a href="/register">Register here</a>
    </div>
</div>
</body>
</html>