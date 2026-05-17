<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="includes/header.jsp" />

<style>
    .terms-container {
        padding: 80px 0;
    }
    .terms-title {
        font-family: 'Playfair Display', serif;
        color: #7a111e;
        font-size: 3rem;
        font-weight: 700;
        margin-bottom: 5px;
    }
    .terms-subtext {
        color: #666;
        font-size: 0.9rem;
        margin-bottom: 40px;
        border-bottom: 1px solid #eee;
        padding-bottom: 20px;
    }
    .sidebar-contents {
        background: #fdfdfd;
        border-radius: 12px;
        padding: 25px;
        border: 1px solid #f0f0f0;
        position: sticky;
        top: 100px;
    }
    .sidebar-link {
        display: block;
        color: #666;
        text-decoration: none;
        font-size: 0.85rem;
        margin-bottom: 12px;
        transition: color 0.3s;
    }
    .sidebar-link:hover {
        color: #7a111e;
    }
    .terms-card {
        background: white;
        border-radius: 15px;
        padding: 40px;
        box-shadow: 0 10px 40px rgba(0,0,0,0.03);
        border: 1px solid #f8f8f8;
    }
    .terms-section-title {
        font-family: 'Playfair Display', serif;
        color: #7a111e;
        font-size: 1.8rem;
        font-weight: 600;
        margin-top: 40px;
        margin-bottom: 20px;
    }
    .terms-text {
        color: #444;
        line-height: 1.8;
        font-size: 0.95rem;
        margin-bottom: 20px;
    }
    .terms-list {
        margin-bottom: 20px;
    }
    .terms-list li {
        margin-bottom: 10px;
        color: #444;
    }
    .policy-box {
        background: #fdf5f5;
        border-radius: 12px;
        padding: 25px;
        margin: 30px 0;
        border-left: 4px solid #7a111e;
    }
    .policy-box h6 {
        color: #7a111e;
        font-weight: 700;
        font-size: 0.9rem;
        margin-bottom: 10px;
    }
    .policy-box p {
        font-size: 0.85rem;
        color: #555;
        margin-bottom: 0;
    }
</style>

<div class="container terms-container">
    <div class="row">
        <div class="col-12">
            <h1 class="terms-title">Terms of Service</h1>
            <p class="terms-subtext">Please read these terms carefully before using our services. Last updated: May 2026.</p>
        </div>
    </div>

    <div class="row g-5">
        <div class="col-lg-3 d-none d-lg-block">
            <div class="sidebar-contents">
                <a href="#intro" class="sidebar-link">1. Introduction</a>
                <a href="#booking" class="sidebar-link">2. Booking Terms</a>
                <a href="#cancellation" class="sidebar-link">3. Cancellation Policy</a>
                <a href="#conduct" class="sidebar-link">4. User Conduct</a>
                <a href="#liability" class="sidebar-link">5. Limitation of Liability</a>
            </div>
        </div>

        <div class="col-lg-9">
            <div class="terms-card">
                <section id="intro">
                    <h2 class="terms-section-title">1. Introduction</h2>
                    <p class="terms-text">
                        Welcome to Bloom. These Terms of Service ("Terms") govern your use of our website, reservation platform, and dining experiences. By accessing our services, you agree to comply with and be bound by these Terms.
                    </p>
                    <p class="terms-text">
                        If you do not agree to these Terms, please refrain from using our services. We reserve the right to update these Terms at any time, and continued use signifies your acceptance of those changes.
                    </p>
                </section>

                <hr class="my-5 opacity-10">

                <section id="booking">
                    <h2 class="terms-section-title">2. Booking Terms</h2>
                    <p class="terms-text">
                        Reservations at Bloom are highly sought after and require a valid credit card to secure. By providing your payment information, you authorize us to apply charges in accordance with our cancellation policy.
                    </p>
                    <ul class="terms-list">
                        <li>All reservations must be made through our official platform or authorized partners.</li>
                        <li>A confirmation email will be sent upon successful booking; please review it carefully.</li>
                        <li>We accommodate dietary restrictions with advance notice (minimum 48 hours).</li>
                        <li>Large parties (6 or more) may be subject to a non-refundable deposit.</li>
                    </ul>
                </section>

                <hr class="my-5 opacity-10">

                <section id="cancellation">
                    <h2 class="terms-section-title">3. Cancellation Policy</h2>
                    <p class="terms-text">
                        We understand that plans change, but due to the intimate nature of our dining room and the preparation required for our tasting menus, we enforce a strict cancellation policy.
                    </p>
                    <div class="policy-box">
                        <div class="mb-4">
                            <h6>Standard Reservations</h6>
                            <p>Cancellations must be made at least 72 hours prior to the reservation time to avoid a fee of $150 per person.</p>
                        </div>
                        <div>
                            <h6>Special Events & Holidays</h6>
                            <p>Cancellations for special events require 7 days' notice. Late cancellations will forfeit the full pre-paid amount or incur a $250 per person fee.</p>
                        </div>
                    </div>
                </section>

                <hr class="my-5 opacity-10">

                <section id="conduct">
                    <h2 class="terms-section-title">4. User Conduct</h2>
                    <p class="terms-text">
                        We strive to provide a refined and comfortable atmosphere for all guests. We expect our patrons to conduct themselves appropriately both online and in person.
                    </p>
                    <ul class="terms-list">
                        <li>Respect the dress code outlined in your reservation confirmation.</li>
                        <li>Maintain a considerate volume and demeanor within the dining room.</li>
                        <li>Refrain from using flash photography or intrusive recording devices.</li>
                        <li>Treat our staff and fellow guests with courtesy and respect.</li>
                    </ul>
                </section>

                <hr class="my-5 opacity-10">

                <section id="liability">
                    <h2 class="terms-section-title">5. Limitation of Liability</h2>
                    <p class="terms-text">
                        To the fullest extent permitted by law, Bloom shall not be liable for any indirect, incidental, special, consequential, or punitive damages arising out of or related to your use of our services.
                    </p>
                    <p class="terms-text">
                        We make no warranties regarding the uninterrupted availability of our digital platforms and are not responsible for any technical issues outside of our control.
                    </p>
                </section>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp" />
