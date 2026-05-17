<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="includes/header.jsp" />

<style>
    .sus-hero {
        padding: 120px 0 80px;
        background: linear-gradient(rgba(255,255,255,0.9), rgba(255,255,255,0.9)), url('images/bloom_indoor_elegance_1776880086931.png');
        background-size: cover;
        background-position: center;
        text-align: center;
    }
    .sus-title {
        font-family: 'Playfair Display', serif;
        color: #7a111e;
        font-size: 3.5rem;
        font-weight: 700;
        margin-bottom: 25px;
    }
    .sus-subtext {
        max-width: 800px;
        margin: 0 auto;
        color: #555;
        line-height: 1.8;
        font-size: 1.1rem;
    }
    .sus-card {
        background: white;
        border-radius: 20px;
        overflow: hidden;
        box-shadow: 0 10px 30px rgba(0,0,0,0.05);
        height: 100%;
        border: 1px solid #f0f0f0;
    }
    .sus-card-body {
        padding: 40px;
    }
    .sus-icon-box {
        width: 50px;
        height: 50px;
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 25px;
        font-size: 1.2rem;
    }
    .sus-card-title {
        font-family: 'Playfair Display', serif;
        font-size: 1.8rem;
        color: #1a1a1a;
        margin-bottom: 15px;
    }
    .sus-card-text {
        color: #666;
        line-height: 1.7;
        font-size: 0.95rem;
    }
    .sus-img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    .analytics-section {
        background: #fdfdfd;
        border-radius: 30px;
        padding: 60px;
        margin: 80px 0;
        border: 1px solid #f5f5f5;
    }
    .btn-annual {
        background: #7a111e;
        color: white;
        border: none;
        padding: 12px 30px;
        border-radius: 50px;
        font-weight: 600;
        font-size: 0.9rem;
        margin-top: 30px;
        transition: all 0.3s;
    }
    .btn-annual:hover {
        background: #5a0c16;
        transform: translateY(-2px);
        color: white;
    }
    .workflow-section {
        text-align: center;
        padding: 80px 0;
    }
</style>

<div class="sus-hero">
    <div class="container">
        <h1 class="sus-title">Sustainability Through Innovation</h1>
        <p class="sus-subtext">
            At Bloom, our commitment to excellence extends beyond the culinary arts. Through our advanced digital reservation system, we minimize our environmental footprint while elevating your dining experience.
        </p>
    </div>
</div>

<div class="container my-5">
    <div class="row g-4 align-items-stretch">
        <div class="col-lg-8">
            <div class="sus-card">
                <div class="row g-0 h-100">
                    <div class="col-md-6 sus-card-body">
                        <div class="sus-icon-box" style="background: #f1f8f1; color: #2e7d32;">
                            <i class="fa-solid fa-leaf"></i>
                        </div>
                        <h3 class="sus-card-title">Digital Reservations</h3>
                        <p class="sus-card-text">
                            By transitioning entirely from paper logbooks to a centralized cloud system, we have eliminated thousands of pages of physical waste annually. Our digital-first approach ensures every booking is seamlessly integrated, reducing the reliance on single-use materials in our daily operations.
                        </p>
                    </div>
                    <div class="col-md-6">
                        <img src="images/bloom_indoor_elegance_1776880086931.png" class="sus-img" alt="Digital Flow">
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="sus-card sus-card-body">
                <div class="sus-icon-box" style="background: #fff8e1; color: #ffa000;">
                    <i class="fa-solid fa-bolt"></i>
                </div>
                <h3 class="sus-card-title">Energy Efficiency</h3>
                <p class="sus-card-text">
                    Our cloud infrastructure is optimized to run on low-power, high-efficiency servers. By streamlining the booking flow, we reduce unnecessary compute cycles, making our digital operations significantly greener than traditional server setups.
                </p>
            </div>
        </div>
    </div>

    <div class="analytics-section">
        <div class="row align-items-center g-5">
            <div class="col-lg-6">
                <img src="images/bloom_indoor_elegance_1776880086931.png" class="img-fluid rounded-4 shadow-lg" alt="Waste Analytics">
            </div>
            <div class="col-lg-6">
                <h3 class="sus-card-title" style="font-size: 2.2rem;">Waste Reduction Analytics</h3>
                <p class="sus-card-text mt-4">
                    Precision is the hallmark of fine dining. Our advanced booking analytics allow our culinary team to forecast demand with unprecedented accuracy.
                </p>
                <p class="sus-card-text">
                    By knowing exactly who is dining with us and when, we eliminate the guesswork from our supply chain. This precise table management directly translates to a significant reduction in resource over-allocation and food waste, ensuring that every ingredient is utilized to its fullest potential.
                </p>

            </div>
        </div>
    </div>

    <div class="workflow-section">
        <div class="sus-icon-box mx-auto" style="background: #f1f8f1; color: #2e7d32;">
            <i class="fa-solid fa-seedling"></i>
        </div>
        <h3 class="sus-card-title">Eco-Friendly Workflows</h3>
        <p class="sus-card-text mx-auto" style="max-width: 700px;">
            Embracing a digital-first philosophy empowers our staff to focus on what truly matters: the guest experience. By automating routine tasks and digitizing internal communications, we have fostered an environment that is not only highly efficient but also fundamentally respectful of our natural resources.
        </p>
    </div>
</div>

<jsp:include page="includes/footer.jsp" />
