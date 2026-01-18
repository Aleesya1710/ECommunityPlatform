<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Community Service & Volunteer Platform</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap" rel="stylesheet">

    <style>
        /* Custom styles */
        .btn-primary {
            background-color: #F7DE4F;
            color: #333333;
            transition: background-color 0.2s ease, transform 0.2s ease, box-shadow 0.2s ease;
        }
        .btn-primary:hover {
            background-color: #F4D10B;
            transform: translateY(-1px);
            box-shadow: 0 12px 24px rgba(0,0,0,0.12);
        }
        .nav-link { color: #333333; transition: color 0.2s ease; }
        .nav-link:hover { color: #E2B000; }

        /* HERO Carousel (background image style) */
        .hero-slider {
            position: relative;
            width: 100%;
            height: 22rem;
            border-radius: 1rem;
            overflow: hidden;
            box-shadow: 0 18px 40px rgba(0,0,0,0.12);
        }
        @media (min-width: 1024px) {
            .hero-slider { height: 26rem; }
        }

        .hero-slide {
            position: absolute;
            inset: 0;
            background-size: cover;
            background-position: center;
            opacity: 0;
            transition: opacity 0.6s ease-in-out;
        }
        .hero-slide.active { opacity: 1; }

        .hero-overlay {
            position: absolute;
            inset: 0;
            background: linear-gradient(to right, rgba(0,0,0,0.55), rgba(0,0,0,0.15));
        }

        .hero-content {
            position: relative;
            z-index: 2;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 1.75rem;
            max-width: 92%;
        }
        .hero-content h2 {
            color: #fff;
            font-weight: 800;
            line-height: 1.05;
            font-size: 1.9rem;
            text-shadow: 0 6px 20px rgba(0,0,0,0.25);
        }
        @media (min-width: 640px) {
            .hero-content h2 { font-size: 2.2rem; }
        }
        .hero-content p {
            color: rgba(255,255,255,0.90);
            margin-top: 0.75rem;
            font-size: 1rem;
            max-width: 30rem;
        }

        .hero-badges {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
            margin-top: 1rem;
        }
        .badge {
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            padding: 0.35rem 0.6rem;
            border-radius: 9999px;
            background: rgba(255,255,255,0.18);
            border: 1px solid rgba(255,255,255,0.25);
            color: #fff;
            font-size: 0.85rem;
            backdrop-filter: blur(6px);
        }

        .hero-controls {
            position: absolute;
            inset: 0;
            z-index: 3;
            pointer-events: none;
        }
        .hero-btn {
            pointer-events: auto;
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            width: 2.75rem;
            height: 2.75rem;
            border-radius: 9999px;
            border: none;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(255,255,255,0.85);
            box-shadow: 0 10px 20px rgba(0,0,0,0.18);
            transition: transform 0.2s ease, background 0.2s ease;
        }
        .hero-btn:hover { background: #fff; transform: translateY(-50%) scale(1.06); }
        .hero-btn.prev { left: 0.75rem; }
        .hero-btn.next { right: 0.75rem; }

        .hero-dots {
            pointer-events: auto;
            position: absolute;
            bottom: 0.75rem;
            left: 0;
            right: 0;
            display: flex;
            justify-content: center;
            gap: 0.5rem;
        }
        .hero-dot {
            width: 10px;
            height: 10px;
            border-radius: 9999px;
            border: none;
            cursor: pointer;
            background: rgba(255,255,255,0.55);
            transition: transform 0.2s ease, background 0.2s ease;
        }
        .hero-dot.active {
            background: #F7DE4F;
            transform: scale(1.2);
        }

        /* Small “trust” row under hero text */
        .trust-row {
            display: flex;
            flex-wrap: wrap;
            gap: 0.75rem;
            margin-top: 1.25rem;
            color: #4b5563;
            font-size: 0.95rem;
        }
        .trust-item {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: #fff;
            border: 1px solid #f3f4f6;
            padding: 0.6rem 0.85rem;
            border-radius: 0.9rem;
            box-shadow: 0 10px 22px rgba(0,0,0,0.06);
        }
        .dot-icon {
            width: 10px;
            height: 10px;
            border-radius: 9999px;
            background: #F7DE4F;
        }
    </style>

    <script>
        // Tailwind configuration
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        'primary-accent': '#F7DE4F',
                        'secondary-accent': '#F4D10B',
                        'links-hover': '#E2B000',
                        'web-bg': '#FCF2BB',
                        'text-dark': '#333333',
                    },
                    fontFamily: {
                        sans: ['Inter', 'sans-serif'],
                    },
                }
            }
        }
    </script>
</head>

<body class="bg-web-bg font-sans text-text-dark min-h-screen">

    <!-- Header / Navigation Bar -->
    <header class="shadow-md bg-white sticky top-0 z-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-20">
                <div class="flex-shrink-0">
                    <span class="text-2xl font-extrabold tracking-tight text-text-dark">
                        E-Community <span class="text-primary-accent">Platform</span>
                    </span>
                </div>

                <nav class="hidden md:flex space-x-8">
                    <a href="#home" class="nav-link font-semibold hover:text-links-hover py-2 rounded-lg transition duration-150 ease-in-out">HOME</a>
                    <a href="application.html" class="nav-link font-semibold hover:text-links-hover py-2 rounded-lg transition duration-150 ease-in-out">SERVICES</a>
                    <a href="#donations" class="nav-link font-semibold hover:text-links-hover py-2 rounded-lg transition duration-150 ease-in-out">DONATIONS</a>
                </nav>

                <!-- Login Button -->
                <div class="flex items-center space-x-4">
                    <a id="login" href="login.jsp" class="btn-primary px-5 py-2 text-sm font-bold rounded-full shadow-lg hover:shadow-xl uppercase">
                        LOGIN
                    </a>

                    <button id="mobile-menu-button" class="md:hidden text-text-dark focus:outline-none">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
                        </svg>
                    </button>
                </div>
            </div>
        </div>

        <div id="mobile-menu" class="hidden md:hidden bg-white border-t border-gray-100">
            <div class="pt-2 pb-3 space-y-1 sm:px-3">
                <a href="#home" class="nav-link block px-3 py-2 text-base font-medium">HOME</a>
                <a href="application.html" class="nav-link block px-3 py-2 text-base font-medium">SERVICES</a>
                <a href="#donations" class="nav-link block px-3 py-2 text-base font-medium">DONATIONS</a>
            </div>
        </div>
    </header>

    <!-- Main Content Container -->
    <main class="max-w-7xl mx-auto pt-8 pb-16 px-4 sm:px-6 lg:px-8">

        <!-- HOME Section -->
        <section id="home" class="mb-16 bg-white rounded-2xl shadow-2xl overflow-hidden p-6 sm:p-10">
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-10 items-center">

                <!-- Left text -->
                <div class="order-2 lg:order-1">
                    <h1 class="text-4xl sm:text-5xl lg:text-6xl font-extrabold leading-tight mb-4">
                        Building a Stronger, <span class="text-primary-accent">Caring Community</span>
                    </h1>
                    <p class="text-lg text-gray-600 mb-6">
                        Join our movement to connect volunteers with meaningful service opportunities and create positive, lasting change in the lives of those who need it most.
                    </p>

                    <div class="flex flex-col sm:flex-row gap-3">
                        <a href="application.html" class="btn-primary inline-flex items-center justify-center px-8 py-3 text-lg font-bold rounded-full shadow-xl">
                            Explore Opportunities
                        </a>

                        <a href="#donations" class="inline-flex items-center justify-center px-8 py-3 text-lg font-bold rounded-full border-2 border-primary-accent text-text-dark hover:bg-web-bg transition">
                            Support a Cause
                        </a>
                    </div>

                    <!-- Simple trust / highlights -->
                    <div class="trust-row">
                        <div class="trust-item"><span class="dot-icon"></span> Verified Projects</div>
                        <div class="trust-item"><span class="dot-icon"></span> Easy Volunteer Matching</div>
                        <div class="trust-item"><span class="dot-icon"></span> Track Your Impact</div>
                    </div>
                </div>

                <!-- Right hero carousel (background slides) -->
                <div class="order-1 lg:order-2">
                    <div class="hero-slider" id="heroSlider">
                        <!-- NOTE: use correct filenames from your project.
                             You showed: volunteer1.jpg, volunteer2.jpg, volunteer2.3.jpg, volunteer4.jpg
                        -->
                        <div class="hero-slide active"
                             style="background-image:url('<%= request.getContextPath() %>/images/volunteer1.jpg');">
                            <div class="hero-overlay"></div>
                            <div class="hero-content">
                                <h2>Touching Lives,<br/>Shaping a Better Community</h2>
                                <p>Be part of meaningful volunteer work that brings real change.</p>
                                <div class="hero-badges">
                                    <span class="badge">🌱 Environment</span>
                                    <span class="badge">🤝 Outreach</span>
                                    <span class="badge">📦 Aid</span>
                                </div>
                            </div>
                        </div>

                        <div class="hero-slide"
                             style="background-image:url('<%= request.getContextPath() %>/images/volunteer2.jpg');">
                            <div class="hero-overlay"></div>
                            <div class="hero-content">
                                <h2>Volunteer Together,<br/>Make Real Impact</h2>
                                <p>Find projects that match your skills, location, and time.</p>
                                <div class="hero-badges">
                                    <span class="badge">🛠️ Skills-Based</span>
                                    <span class="badge">📍 Nearby</span>
                                    <span class="badge">⏰ Flexible</span>
                                </div>
                            </div>
                        </div>

                        <div class="hero-slide"
                             style="background-image:url('<%= request.getContextPath() %>/images/volunteer3.jpg');">
                            <div class="hero-overlay"></div>
                            <div class="hero-content">
                                <h2>Support Families,<br/>Strengthen Communities</h2>
                                <p>Your time and effort can help people who need it most.</p>
                                <div class="hero-badges">
                                    <span class="badge">🍱 Food Aid</span>
                                    <span class="badge">🏘️ Community</span>
                                    <span class="badge">❤️ Care</span>
                                </div>
                            </div>
                        </div>

                        <div class="hero-slide"
                             style="background-image:url('<%= request.getContextPath() %>/images/volunteer4.jpg');">
                            <div class="hero-overlay"></div>
                            <div class="hero-content">
                                <h2>Create Change,<br/>One Project at a Time</h2>
                                <p>Track your volunteer hours and celebrate your progress.</p>
                                <div class="hero-badges">
                                    <span class="badge">📈 Impact</span>
                                    <span class="badge">🏅 Badges</span>
                                    <span class="badge">🧾 Records</span>
                                </div>
                            </div>
                        </div>

                        <!-- Controls -->
                        <div class="hero-controls">
                            <button class="hero-btn prev" id="heroPrev" aria-label="Previous slide">&#10094;</button>
                            <button class="hero-btn next" id="heroNext" aria-label="Next slide">&#10095;</button>

                            <div class="hero-dots" id="heroDots">
                                <button class="hero-dot active" data-index="0" aria-label="Slide 1"></button>
                                <button class="hero-dot" data-index="1" aria-label="Slide 2"></button>
                                <button class="hero-dot" data-index="2" aria-label="Slide 3"></button>
                                <button class="hero-dot" data-index="3" aria-label="Slide 4"></button>
                            </div>
                        </div>
                    </div>

                    <p class="text-sm text-gray-500 mt-3 text-center">
                        Tip: Use the arrows to browse community moments.
                    </p>
                </div>

            </div>
        </section>

        <!-- Who We Are / Mission / Vision -->
        <section class="grid grid-cols-1 md:grid-cols-3 gap-8 mb-16">
            <div class="bg-white p-6 rounded-xl shadow-lg hover:shadow-xl transition duration-300">
                <h2 id="who-we-are" class="text-2xl font-bold mb-3 border-b-2 border-primary-accent pb-2">Who We Are</h2>
                <p class="text-gray-600">
                    We are a dedicated group of community organizers, technologists, and passionate volunteers committed to simplifying the connection between those who need help and those who want to give it. Our platform ensures transparency and effectiveness in all service efforts.
                </p>
            </div>

            <div class="bg-white p-6 rounded-xl shadow-lg hover:shadow-xl transition duration-300">
                <h2 class="text-2xl font-bold mb-3 border-b-2 border-primary-accent pb-2">Our Vision</h2>
                <p class="text-gray-600">
                    A world where every community thrives on mutual support and every individual feels empowered to contribute to the greater good. We envision a seamless, friction-free volunteering ecosystem.
                </p>
            </div>

            <div class="bg-white p-6 rounded-xl shadow-lg hover:shadow-xl transition duration-300">
                <h2 class="text-2xl font-bold mb-3 border-b-2 border-primary-accent pb-2">Our Mission</h2>
                <p class="text-gray-600">
                    To provide a centralized, user-friendly digital platform that efficiently connects community projects with available volunteers and essential resources, maximizing societal impact with minimal administrative overhead.
                </p>
            </div>
        </section>

        <!-- SERVICES Section -->
        <section id="services" class="mb-16 pt-10">
            <h2 class="text-3xl sm:text-4xl font-extrabold text-center mb-6">Our Core Services</h2>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <div class="bg-white p-6 rounded-xl shadow-md border-t-4 border-primary-accent">
                    <span class="text-3xl text-primary-accent">🛠️</span>
                    <h3 class="text-xl font-bold mt-2 mb-2">Volunteer Matching</h3>
                    <p class="text-gray-600">Find opportunities based on your skills, location, and availability. Filter and apply instantly.</p>
                </div>
                <div class="bg-white p-6 rounded-xl shadow-md border-t-4 border-primary-accent">
                    <span class="text-3xl text-primary-accent">📈</span>
                    <h3 class="text-xl font-bold mt-2 mb-2">Impact Tracking</h3>
                    <p class="text-gray-600">See your hours, donations, and direct community impact in real-time on your personal dashboard.</p>
                </div>
                <div class="bg-white p-6 rounded-xl shadow-md border-t-4 border-primary-accent">
                    <span class="text-3xl text-primary-accent">📢</span>
                    <h3 class="text-xl font-bold mt-2 mb-2">Project Listings</h3>
                    <p class="text-gray-600">Non-profits can easily list and manage their service projects, recruit helpers, and solicit items.</p>
                </div>
            </div>
        </section>

        <!-- DONATIONS Section -->
        <section id="donations" class="pt-10">
            <h2 class="text-3xl sm:text-4xl font-extrabold text-center mb-6">Support Our Cause</h2>
            <div class="bg-white p-8 rounded-xl shadow-2xl text-center">
                <p class="text-lg text-gray-600 mb-6">
                    Your contribution helps us keep the platform running, supporting hundreds of community organizations and thousands of volunteers every day.
                </p>
                <a href="login.jsp" class="btn-primary px-8 py-3 text-lg font-bold rounded-full shadow-lg hover:shadow-xl transition duration-300 uppercase">
                    Make a Donation
                </a>
                <p class="text-sm mt-4 text-gray-500">All donations are secure and fully tax-deductible.</p>
            </div>
        </section>

    </main>

    <!-- Footer -->
    <footer class="bg-text-dark text-white py-6">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center text-sm">
            &copy; 2025 E-Community Service Platform. All rights reserved.
        </div>
    </footer>

    <script>
        // Mobile menu toggle
        document.getElementById('mobile-menu-button').addEventListener('click', function() {
            document.getElementById('mobile-menu').classList.toggle('hidden');
        });

        // Smooth scrolling
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                document.querySelector(this.getAttribute('href')).scrollIntoView({ behavior: 'smooth' });
                document.getElementById('mobile-menu').classList.add('hidden');
            });
        });

        // Hide login button if logged in
        const urlParams = new URLSearchParams(window.location.search);
        const logged = urlParams.get('logged');
        if (logged) {
            document.getElementById('login').style.display = 'none';
        }

        // HERO slider logic (basic)
        document.addEventListener('DOMContentLoaded', function () {
            const slides = document.querySelectorAll('#heroSlider .hero-slide');
            const dots = document.querySelectorAll('#heroDots .hero-dot');
            const prev = document.getElementById('heroPrev');
            const next = document.getElementById('heroNext');

            let idx = 0;
            let timer = null;

            function show(i) {
                idx = (i + slides.length) % slides.length;
                slides.forEach((s, n) => s.classList.toggle('active', n === idx));
                dots.forEach((d, n) => d.classList.toggle('active', n === idx));
            }

            function nextSlide() { show(idx + 1); }
            function prevSlide() { show(idx - 1); }

            next.addEventListener('click', () => { nextSlide(); restart(); });
            prev.addEventListener('click', () => { prevSlide(); restart(); });

            dots.forEach(d => {
                d.addEventListener('click', function () {
                    show(parseInt(this.dataset.index, 10));
                    restart();
                });
            });

            function start() { timer = setInterval(nextSlide, 4500); }
            function stop() { if (timer) clearInterval(timer); }
            function restart() { stop(); start(); }

            // pause on hover
            const slider = document.getElementById('heroSlider');
            slider.addEventListener('mouseenter', stop);
            slider.addEventListener('mouseleave', start);

            start();
        });
    </script>

</body>
</html>
