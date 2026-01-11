<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- Add this tag library at the top to enable loops --%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>List View Volunteer Program Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #fcf2bb; }
        .custom-scroll::-webkit-scrollbar { width: 8px; }
        .custom-scroll::-webkit-scrollbar-thumb { background-color: #f4d10b; border-radius: 10px; }
        .btn-custom { background-color: #F7DE4F; color: #1f2937; font-weight: 600; transition: 0.2s; }
        .btn-custom:hover { background-color: #F4D10B; }
    </style>
</head>
<body class="min-h-screen p-4 md:p-8">

    <div id="app" class="max-w-4xl mx-auto bg-white shadow-xl rounded-xl p-6 md:p-8">
        <header class="mb-8">
            <h1 class="text-4xl font-extrabold text-gray-900">Program Management Dashboard</h1>
            <p class="text-gray-500">Manage volunteer opportunities efficiently.</p>
        </header>

        <div id="listView" class="view">
            <div class="flex justify-between items-center mb-6">
                <h2 class="text-2xl font-semibold text-gray-800">Available Programs</h2>
                <a href="adminForm.html" class="btn-custom py-2 px-4 rounded-lg shadow-md flex items-center">
                   + Create New Program
                </a>
            </div>

            <div id="programList" class="space-y-4 custom-scroll max-h-96 overflow-y-auto pr-2">
                <c:forEach var="program" items="${programList}">
                    <div class="p-4 bg-gray-50 border border-gray-200 rounded-lg shadow-sm hover:shadow-md transition">
                        <h3 class="text-xl font-bold text-gray-800">${program.title}</h3>
                        <p class="text-sm text-gray-500 mb-2">${program.location} | ${program.date}</p>
                        <p class="text-gray-600 mb-4">${program.description}</p>
                        
                        <div class="flex space-x-3">
                            <a href="editAdminForm.jsp?id=${program.id}" class="text-blue-600 font-semibold hover:underline">Edit</a>
                            
                            <button onclick="showDeleteConfirm('${program.id}', '${program.title}')" class="text-red-600 font-semibold hover:underline">
                                Delete
                            </button>
                        </div>
                    </div>
                </c:forEach>
                
                <%-- Show this if the database list is empty --%>
                <c:if test="${empty programList}">
                    <p class="text-center text-gray-400 p-4">No programs found in the database.</p>
                </c:if>
            </div>
        </div>
    </div>

    <div id="deleteModal" class="hidden fixed inset-0 bg-gray-900 bg-opacity-50 flex items-center justify-center p-4 z-50">
        <div class="bg-white rounded-lg shadow-2xl w-full max-w-sm p-6">
            <h3 class="text-xl font-semibold text-red-600 mb-4">Confirm Deletion</h3>
            <p class="text-gray-700 mb-6">Are you sure you want to delete <strong id="programToDeleteTitle"></strong>?</p>
            <div class="flex justify-end space-x-3">
                <button onclick="hideDeleteConfirm()" class="px-4 py-2 bg-gray-200 rounded-lg">Cancel</button>
                <button onclick="confirmDelete()" class="px-4 py-2 bg-red-600 text-white rounded-lg">Yes, Delete</button>
            </div>
        </div>
    </div>

<script>
    // We only keep scripts for UI interactions (Modals)
    function showDeleteConfirm(id, title) {
        document.getElementById('programToDeleteTitle').textContent = title;
        document.getElementById('deleteModal').classList.remove('hidden');
        window.currentDeleteId = id; 
    }

    function hideDeleteConfirm() {
        document.getElementById('deleteModal').classList.add('hidden');
    }

    function confirmDelete() {
        // Redirect to a Servlet that handles SQL DELETE
        window.location.href = 'DeleteProgramServlet?id=' + window.currentDeleteId;
    }
</script>
</body>
</html>