<style>
    .modal-overlay {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.6);
        z-index: 9999;
        backdrop-filter: blur(8px);
        align-items: center;
        justify-content: center;
        padding: 20px;
    }

    .modal-overlay.show {
        display: flex;
    }

    .modal-content-custom {
        background: white;
        border-radius: 24px;
        max-width: 800px;
        width: 100%;
        position: relative;
        box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
        transform: translateY(20px);
        opacity: 0;
        transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
    }

    .modal-overlay.show .modal-content-custom {
        transform: translateY(0);
        opacity: 1;
    }

    .update-modal-header {
        padding: 40px 40px 20px;
        position: relative;
    }

    .update-modal-body {
        padding: 0 40px 40px;
    }

    .modal-title-custom {
        font-family: 'Playfair Display', serif;
        color: #5a0c16;
        font-size: 2.2rem;
        font-weight: 700;
        margin-bottom: 5px;
    }
</style>