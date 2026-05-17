<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Bloom Fine Dining</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,700;1,500;1,700&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        .login-split-container {
            display: flex;
            min-height: 100vh;
            width: 100%;
        }
        .login-image-panel {
            flex: 1.1;
            background: url('images/bloom_login_side_bg.png') no-repeat center center;
            background-size: cover;
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
            padding: 60px;
            position: relative;
            color: white;
        }
        .login-image-panel::after {
            content: '';
            position: absolute;
            top: 0; left: 0; width: 100%; height: 100%;
            background: linear-gradient(to bottom, rgba(0,0,0,0.1), rgba(0,0,0,0.6));
            z-index: 1;
        }
        .login-quote {
            position: relative;
            z-index: 2;
            font-family: 'Playfair Display', serif;
            font-size: 2.2rem;
            font-style: italic;
            font-weight: 500;
            max-width: 450px;
            line-height: 1.3;
        }
    </style>
</head>
<body>

<div class="login-split-container">
    <!-- Left Side: Image & Quote -->
    <div class="login-image-panel">
        <div class="login-quote">
            "An unparalleled epicurean journey."
        </div>
    </div>
</div>

</body>
</html>
