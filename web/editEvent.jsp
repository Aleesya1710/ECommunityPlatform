<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="bean.Event" %>
<%@ page import="bean.Organization" %>
<%@ page import="java.util.List" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Event</title>
    <script src="https://cdn.tailwindcss.com"></script>
     <style>
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
<a href="listForm.jsp" 
   class="btn-custom fixed top-10 left-8 px-4 py-3 rounded-full shadow-lg z-40 flex items-center gap-2">
    &#8592; Back
</a>
<body class="bg-yellow-100 min-h-screen flex items-center justify-center p-4">

<div class="bg-white shadow-xl rounded-xl p-8 w-full max-w-lg">
    <h1 class="text-2xl font-bold mb-6">Edit Program</h1>
    <c:if test="${param.error != null}">
        <p class="text-red-600 mb-4">${param.error}</p>
    </c:if>

    <form action="EditEventServlet" method="post" class="space-y-4">
        <input type="hidden" name="id" value="${event.id}" />
        <div>
            <label class="block font-semibold">Program Name</label>
            <input type="text" name="name" value="${event.name}" required
                   class="w-full border rounded-lg p-2"/>
        </div>
        <div>
            <label class="block font-semibold">Description</label>
            <textarea name="description" required class="w-full border rounded-lg p-2">${event.description}</textarea>
        </div>
        <div>
            <label class="block font-semibold">Location</label>
            <input type="text" name="location" value="${event.location}" required
                   class="w-full border rounded-lg p-2"/>
        </div>
        <div>
            <label class="block font-semibold">Date & Time</label>
            <input type="datetime-local" name="time" value="${event.timeFormattedForInput}" required
                   class="w-full border rounded-lg p-2"/>
        </div>
        <div>
            <label for="organizationId" class="block text-sm font-medium text-gray-700">Select Organization *</label>
                <select id="organizationId" name="organizationId" 
                        class="mt-1 block w-full rounded-md border-gray-300 shadow-sm p-2 border focus:border-indigo-500 focus:ring-indigo-500" 
                        required>
                    <option value="">-- Choose an Organization --</option>
                    <% 
                        List<Organization> orgs = (List<Organization>) request.getAttribute("organizations");
                        Event event = (Event) request.getAttribute("event"); // get current event
                        if (orgs != null) {
                            for (Organization org : orgs) { 
                                boolean selected = (event.getOrganizationId() == org.getOrganizationId());
                    %>
                        <option value="<%= org.getOrganizationId() %>" <%= selected ? "selected" : "" %>>
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
        <div class="flex justify-between mt-6">
            <a href="listForm.jsp" class="px-4 py-2 bg-gray-200 rounded-lg">Cancel</a>
            <button type="submit" class="px-4 py-2 bg-blue-600 text-white rounded-lg">Save Changes</button>
        </div>
    </form>
</div>

</body>
</html>
