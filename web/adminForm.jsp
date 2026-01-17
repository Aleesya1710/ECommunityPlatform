<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="bean.Organization" %>
<%@ page import="dao.OrganizationDao" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Volunteer Form</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #fcf2bb;
        }
        
        .btn-custom {
            background-color: #F7DE4F; 
            color: #1f2937; 
            font-weight: 600;
            transition: background-color 0.2s;
        }
        .btn-custom:hover {
            background-color: #F4D10B; 
        }
    </style>
</head>
<body class="min-h-screen p-4 md:p-8">
    
    <%
        OrganizationDao orgDao = new OrganizationDao();
        List<Organization> organizations = orgDao.getAllOrganizations();

        String eventId = request.getParameter("id");
        String eventName = "";
        String eventDescription = "";
        String eventDate = "";
        String eventLocation = "";
        String selectedOrgId = "";
        
        if (eventId != null && !eventId.isEmpty()) {

        }
        
        String errMessage = (String) request.getAttribute("errMessage");
    %>
    
    <div class="max-w-2xl mx-auto bg-white shadow-xl rounded-xl p-6 md:p-8">
    
        <header class="mb-8">
            <h1 class="text-3xl font-bold text-gray-900">
                <%= (eventId != null && !eventId.isEmpty()) ? "Edit" : "Create" %> Volunteer Event
            </h1>
            <p class="text-gray-500 text-sm">Fill in the details below to publish a new opportunity.</p>
        </header>
<a href="listForm.jsp" 
   class="btn-custom fixed top-10 left-8 px-4 py-3 rounded-full shadow-lg z-40 flex items-center gap-2">
    &#8592; Back
</a>
        <% if (errMessage != null && !errMessage.isEmpty()) { %>
            <div class="mb-4 p-4 bg-red-100 border border-red-400 text-red-700 rounded">
                <%= errMessage %>
            </div>
        <% } %>

        <form id="programForm" action="AdminFormServlet" method="post" class="space-y-5">
            <input type="hidden" id="eventId" name="eventId" value="<%= eventId != null ? eventId : "" %>">
            <div>
                <label for="title" class="block text-sm font-medium text-gray-700">Event Title *</label>
                <input type="text" id="title" name="title" 
                       class="mt-1 block w-full rounded-md border-gray-300 shadow-sm p-2 border focus:border-indigo-500 focus:ring-indigo-500" 
                       placeholder="e.g., Beach Clean-Up" 
                       value="<%= eventName %>"
                       required>
            </div>
            <div>
                <label for="organizationId" class="block text-sm font-medium text-gray-700">Select Organization *</label>
                <select id="organizationId" name="organizationId" 
                        class="mt-1 block w-full rounded-md border-gray-300 shadow-sm p-2 border focus:border-indigo-500 focus:ring-indigo-500" 
                        required>
                    <option value="">-- Choose an Organization --</option>
                    <% 
                        if (organizations != null) {
                            for (Organization org : organizations) { 
                    %>
                        <option value="<%= org.getOrganizationId() %>" 
                                <%= selectedOrgId.equals(String.valueOf(org.getOrganizationId())) ? "selected" : "" %>>
                            <%= org.getOrganizationName() %>
                        </option>
                    <% 
                            }
                        } else {
                    %>
                        <option value="" disabled>No organizations available</option>
                    <% } %>
                </select>
                <p class="mt-1 text-xs text-gray-500">The organization that will host this event</p>
            </div>
            <div>
                <label for="description" class="block text-sm font-medium text-gray-700">Description *</label>
                <textarea id="description" name="description" rows="4" 
                          class="mt-1 block w-full rounded-md border-gray-300 shadow-sm p-2 border focus:border-indigo-500 focus:ring-indigo-500" 
                          placeholder="Provide a brief description of the activities and goals." 
                          required><%= eventDescription %></textarea>
            </div>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <label for="date" class="block text-sm font-medium text-gray-700">Date *</label>
                    <input type="datetime-local" id="date" name="date" 
                           class="mt-1 block w-full rounded-md border-gray-300 shadow-sm p-2 border focus:border-indigo-500 focus:ring-indigo-500" 
                           value="<%= eventDate %>"
                           required>
                </div>
                <div>
                    <label for="location" class="block text-sm font-medium text-gray-700">Location *</label>
                    <input type="text" id="location" name="location" 
                           class="mt-1 block w-full rounded-md border-gray-300 shadow-sm p-2 border focus:border-indigo-500 focus:ring-indigo-500" 
                           placeholder="e.g., City Center, School Hall" 
                           value="<%= eventLocation %>"
                           required>
                </div>
            </div>
            
            <div class="pt-4 flex justify-end space-x-3">
                <a href="listForm.jsp" class="px-4 py-2 text-sm font-medium text-gray-700 bg-gray-200 rounded-lg hover:bg-gray-300 transition duration-200">
                    Cancel
                </a>
                <button type="submit" id="saveButton" class="px-4 py-2 text-sm font-medium text-white bg-green-600 rounded-lg hover:bg-green-700 transition duration-200">
                    <%= (eventId != null && !eventId.isEmpty()) ? "Update Event" : "Create Event" %>
                </button>
            </div>
        </form>
    </div>
</body>
</html>