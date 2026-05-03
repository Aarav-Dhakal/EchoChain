<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>EcoChain - Home</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; }
        .hero {
            background: linear-gradient(135deg, #2e7d32, #66bb6a);
            color: white;
            text-align: center;
            padding: 100px 20px;
        }
        .hero h1 { font-size: 48px; margin-bottom: 20px; }
        .hero p { font-size: 20px; margin-bottom: 30px; }
        .btn {
            display: inline-block;
            padding: 15px 30px;
            background: white;
            color: #2e7d32;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            margin: 0 10px;
        }
        .features {
            padding: 60px 20px;
            text-align: center;
        }
        .features h2 { color: #2e7d32; margin-bottom: 40px; }
        .feature-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 30px;
            max-width: 1200px;
            margin: 0 auto;
        }
        .feature-card {
            padding: 30px;
            background: #f0f4f0;
            border-radius: 10px;
        }
        .feature-card h3 { color: #2e7d32; margin-bottom: 10px; }
    </style>
</head>
<body>
<div class="hero">
    <h1>🌿 Welcome to EcoChain</h1>
    <p>Reducing food waste, feeding communities</p>
    <a href="/login" class="btn">Login</a>
    <a href="/register" class="btn">Register</a>
</div>
<div class="features">
    <h2>How It Works</h2>
    <div class="feature-grid">
        <div class="feature-card">
            <h3>For Donors</h3>
            <p>Post surplus food from your restaurant, bakery, or store.</p>
        </div>
        <div class="feature-card">
            <h3>For Organizations</h3>
            <p>Browse and request food donations for your community.</p>
        </div>
        <div class="feature-card">
            <h3>Make an Impact</h3>
            <p>Track food saved, CO₂ reduced, and meals served.</p>
        </div>
    </div>
</div>
</body>
</html>