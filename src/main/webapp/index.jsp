<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="includes/header.jsp" />
<head>
    <title>Bloom - Fine Dining</title>
    <style>
        .hero-section {
            background: linear-gradient(rgba(0, 0, 0, 0.45), rgba(0, 0, 0, 0.55)), url('images/bloom_hero_bg_1.png') no-repeat center center;
            background-size: cover;
            background-attachment: fixed; /* Parallax effect */
            height: 100vh;
            width: 100%;
            display: flex;
            align-items: center;
            color: white;
            position: relative;
        }

        .hero-title { font-size: 3.5rem; margin-bottom: 20px; font-family: 'Playfair Display', serif; }
        .hero-subtitle { font-size: 1.1rem; font-weight: 300; margin-bottom: 40px; max-width: 600px; line-height: 1.8; }
        .atmosphere-section { 
            padding: 80px 0; 
            background: linear-gradient(rgba(255, 255, 255, 0.6), rgba(255, 255, 255, 0.6)), url('images/bloomhomepageassets.png') no-repeat center center;
            background-size: cover;
        }
        .section-header { text-transform: uppercase; letter-spacing: 2px; color: #999; font-size: 0.8rem; margin-bottom: 10px; }
        .atmosphere-card { position: relative; border-radius: 12px; overflow: hidden; margin-bottom: 24px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); }
        .atmosphere-card img { width: 100%; height: 300px; object-fit: cover; transition: transform 0.5s ease; }
        .atmosphere-card:hover img { transform: scale(1.05); }
        .atmosphere-overlay { position: absolute; bottom: 0; left: 0; width: 100%; padding: 30px; background: linear-gradient(transparent, rgba(0,0,0,0.8)); color: white; }
        .experience-section { padding: 80px 0; background-color: #f9f6f3; text-align: center; }
        .icon-circle { width: 80px; height: 80px; background-color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 20px; box-shadow: 0 5px 15px rgba(0,0,0,0.05); font-size: 1.5rem; color: #7a111e; }
        .review-img { border-radius: 12px; width: 100%; height: 500px; object-fit: cover; box-shadow: 0 15px 40px rgba(0,0,0,0.1); }
        .testimonial { border-left: 3px solid #7a111e; padding-left: 20px; margin-bottom: 40px; font-style: italic; font-size: 1.1rem; color: #333; }
        .reviews-section {
            padding: 80px 0;
            background: linear-gradient(rgba(255, 255, 255, 0.6), rgba(255, 255, 255, 0.6)), url('images/bloomhomepageassets.png') no-repeat center center;
            background-size: cover;
        }
        .pre-footer { 
            background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)), url('images/bloom_cta_bg.png') no-repeat center center;
            background-size: cover;
            color: white; 
            text-align: center; 
            padding: 120px 0; 
        }
        .cta-title { font-size: 3.5rem; font-weight: 700; margin-bottom: 20px; font-family: 'Playfair Display', serif; color: white; }
        .cta-text { font-size: 1.1rem; max-width: 600px; margin: 0 auto 40px; color: rgba(255,255,255,0.9); line-height: 1.6; }
        .btn-liquid-glass { 
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.25);
            box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.3);
            color: white; 
            padding: 15px 45px; 
            border-radius: 16px; 
            text-decoration: none; 
            font-weight: 600;
            transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
            display: inline-block;
            font-size: 1rem;
            position: relative;
            overflow: hidden;
            letter-spacing: 1px;
            text-transform: uppercase;
        }
        .btn-liquid-glass::after {
            content: '';
            position: absolute;
            top: -50%;
            left: -110%;
            width: 100%;
            height: 200%;
            background: linear-gradient(
                to right,
                rgba(255, 255, 255, 0) 0%,
                rgba(255, 255, 255, 0.3) 50%,
                rgba(255, 255, 255, 0) 100%
            );
            transform: rotate(25deg);
            transition: all 0.6s cubic-bezier(0.165, 0.84, 0.44, 1);
        }
        .btn-liquid-glass:hover { 
            background: rgba(255, 255, 255, 0.15);
            border-color: rgba(255, 255, 255, 0.5);
            transform: translateY(-5px);
            box-shadow: 0 15px 45px 0 rgba(0, 0, 0, 0.4);
            color: white;
        }
        .btn-liquid-glass:hover::after {
            left: 110%;
        }
        
        /* Specific overrides for CTA button */
        .btn-cta { 
            padding: 18px 60px; 
            font-size: 1.1rem;
        }
        
        /* Popup Styles - Liquid Glass Redesign */
        .login-popup-overlay {
            display: none;
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.4);
            z-index: 10000;
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            align-items: center;
            justify-content: center;
        }
        .login-popup-content {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(25px);
            -webkit-backdrop-filter: blur(25px);
            padding: 50px 40px;
            border-radius: 24px;
            width: 95%;
            max-width: 420px;
            position: relative;
            border: 1px solid rgba(255, 255, 255, 0.18);
            box-shadow: 0 25px 50px rgba(0,0,0,0.3);
            animation: popupFade 0.5s cubic-bezier(0.165, 0.84, 0.44, 1);
            color: white;
        }
        @keyframes popupFade {
            from { opacity: 0; transform: scale(0.9) translateY(30px); }
            to { opacity: 1; transform: scale(1) translateY(0); }
        }
        .close-popup {
            position: absolute;
            top: 20px;
            right: 25px;
            font-size: 1.8rem;
            color: rgba(255, 255, 255, 0.6);
            cursor: pointer;
            transition: all 0.3s;
        }
        .close-popup:hover { color: white; transform: rotate(90deg); }
        
        .login-popup-content .form-control {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: white;
            border-radius: 12px;
            padding: 12px 15px;
            transition: all 0.3s;
        }
        .login-popup-content .form-control::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }
        .login-popup-content .form-control:focus {
            background: rgba(255, 255, 255, 0.1);
            border-color: rgba(255, 255, 255, 0.5);
            box-shadow: none;
            outline: none;
        }
    </style>
</head>

<script>document.getElementById('nav-home').classList.add('active');</script>

<!-- Hero Section -->
<section class="hero-section">
    <div class="container">
        <div class="row">
            <div class="col-lg-8">
                <h1 class="hero-title">Reserve Your Perfect Table Online</h1>
                <p class="hero-subtitle">Experience the art of fine dining with a seamless reservation system. From intimate window seats to vibrant outdoor terraces, your table awaits.</p>
                <div class="d-flex gap-3">
                    <a href="reservation.jsp" class="btn-liquid-glass" style="background: rgba(122, 17, 30, 0.4); border-color: rgba(122, 17, 30, 0.6);">Book Now</a>
                    <a href="tables" class="btn-liquid-glass">View Tables</a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Atmosphere Section -->
<section class="atmosphere-section">
    <div class="container">
        <div class="section-header">Atmosphere</div>
        <h2 class="mb-5" style="font-family: 'Playfair Display';">Explore Our Dining Spaces</h2>
        
        <div class="row">
            <div class="col-md-7">
                <div class="atmosphere-card">
                    <img src="images/bloom_indoor_elegance_1776880086931.png" alt="Indoor Elegance">
                    <div class="atmosphere-overlay">
                        <h4>Indoor Elegance</h4>
                        <p class="mb-0 text-white-50 small">Our main hall features plush seating and curated art for a truly sophisticated evening.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-5">
                <div class="atmosphere-card">
                    <img src="images/bloom_window_views_1776880102214.png" alt="Window Views">
                    <div class="atmosphere-overlay">
                        <h4>Window Views</h4>
                        <p class="mb-0 text-white-50 small">The perfect backdrop for intimate conversations and city-lit memories.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-12">
                <div class="atmosphere-card" style="height: 400px;">
                    <img src="images/bloom_al_fresco_1776880124833.png" alt="Al Fresco Terrace" style="height: 100%;">
                    <div class="atmosphere-overlay d-flex justify-content-between align-items-end">
                        <div>
                            <h4>Al Fresco Terrace</h4>
                            <p class="mb-0 text-white-50 small">Dine under the stars in our lush, heated garden terrace.</p>
                        </div>
                        <a href="reservation.jsp?tableId=T09" class="btn btn-light" style="border-radius: 15px;">Reserve This Space</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Experience Section -->
<section class="experience-section">
    <div class="container">
        <h3 class="mb-2" style="font-family: 'Playfair Display';">The Bloom Experience</h3>
        <p class="text-muted mb-5">Three simple steps to an unforgettable culinary journey.</p>
        
        <div class="row">
            <div class="col-md-4">
                <div class="icon-circle"><i class="fa-solid fa-magnifying-glass"></i></div>
                <h5 class="mb-3">Discover</h5>
                <p class="text-muted px-4 small">Browse our diverse dining areas and available times curated for your preference.</p>
            </div>
            <div class="col-md-4">
                <div class="icon-circle"><i class="fa-solid fa-chair"></i></div>
                <h5 class="mb-3">Select</h5>
                <p class="text-muted px-4 small">Choose your preferred table location, from quiet corners to the heart of the action.</p>
            </div>
            <div class="col-md-4">
                <div class="icon-circle"><i class="fa-regular fa-circle-check"></i></div>
                <h5 class="mb-3">Confirm</h5>
                <p class="text-muted px-4 small">Instant confirmation and digital concierge support for any special requests.</p>
            </div>
        </div>
    </div>
</section>

<!-- Reviews Section -->
<section class="reviews-section py-5">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-6 mb-4 mb-md-0">
                <img src="images/bloom_guest_reviews_1776880142246.png" alt="Guests" class="review-img">
            </div>
            <div class="col-md-6 ps-md-5">
                <div class="section-header">Guest Reviews</div>
                <h2 class="mb-5" style="font-family: 'Playfair Display';">What Our Patrons Say</h2>
                
                <div class="testimonial">
                    "The ease of selecting our specific table near the window made our anniversary truly special. The service was as impeccable as the view."
                    <div class="testimonial-author text-muted mt-2 small">— Julianne M., Regular Guest</div>
                </div>
                
                <div class="testimonial">
                    "Bloom has redefined the digital dining experience. Fast, intuitive, and remarkably elegant."
                    <div class="testimonial-author text-muted mt-2 small">— David K., Food Critic</div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="pre-footer">
    <div class="container">
        <h2 class="cta-title">Ready to Experience Fine Dining?</h2>
        <p class="cta-text">Join our community of gourmet enthusiasts and secure your place at the table today.</p>
        <a href="reservation.jsp" class="btn-liquid-glass btn-cta">Start Your Reservation</a>
    </div>
</section>

<!-- Mini Login Popup -->
<div id="loginPopup" class="login-popup-overlay">
    <div class="login-popup-content">
        <span class="close-popup" onclick="closeLoginPopup()">&times;</span>
        <div class="text-center mb-5">
            <h3 class="mb-2" style="font-family: 'Playfair Display'; color: white;">Welcome Back</h3>
            <p style="color: rgba(255,255,255,0.7); font-size: 0.9rem;">Log in to unlock priority reservations</p>
        </div>
        <form action="login" method="post">
            <div class="mb-4">
                <input type="text" name="username" class="form-control" placeholder="Username" required>
            </div>
            <div class="mb-5">
                <input type="password" name="password" class="form-control" placeholder="Password" required>
            </div>
            <button type="submit" class="btn-liquid-glass w-100 mb-4" style="background: rgba(122, 17, 30, 0.6); border-color: rgba(255,255,255,0.3);">Login</button>
            <div class="text-center">
                <a href="signup.jsp" style="color: rgba(255,255,255,0.6); font-size: 0.85rem; text-decoration: none;" class="hover-white">New here? Create Account</a>
            </div>
        </form>
    </div>
</div>

    <input type="hidden" id="showLoginPopup" value="<%= session.getAttribute("customerLoggedIn") == null %>">
    <script>
        function closeLoginPopup() {
            document.getElementById('loginPopup').style.display = 'none';
        }

        window.addEventListener('load', function() {
            const shouldShow = document.getElementById('showLoginPopup').value === 'true';
            if (shouldShow) {
                setTimeout(() => {
                    const popup = document.getElementById('loginPopup');
                    if (popup) popup.style.display = 'flex';
                }, 1000);
            }
        });
    </script>

<jsp:include page="includes/footer.jsp" />
