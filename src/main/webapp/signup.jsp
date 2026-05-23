<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Join Us | Bloom Fine Dining</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link
            href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,700;1,500;1,700&family=Inter:wght@400;500;600;700&display=swap"
            rel="stylesheet">
        <link href="css/login.css?v=3" rel="stylesheet">
    </head>

    <body>

        <div class="login-split-container">
            <!-- Left Side: Image & Quote -->
            <div class="login-image-panel">
                <div class="login-quote">
                    "An unparalleled epicurean journey."
                </div>
            </div>

            <!-- Right Side: Signup Form -->
            <div class="login-form-panel">
                <a href="index.jsp" class="close-btn"><i class="fa-solid fa-xmark"></i></a>

                <div class="login-box wide">
                    <span class="branding-italic">Bloom Fine Dining</span>

                    <div class="login-header">
                        <h2>Create an Account</h2>
                        <p>Experience unparalleled culinary exclusivity</p>
                    </div>

                    <% if (request.getAttribute("errorMessage") !=null) { %>
                        <div class="alert alert-danger py-2 small mb-4" style="border-radius: 8px;">
                            <%= request.getAttribute("errorMessage") %>
                        </div>
                        <% } %>

                            <form action="signup" method="post">
                                <div class="row g-3">
                                    <div class="col-md-6 mb-1">
                                        <label class="form-label">Username</label>
                                        <input type="text" name="username" class="form-control" placeholder="jabux"
                                            required>
                                    </div>
                                    <div class="col-md-6 mb-1">
                                        <label class="form-label">Full Name</label>
                                        <input type="text" name="name" class="form-control" placeholder="Janith Biman"
                                            required>
                                    </div>
                                    <div class="col-md-12 mb-1">
                                        <label class="form-label">Email Address</label>
                                        <input type="email" name="email" class="form-control"
                                            placeholder="wjbiman@gmail.com" required>
                                    </div>
                                    <div class="col-md-12 mb-1">
                                        <label class="form-label">Phone Number</label>
                                        <input type="tel" name="phone" class="form-control"
                                            placeholder="+94 XX XXX XXXX" required>
                                    </div>
                                    <div class="col-md-6 mb-1">
                                        <label class="form-label">Password</label>
                                        <input type="password" name="password" class="form-control"
                                            placeholder="••••••••" required>
                                    </div>
                                    <div class="col-md-6 mb-2">
                                        <label class="form-label">Confirm Password</label>
                                        <input type="password" class="form-control" placeholder="••••••••" required>
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

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>

    </html>