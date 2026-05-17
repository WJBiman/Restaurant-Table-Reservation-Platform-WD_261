<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="includes/header.jsp" />

<style>
    .privacy-container {
        padding: 80px 0;
    }
    .privacy-title {
        font-family: 'Playfair Display', serif;
        color: #7a111e;
        font-size: 3rem;
        font-weight: 700;
        margin-bottom: 5px;
    }
    .last-updated {
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
    .sidebar-contents h6 {
        font-size: 0.75rem;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 1px;
        margin-bottom: 20px;
        color: #333;
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
    .privacy-section-title {
        font-family: 'Playfair Display', serif;
        color: #7a111e;
        font-size: 1.8rem;
        font-weight: 600;
        margin-top: 40px;
        margin-bottom: 20px;
    }
    .privacy-text {
        color: #444;
        line-height: 1.8;
        font-size: 0.95rem;
        margin-bottom: 20px;
    }
    .privacy-list {
        margin-bottom: 20px;
    }
    .privacy-list li {
        margin-bottom: 10px;
        color: #444;
    }
    .notice-box {
        background: #f8f9fa;
        border-radius: 12px;
        padding: 25px;
        font-style: italic;
        font-size: 0.9rem;
        color: #666;
        margin: 30px 0;
        text-align: center;
    }
    .contact-info {
        margin-top: 20px;
        color: #444;
        font-size: 0.9rem;
    }
</style>

<div class="container privacy-container">
    <div class="row">
        <div class="col-12">
            <h1 class="privacy-title">Privacy Policy</h1>
            <p class="last-updated">Last updated: May 01, 2026</p>
        </div>
    </div>

    <div class="row g-5">
        <div class="col-lg-3 d-none d-lg-block">
            <div class="sidebar-contents">
                <h6>Contents</h6>
                <a href="#collection" class="sidebar-link">1. Information Collection</a>
                <a href="#usage" class="sidebar-link">2. Data Usage</a>
                <a href="#rights" class="sidebar-link">3. User Rights</a>
                <a href="#security" class="sidebar-link">4. Security Measures</a>
                <a href="#contact" class="sidebar-link">5. Contact Us</a>
            </div>
        </div>

        <div class="col-lg-9">
            <p class="privacy-text">
                At Bloom, we are committed to protecting your privacy and ensuring a secure experience. This Privacy Policy outlines how we collect, use, and safeguard your information when you engage with our digital platform, make reservations, or dine with us. We respect your confidentiality with the same care and attention to detail as our culinary creations.
            </p>

            <section id="collection">
                <h2 class="privacy-section-title">Information Collection</h2>
                <p class="privacy-text">
                    We collect information necessary to provide you with an exceptional dining experience. This may include:
                </p>
                <ul class="privacy-list">
                    <li><strong>Personal Identity:</strong> Your name, email address, and phone number provided during the reservation process.</li>
                    <li><strong>Preferences:</strong> Dietary restrictions, seating preferences, and special occasion details.</li>
                    <li><strong>Transaction Data:</strong> Payment information required to secure bookings, processed securely via our partners.</li>
                    <li><strong>Technical Data:</strong> IP addresses and browsing behavior collected through cookies to enhance our website functionality.</li>
                </ul>
            </section>

            <section id="usage">
                <h2 class="privacy-section-title">Data Usage</h2>
                <p class="privacy-text">
                    The information we collect is utilized to elevate your experience. Specifically, we use your data to:
                </p>
                <ul class="privacy-list">
                    <li>Manage and confirm your reservations effectively.</li>
                    <li>Tailor our culinary offerings to accommodate your dietary needs and preferences.</li>
                    <li>Communicate important updates regarding your booking or our services.</li>
                    <li>Analyze website usage to improve our digital concierge services.</li>
                </ul>
            </section>

            <section id="rights">
                <h2 class="privacy-section-title">User Rights</h2>
                <p class="privacy-text">
                    You retain full control over your personal information. Under applicable privacy laws, you possess the right to:
                </p>
                <ul class="privacy-list">
                    <li><strong>Access:</strong> Request a copy of the personal data we hold about you.</li>
                    <li><strong>Correction:</strong> Request that we correct any inaccurate or incomplete data.</li>
                    <li><strong>Erasure:</strong> Request the deletion of your personal data, subject to certain legal obligations.</li>
                    <li><strong>Restriction:</strong> Opt-out of marketing communications at any time.</li>
                </ul>

                <div class="notice-box">
                    To exercise any of these rights, please contact our privacy concierge at the details provided below. We strive to respond to all legitimate requests within 30 days.
                </div>
            </section>

            <section id="security">
                <h2 class="privacy-section-title">Security Measures</h2>
                <p class="privacy-text">
                    We implement robust security protocols to protect your data from unauthorized access, alteration, or disclosure. Our digital platforms utilize industry-standard encryption, and access to personal information is strictly limited to authorized personnel who require it to perform their duties. We regularly review our security practices to ensure the highest level of protection.
                </p>
            </section>

            <section id="contact" style="border-top: 1px solid #eee; margin-top: 60px; padding-top: 40px;">
                <h2 class="privacy-section-title">Contact Us</h2>
                <p class="privacy-text">
                    If you have any questions or concerns regarding this Privacy Policy, please reach out to us:
                </p>
                <div class="contact-info">
                    <p class="mb-1"><strong>Bloom Privacy Concierge</strong></p>
                    <p class="mb-1">Port City Colombo, Financial District</p>
                    <p class="mb-1">Suite 700, Marina Tower</p>
                    <p class="mb-1">Colombo 00100, Sri Lanka</p>
                    <p class="mb-0"><a href="mailto:privacy@bloomrestaurant.com" style="color: #7a111e; text-decoration: none;">privacy@bloomrestaurant.com</a></p>
                </div>
            </section>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp" />
