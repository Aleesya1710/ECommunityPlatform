<%@page import="java.time.format.DateTimeFormatter"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="bean.Event" %>
<%@ page import="dao.ApplicationDao" %>

<%
    ApplicationDao dao = new ApplicationDao();
    List<Event> events = dao.getAllEvent();


DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
DateTimeFormatter timeFormatter12 = DateTimeFormatter.ofPattern("h:mm a");
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
</head>
<body class="bg-web-bg font-sans text-text-dark min-h-screen flex flex-col">

<%@ include file="header.jsp" %>
<%@ include file="popupNotification.jsp" %>  

<main class="flex-1 max-w-7xl mx-auto pt-8 pb-16 px-4 sm:px-6 lg:px-8">
    <h1 class="text-4xl font-extrabold text-center mb-8">Available Programs</h1>
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <%
            if (events != null && !events.isEmpty()) {
                for (Event event : events) {
        %>
            <div class='bg-white p-6 rounded-xl shadow-lg border-t-4 border-primary-accent'>
                <h3 class="text-xl font-bold mb-2"><%= event.getName() %></h3>
                <p class="text-gray-600 mb-1"><strong>Description:</strong> <%= event.getDescription() %></p>
                <p class="text-gray-600 mb-1"><strong>Location:</strong> <%= event.getLocation() %></p>
                <p class="text-gray-600 mb-3"><strong>Date:</strong> <%= event.getTime().format(dateFormatter)  %></p>
                <p class="text-gray-600 mb-3"><strong>Time:</strong> <%= event.getTime().format(timeFormatter12)  %></p>
                <button class="btn-primary px-6 py-2 rounded-full mb-2 applyBtn font-bold shadow-md" 
                        onclick="openForm('<%= event.getName() %>', <%= event.getId() %>)">
                    Apply
                </button>
            </div>
        <%
                }
            } else {
        %>
            <div class="col-span-2 text-center text-gray-500">
                <p>No events available at the moment.</p>
            </div>
        <%
            }
        %>
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
        welcome.textContent = 'Welcome, ' + logged + '!';
        document.querySelector('.flex.items-center.space-x-4').prepend(welcome);
    }
    function openForm(eventName, eventId) {
        document.getElementById('floatingForm').classList.remove('hidden');
        document.getElementById('formTitle').textContent = 'Apply for: ' + eventName;
        document.getElementById('eventID').value = eventId;
    }
    document.getElementById('closeForm').addEventListener('click', function() {
        document.getElementById('floatingForm').classList.add('hidden');
    });
</script>

</body>
</html>