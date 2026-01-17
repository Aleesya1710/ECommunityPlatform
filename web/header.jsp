<script src="https://cdn.tailwindcss.com"></script>
<style>
    /* Your existing styles */
    .btn-primary {
        background-color: #F7DE4F;
        color: #333333;
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
        color: #E2B000;
    }
    .text-primary-accent {
        color: #F7DE4F;
    }
    .signup-highlight {
        color: #F4D10B;
    }
</style>

<%
   HttpSession userSession = request.getSession(false);
    Integer userId = null;
    String userName = null;
    
    if (userSession != null) {
        userId = (Integer) userSession.getAttribute("userId");
        userName = (String) userSession.getAttribute("username");
    }
    
    if (userId == null) {
        response.sendRedirect("login.jsp?error=Please login to view events");
        return;
    }
%>

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
                <a href="donation.jsp" class="nav-link font-semibold py-2 rounded-lg transition duration-150 ease-in-out">DONATIONS</a>
            </nav>
            <div class="flex items-center space-x-4">
                <% if (userId == null) { %>
                    <a id="login" href="login.jsp" class="btn-primary px-5 py-2 text-sm font-bold rounded-full shadow-lg hover:shadow-xl transform hover:scale-105 transition duration-300 ease-in-out uppercase">
                        LOGIN
                    </a>
                <% } else { %>
                    <span class="text-text-dark font-semibold hidden md:inline">Welcome, <%= userName != null ? userName : "User" %>!</span>
                    <a href="logout.jsp" class="btn-primary px-5 py-2 text-sm font-bold rounded-full shadow-lg hover:shadow-xl transform hover:scale-105 transition duration-300 ease-in-out uppercase">
                        LOGOUT
                    </a>
                <% } %>
                
                <button id="mobile-menu-button" class="md:hidden text-text-dark focus:outline-none">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
                    </svg>
                </button>
            </div>
        </div>
    </div>
    <div id="mobile-menu" class="hidden md:hidden bg-white border-t border-gray-100">
        <div class="pt-2 pb-3 space-y-1 px-3">
            <a href="dashboard.html" class="nav-link block px-3 py-2 text-base font-medium">HOME</a>
            <a href="application.jsp" class="nav-link block px-3 py-2 text-base font-medium">SERVICES</a>
            <a href="donation.jsp" class="nav-link block px-3 py-2 text-base font-medium">DONATIONS</a>
            <% if (userId == null) { %>
                <a href="login.jsp" class="nav-link block px-3 py-2 text-base font-medium">LOGIN</a>
            <% } else { %>
                <div class="px-3 py-2 text-base font-medium text-text-dark">Welcome, <%= userName != null ? userName : "User" %>!</div>
                <a href="logout.jsp" class="nav-link block px-3 py-2 text-base font-medium">LOGOUT</a>
            <% } %>
        </div>
    </div>
</header>