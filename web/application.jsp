<%@page import="java.time.format.DateTimeFormatter"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="bean.Event" %>
<%@ page import="dao.ApplicationDao" %>
<%
    ApplicationDao dao = new ApplicationDao();
    List<Event> events = dao.getAllEvent();

    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
    DateTimeFormatter timeFormatter12 = DateTimeFormatter.ofPattern("h:mm a");
    List<String> uniqueLocations = new ArrayList<String>();
    if (events != null && !events.isEmpty()) {
        for (Event event : events) {
            if (!uniqueLocations.contains(event.getLocation())) {
                uniqueLocations.add(event.getLocation());
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>E-Community Apply Page</title>
<script src="https://cdn.tailwindcss.com"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap" rel="stylesheet">
<style>
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
</head>
<body class="bg-web-bg font-sans text-text-dark min-h-screen flex flex-col">
<%@ include file="header.jsp" %>
<%@ include file="popupNotification.jsp" %>  
<main class="flex-1 max-w-7xl mx-auto pt-8 pb-16 px-4 sm:px-6 lg:px-8">
    <h1 class="text-4xl font-extrabold text-center mb-8">Available Programs</h1>
    <div class="bg-white p-6 rounded-xl shadow-lg mb-6">
        <h2 class="text-xl font-bold mb-4">Filter Events</h2>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
            <div>
                <label class="block text-sm font-semibold mb-2">Search Event</label>
                <input type="text" id="searchInput" placeholder="Search by name..." 
                       class="w-full p-2 border rounded focus:ring-2 focus:ring-primary-accent outline-none">
            </div>
            <div>
                <label class="block text-sm font-semibold mb-2">Location</label>
                <select id="locationFilter" class="w-full p-2 border rounded focus:ring-2 focus:ring-primary-accent outline-none">
                    <option value="">All Locations</option>
                    <%
                        for (String location : uniqueLocations) {
                    %>
                        <option value="<%= location %>"><%= location %></option>
                    <% 
                        }
                    %>
                </select>
            </div>
            <div>
                <label class="block text-sm font-semibold mb-2">Date From</label>
                <input type="date" id="dateFilter" 
                       class="w-full p-2 border rounded focus:ring-2 focus:ring-primary-accent outline-none">
            </div>
        </div>

    </div>   
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6" id="eventsContainer">
        <%
            if (events != null && !events.isEmpty()) {
                Integer sessionUserId = (Integer) session.getAttribute("userId");              
                for (Event event : events) {
                    boolean isRegistered = false;
                    if (sessionUserId != null) {
                        isRegistered = dao.isUserRegistered(sessionUserId, event.getId());
                    }
        %>
            <div class='event-card bg-white p-6 rounded-xl shadow-lg border-t-4 <%= isRegistered ? "border-gray-400 opacity-75" : "border-primary-accent" %>'
                 data-name="<%= event.getName().toLowerCase() %>"
                 data-location="<%= event.getLocation() %>"
                 data-date="<%= event.getTime().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) %>"
                 data-registered="<%= isRegistered %>">               
                <h3 class="text-xl font-bold mb-2"><%= event.getName() %></h3>
                <p class="text-gray-600 mb-1"><strong>Description:</strong> <%= event.getDescription() %></p>
                <p class="text-gray-600 mb-1"><strong>Location:</strong> <%= event.getLocation() %></p>
                <p class="text-gray-600 mb-3"><strong>Date:</strong> <%= event.getTime().format(dateFormatter) %></p>
                <p class="text-gray-600 mb-3"><strong>Time:</strong> <%= event.getTime().format(timeFormatter12) %></p>            
                <% if (isRegistered) { %>
                    <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-2 rounded mb-2">
                        <strong>✓ Already Registered</strong>
                    </div>
                    <button class="bg-gray-400 text-white px-6 py-2 rounded-full font-bold cursor-not-allowed" disabled>
                        Registered
                    </button>
                <% } else { %>
                    <button class="btn-primary px-6 py-2 rounded-full mb-2 applyBtn font-bold shadow-md" 
                            onclick="openForm('<%= event.getName() %>', <%= event.getId() %>)">
                        Apply
                    </button>
                <% } %>
            </div>
        <%
                }
            } else {
        %>
            <div class="col-span-2 text-center text-gray-500 py-8" id="noEventsInitial">
                <p class="text-xl">No events available at the moment.</p>
            </div>
        <%
            }
        %>
    </div>
    
    <div id="noFilterResults" class="hidden col-span-2 text-center py-8">
        <div class="bg-yellow-50 border border-yellow-200 rounded-lg p-6 inline-block">
            <svg class="mx-auto h-12 w-12 text-yellow-400 mb-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.172 16.172a4 4 0 015.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
            <p class="text-xl font-semibold text-gray-700">No events match your filters</p>
            <p class="text-gray-500 mt-2">Try adjusting your search criteria</p>
        </div>
    </div>
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
    const mobileMenuButton = document.getElementById('mobile-menu-button');
    if (mobileMenuButton) {
        mobileMenuButton.addEventListener('click', function() {
            const menu = document.getElementById('mobile-menu');
            menu.classList.toggle('hidden');
        });
    }
    const urlParams = new URLSearchParams(window.location.search);
    const logged = urlParams.get('logged');
    if (logged) {
        const loginElement = document.getElementById('login');
        if (loginElement) {
            loginElement.style.display = 'none';
        }
        const welcome = document.createElement('p');
        welcome.className = "font-bold text-primary-accent";
        welcome.textContent = 'Welcome, ' + logged + '!';
        const flexContainer = document.querySelector('.flex.items-center.space-x-4');
        if (flexContainer) {
            flexContainer.prepend(welcome);
        }
    }
    function openForm(eventName, eventId) {
        document.getElementById('floatingForm').classList.remove('hidden');
        document.getElementById('formTitle').textContent = 'Apply for: ' + eventName;
        document.getElementById('eventID').value = eventId;
    }
    
    document.getElementById('closeForm').addEventListener('click', function() {
        document.getElementById('floatingForm').classList.add('hidden');
    });
    function filterEvents() {
        const searchTerm = document.getElementById('searchInput').value.toLowerCase();
        const locationFilter = document.getElementById('locationFilter').value;
        const dateFilter = document.getElementById('dateFilter').value;
        
        const eventCards = document.querySelectorAll('.event-card');
        const noFilterResults = document.getElementById('noFilterResults');
        const eventsContainer = document.getElementById('eventsContainer');
        let visibleCount = 0;
        
        eventCards.forEach(card => {
            const name = card.getAttribute('data-name');
            const location = card.getAttribute('data-location');
            const date = card.getAttribute('data-date');
            
            let showCard = true;
            if (searchTerm && !name.includes(searchTerm)) {
                showCard = false;
            }         
            if (locationFilter && location !== locationFilter) {
                showCard = false;
            }
            if (dateFilter && date < dateFilter) {
                showCard = false;
            }
            if (showCard) {
                card.style.display = 'block';
                visibleCount++;
            } else {
                card.style.display = 'none';
            }
        });
        
        if (visibleCount === 0 && eventCards.length > 0) {
            noFilterResults.classList.remove('hidden');
            eventsContainer.appendChild(noFilterResults);
        } else {
            noFilterResults.classList.add('hidden');
        }
    }
    
    document.getElementById('searchInput').addEventListener('input', filterEvents);
    document.getElementById('locationFilter').addEventListener('change', filterEvents);
    document.getElementById('dateFilter').addEventListener('change', filterEvents);
    
    window.addEventListener('DOMContentLoaded', function() {
        filterEvents();
    });
</script>

</body>
</html>