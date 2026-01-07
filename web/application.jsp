<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>E-Community Apply Page</title>
<script src="https://cdn.tailwindcss.com"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap" rel="stylesheet">
<style>
    /* Custom CSS Overrides */
    .btn-primary {
        background-color: #F7DE4F;
        color: #333333; /* Dark text for better readability on yellow */
        transition: all 0.2s ease;
    }
    .btn-primary:hover {
        background-color: #F4D10B;
    }
    .nav-link {
        color: #333333;
        transition: color 0.2s ease;
    }
    .nav-link:hover {
        color: #E2B000; /* Links hover color */
    }
    /* Applying font color to specific elements */
    .text-primary-accent {
        color: #F7DE4F;
    }
    .signup-highlight {
        color: #F4D10B;
    }
</style>
<script>
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
<body class="bg-web-bg font-sans text-text-dark min-h-screen flex flex-col">

<header class="shadow-md bg-white sticky top-0 z-50">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center h-20">
            <div class="flex-shrink-0">
                <span class="text-2xl font-extrabold tracking-tight text-text-dark">
                    E-Community <span class="text-primary-accent">Platform</span>
                </span>
            </div>
            <nav class="hidden md:flex space-x-8">
                <a href="dashboard.html#homes" class="nav-link font-semibold py-2 rounded-lg transition duration-150 ease-in-out">HOME</a>
                <a href="application.jsp" class="nav-link font-semibold py-2 rounded-lg transition duration-150 ease-in-out">SERVICES</a>
                <a href="dashboard.html#donations" class="nav-link font-semibold py-2 rounded-lg transition duration-150 ease-in-out">DONATIONS</a>
            </nav>
            <div class="flex items-center space-x-4">
                <a id="login" href="login.jsp" class="btn-primary px-5 py-2 text-sm font-bold rounded-full shadow-lg hover:shadow-xl transform hover:scale-105 transition duration-300 ease-in-out uppercase">
                    LOGIN
                </a>
                <button id="mobile-menu-button" class="md:hidden text-text-dark focus:outline-none">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
                    </svg>
                </button>
            </div>
        </div>
    </div>
    <div id="mobile-menu" class="hidden md:hidden bg-white border-t border-gray-100">
        <div class="pt-2 pb-3 space-y-1 sm:px-3">
            <a href="dashboard.html" class="nav-link block px-3 py-2 text-base font-medium">HOME</a>
            <a href="application.jsp" class="nav-link block px-3 py-2 text-base font-medium">SERVICES</a>
            <a href="dashboard.html" class="nav-link block px-3 py-2 text-base font-medium">DONATIONS</a>
        </div>
    </div>
</header>

<main class="flex-1 max-w-7xl mx-auto pt-8 pb-16 px-4 sm:px-6 lg:px-8">
    <h1 class="text-4xl font-extrabold text-center mb-8">Available Programs</h1>
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6" id="programContainer"></div>
</main>

<footer class="bg-text-dark text-white py-6 mt-auto">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center text-sm">
        &copy; 2025 E-Community Service Platform. All rights reserved.
    </div>
</footer>

<div id="floatingForm" class="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50 z-[100] hidden">
    <form action="ApplicationServlet" method="post" class="bg-white p-6 rounded-xl shadow-2xl w-96">
        <h2 class="text-xl font-bold mb-4" id="formTitle">Apply for Program</h2>
        <input type="hidden" name="eventID" id="eventID">

        <input type="text" name="name" placeholder="Name.." class="w-full p-2 mb-2 border rounded focus:ring-2 focus:ring-primary-accent outline-none" required>
        <input type="text" name="phoneNum" placeholder="Phone Number.." class="w-full p-2 mb-2 border rounded focus:ring-2 focus:ring-primary-accent outline-none" required>
        <input type="text" name="ICnum" placeholder="IC Number.." class="w-full p-2 mb-2 border rounded focus:ring-2 focus:ring-primary-accent outline-none" required>

        <div class="flex justify-end space-x-2 mt-4">
            <button type="button" id="closeForm" class="px-4 py-2 rounded bg-gray-200 hover:bg-gray-300 transition">Cancel</button>
            <button type="submit" class="px-4 py-2 rounded btn-primary font-bold">Submit</button>
        </div>
    </form>
</div>

<script>
    // [Mobile menu, Smooth scroll, and URL check logic remains the same]
    document.getElementById('mobile-menu-button').addEventListener('click', function() {
        const menu = document.getElementById('mobile-menu');
        menu.classList.toggle('hidden');
    });

    const urlParams = new URLSearchParams(window.location.search);
    const logged = urlParams.get('logged');
    if (logged) {
        document.getElementById('login').style.display = 'none';
        const welcome = document.createElement('p');
        welcome.className = "font-bold text-primary-accent";
        welcome.textContent = `Welcome, ${logged}!`;
        document.querySelector('.flex.items-center.space-x-4').prepend(welcome);
    }

    function generateId() { return '_' + Math.random().toString(36).substr(2, 9); }

    const programs = [
        { id: generateId(), title: 'Community Clean-Up Day', description: 'A major initiative to clear litter and plant new saplings in the local park.', location: 'Taman Perdana', date: '2025-12-10' },
        { id: generateId(), title: 'Digital Literacy Workshop', description: 'Teaching basic computer and internet skills to senior citizens in the area.', location: 'Community Hall', date: '2025-12-15' }
    ];

    const container = document.getElementById('programContainer');
    const floatingForm = document.getElementById('floatingForm');
    const closeForm = document.getElementById('closeForm');
    const formTitle = document.getElementById('formTitle');

    programs.forEach(program => {
        const card = document.createElement('div');
        card.className = 'bg-white p-6 rounded-xl shadow-lg border-t-4 border-primary-accent';
        card.innerHTML = `
            <h3 class="text-xl font-bold mb-2">${program.title}</h3>
            <p class="text-gray-600 mb-1"><strong>Description:</strong> ${program.description}</p>
            <p class="text-gray-600 mb-1"><strong>Location:</strong> ${program.location}</p>
            <p class="text-gray-600 mb-3"><strong>Date:</strong> ${program.date}</p>
            <button class="btn-primary px-6 py-2 rounded-full mb-2 applyBtn font-bold shadow-md">Apply</button>
        `;
        container.appendChild(card);

        const applyBtn = card.querySelector('.applyBtn');
        applyBtn.addEventListener('click', () => {
            floatingForm.classList.remove('hidden');
            formTitle.textContent = `Apply for: ${program.title}`;
            document.getElementById('eventID').value = program.id;
        });
    });

    closeForm.addEventListener('click', () => {
        floatingForm.classList.add('hidden');
    });
</script>

</body>
</html>