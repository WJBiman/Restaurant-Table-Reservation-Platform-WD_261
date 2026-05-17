<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Join Us | Bloom Fine Dining</title>
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
        .login-form-panel {
            flex: 1;
            background: white;
            display: flex;
            flex-direction: column;
            padding: 60px 40px;
            position: relative;
            overflow-y: auto;
        }
        .close-btn {
            position: absolute;
            top: 30px;
            right: 40px;
            font-size: 1.5rem;
            color: #333;
            text-decoration: none;
            transition: transform 0.2s;
        }
        .close-btn:hover {
            transform: scale(1.1);
        }
        .login-box {
            width: 100%;
            max-width: 420px;
            margin: auto;
        }
        .login-box.wide {
            max-width: 500px;
        }
        .branding-italic {
            font-family: 'Playfair Display', serif;
            font-style: italic;
            color: #7a111e;
            font-size: 1.8rem;
            margin-bottom: 5px;
            display: block;
            text-align: center;
        }
        .login-header {
            text-align: center;
            margin-bottom: 25px;
        }
        .login-header h2 {
            font-family: 'Playfair Display', serif;
            font-weight: 700;
            font-size: 2.4rem;
            margin-bottom: 10px;
        }
        .login-header p {
            color: #666;
            font-size: 0.95rem;
        }
        .form-label {
            font-weight: 600;
            font-size: 0.85rem;
            margin-bottom: 4px;
            color: #333;
        }
        .form-control {
            padding: 14px;
            border: 1px solid #ddd;
            border-radius: 8px !important;
            font-size: 1rem;
            margin-bottom: 12px;
        }
        .form-control:focus {
            border-color: #7a111e;
            box-shadow: 0 0 0 1px #7a111e;
        }
        .btn-signin {
            background: #7a111e;
            color: white;
            padding: 16px;
            font-weight: 600;
            border-radius: 8px !important;
            border: none;
            width: 100%;
            margin-top: 10px;
            transition: all 0.3s ease;
        }
        .btn-signin:hover {
            background: white !important;
            color: #7a111e !important;
            box-shadow: inset 0 0 0 2px #7a111e !important;
        }
        .signup-footer {
            text-align: center;
            font-size: 0.9rem;
            color: #666;
            margin-top: 20px;
        }
        .signup-footer a {
            color: #7a111e;
            font-weight: 700;
            text-decoration: none;
        }
        @media (max-width: 992px) {
            .login-image-panel {
                display: none;
            }
        }
    </style>
</head>
<body>

<div class="login-split-container">
    <div class="login-image-panel">
        <div class="login-quote">
            "An unparalleled epicurean journey."
        </div>
    </div>

    <div class="login-form-panel">
        <a href="index.jsp" class="close-btn"><i class="fa-solid fa-xmark"></i></a>

        <div class="login-box wide">
            <span class="branding-italic">Bloom Fine Dining</span>
            <div class="login-header">
                <h2>Create an Account</h2>
                <p>Experience unparalleled culinary exclusivity</p>
            </div>

            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-danger py-2 small mb-4" style="border-radius: 8px;">
                    <%= request.getAttribute("errorMessage") %>
                </div>
            <% } %>

            <form id="signupForm" action="signup" method="post">
                <div class="row g-3">
                    <div class="col-md-6 mb-1">
                        <label class="form-label">Username</label>
                        <input type="text" name="username" class="form-control" placeholder="username" required>
                    </div>
                    <div class="col-md-6 mb-1">
                        <label class="form-label">Full Name</label>
                        <input type="text" name="name" class="form-control" placeholder="Full Name" required>
                    </div>
                    <div class="col-md-12 mb-1">
                        <label class="form-label">Email Address</label>
                        <input type="email" name="email" class="form-control" placeholder="email@domain.com" required>
                    </div>
                    <div class="col-md-12 mb-1">
                        <label class="form-label">Phone Number</label>
                        <input type="tel" name="phone" class="form-control" placeholder="Phone Number" required>
                    </div>
                    <div class="col-md-6 mb-1">
                        <label class="form-label">Password</label>
                        <input type="password" id="password" name="password" class="form-control" placeholder="••••••••" required>
                    </div>
                    <div class="col-md-6 mb-2">
                        <label class="form-label">Confirm Password</label>
                        <input type="password" id="confirmPassword" class="form-control" placeholder="••••••••" required>
                    </div>
                </div>
                <button type="submit" class="btn btn-signin">Sign Up</button>
            </form>

            <div class="signup-footer">
                Already have an account? <a href="login.jsp">Sign In</a>
            </div>
        </div>
    </div>
</div>

<script>
    document.getElementById('signupForm').addEventListener('submit', function(e) {
        var password = document.getElementById('password').value;
        var confirmPassword = document.getElementById('confirmPassword').value;
        if (password !== confirmPassword) {
            e.preventDefault();
            alert("Passwords do not match!");
        }
    });
</script>

</body>
</html>