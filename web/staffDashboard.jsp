<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="dao.ApplicationDao, dao.OrganizationDao" %>

<%
    String username = null;
    String role = null;

    if (session != null) {
        username = (String) session.getAttribute("username");
        role = (String) session.getAttribute("role");
    }

    if (username == null || !"staff".equals(role)) {
        response.sendRedirect("login.jsp?error=Please login as staff to access dashboard");
        return;
    }

    int totalEvents = 0;
    int totalOrganizations = 0;

    try {
        ApplicationDao eventDAO = new ApplicationDao();
        OrganizationDao orgDAO = new OrganizationDao();

        totalEvents = eventDAO.getTotalEvent();
        totalOrganizations = orgDAO.getTotalOrganizations();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Staff Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>

    <style>
        body { font-family: 'Inter', sans-serif; }
        .card {
            transition: all 0.3s ease;
        }
        .card:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 24px rgba(0,0,0,0.2);
        }
    </style>
</head>

<body class="bg-[#FCF2BB] min-h-screen flex flex-col">
<header class="bg-white shadow-md">
    <div class="max-w-full mx-auto px-6 py-4 flex flex-col md:flex-row justify-between items-center">
        <h1 class="text-3xl font-extrabold text-gray-900 mb-2 md:mb-0">
            Staff Dashboard
        </h1>

        <div class="flex items-center gap-4">
            <span class="font-semibold text-gray-800">
                Welcome, <%= username %>
            </span>
            <a href="LogoutServlet"
               class="bg-red-600 hover:bg-red-700 text-white font-bold py-2 px-4 rounded-lg shadow">
                Logout
            </a>
        </div>
    </div>
</header>

<main class="flex-grow max-w-6xl mx-auto px-6 py-10">
    <div class="grid grid-cols-1 sm:grid-cols-2 gap-6 mb-12">

        <div class="bg-white rounded-xl shadow-md p-6 text-center">
            <h3 class="text-gray-500 uppercase text-sm font-semibold">
                Total Events
            </h3>
            <p class="text-4xl font-extrabold text-yellow-500 mt-2">
                <%= totalEvents %>
            </p>
        </div>

        <div class="bg-white rounded-xl shadow-md p-6 text-center">
            <h3 class="text-gray-500 uppercase text-sm font-semibold">
                Total Organizations
            </h3>
            <p class="text-4xl font-extrabold text-yellow-500 mt-2">
                <%= totalOrganizations %>
            </p>
        </div>

    </div>
    <p class="text-gray-700 mb-8 text-lg text-center">
        Manage volunteer events efficiently using the options below
    </p>
    <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-2 gap-8">
        <a href="listForm.jsp"
           class="card bg-white rounded-xl shadow-md p-6 flex flex-col items-center justify-center hover:bg-yellow-50">

            <svg xmlns="http://www.w3.org/2000/svg" class="h-14 w-14 text-yellow-400 mb-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
            </svg>

            <h2 class="text-xl font-bold text-gray-800 mb-1">Manage Events</h2>
            <p class="text-gray-500 text-center text-sm">
                Add, Edit or delete events
            </p>
        </a>
        
        <a href="manageOrganizations.jsp"
           class="card bg-white rounded-xl shadow-md p-6 flex flex-col items-center justify-center hover:bg-yellow-50">

            <svg xmlns="http://www.w3.org/2000/svg" class="h-14 w-14 text-yellow-400 mb-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M17 20h5v-2a4 4 0 00-3-3.87M9 20H4v-2a4 4 0 013-3.87M16 7a4 4 0 11-8 0 4 4 0 018 0z" />
            </svg>

            <h2 class="text-xl font-bold text-gray-800 mb-1">Manage Organization</h2>
            <p class="text-gray-500 text-center text-sm">
                Add, Edit or delete Organizations
            </p>
        </a>

    </div>
</main>
<footer class="bg-[#333333] text-white py-6">
    <div class="max-w-7xl mx-auto px-4 text-center text-sm">
        &copy; 2025 E-Community Service Platform. All rights reserved.
    </div>
</footer>

</body>
</html>
