<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="bean.Organization" %>
<%@ page import="dao.OrganizationDao" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    HttpSession userSession = request.getSession(false);
    Integer userId = null;
    String userName = null;
    if (userSession != null) {
        userId = (Integer) userSession.getAttribute("userId");
        userName = (String) userSession.getAttribute("username");
    }
    if (userId == null) {
        response.sendRedirect("login.jsp?error=Please login to view organizations");
        return;
    }

    OrganizationDao orgDao = new OrganizationDao();
    List<Organization> organizations = orgDao.getAllOrganizations();
    request.setAttribute("organizations", organizations);
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Manage Organizations</title>
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
<body class="min-h-screen">

<!-- HEADER -->
<header class="bg-white shadow-md">
    <div class="max-w-full mx-auto px-6 py-4 flex flex-col md:flex-row justify-between items-center">
        <h1 class="text-3xl font-extrabold text-gray-900 mb-2 md:mb-0">Staff Dashboard</h1>
        <div class="flex items-center gap-4">
            <span class="font-semibold text-gray-800">Welcome, <%= userName %></span>
            <a href="LogoutServlet" class="bg-red-600 hover:bg-red-700 text-white font-bold py-2 px-4 rounded-lg shadow">Logout</a>
        </div>
    </div>
</header>
<a href="staffDashboard.jsp" 
   class="btn-custom fixed top-24 left-8 px-4 py-3 rounded-full shadow-lg z-40 flex items-center gap-2">
    &#8592; Dashboard
</a>
<div id="app" class="max-w-4xl mx-auto bg-white shadow-xl rounded-xl mt-10 p-6 md:p-8">
    <header class="mb-8">
        <h1 class="text-4xl font-extrabold text-gray-900">Organization Management</h1>
        <p class="text-gray-500">Add, edit, or delete organizations without leaving this page.</p>
    </header>

    <div id="listView" class="view">
        
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-2xl font-semibold text-gray-800">Organizations</h2>
            <button class="btn-custom py-2 px-4 rounded-lg shadow-md flex items-center" onclick="showAddModal()">+ Add Organization</button>
        </div>
        <div id="organizationList" class="space-y-4 custom-scroll max-h-96 overflow-y-auto pr-2">
            <c:forEach var="org" items="${organizations}">
                <div class="p-4 bg-gray-50 border border-gray-200 rounded-lg shadow-sm hover:shadow-md transition flex justify-between items-center">
                    <div>
                        <h3 class="text-xl font-bold text-gray-800">${org.organizationName}</h3>
                        <p class="text-gray-600">${org.organizationEmail}</p>
                    </div>

                    <div class="flex space-x-3">
                        <button onclick="showEditModal('${org.organizationId}', '${org.organizationName}', '${org.organizationEmail}')" class="text-blue-600 font-semibold hover:underline">
                            Edit
                        </button>
                        <button onclick="showDeleteModal('${org.organizationId}', '${org.organizationName}')" class="text-red-600 font-semibold hover:underline">
                            Delete
                        </button>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty organizations}">
                <p class="text-center text-gray-400 p-4">No organizations found in the database.</p>
            </c:if>
        </div>
    </div>
</div>
<!-- Back to Dashboard FAB -->


<!-- ADD MODAL -->
<div id="addModal" class="hidden fixed inset-0 bg-gray-900 bg-opacity-50 flex items-center justify-center p-4 z-50">
    <div class="bg-white rounded-lg shadow-2xl w-full max-w-sm p-6">
        <h3 class="text-xl font-semibold text-gray-900 mb-4">Add New Organization</h3>
        <form action="manageOrganizations" method="post">
            <input type="hidden" name="action" value="add">
            <input type="text" name="organizationName" placeholder="Organization Name" class="w-full mb-3 p-2 border rounded" required>
            <input type="email" name="organizationEmail" placeholder="Email" class="w-full mb-3 p-2 border rounded" required>
            <div class="flex justify-end space-x-3">
                <button type="button" onclick="hideAddModal()" class="px-4 py-2 bg-gray-200 rounded-lg">Cancel</button>
                <button type="submit" class="px-4 py-2 bg-green-600 text-white rounded-lg">Add</button>
            </div>
        </form>
    </div>
</div>

<!-- EDIT MODAL -->
<div id="editModal" class="hidden fixed inset-0 bg-gray-900 bg-opacity-50 flex items-center justify-center p-4 z-50">
    <div class="bg-white rounded-lg shadow-2xl w-full max-w-sm p-6">
        <h3 class="text-xl font-semibold text-gray-900 mb-4">Edit Organization</h3>
        <form action="manageOrganizations" method="post">
            <input type="hidden" name="action" value="edit">
            <input type="hidden" name="organizationId" id="editOrgId">
            <input type="text" name="organizationName" id="editOrgName" placeholder="Organization Name" class="w-full mb-3 p-2 border rounded" required>
            <input type="email" name="organizationEmail" id="editOrgEmail" placeholder="Email" class="w-full mb-3 p-2 border rounded" required>
            <div class="flex justify-end space-x-3">
                <button type="button" onclick="hideEditModal()" class="px-4 py-2 bg-gray-200 rounded-lg">Cancel</button>
                <button type="submit" class="px-4 py-2 bg-blue-600 text-white rounded-lg">Save</button>
            </div>
        </form>
    </div>
</div>

<!-- DELETE MODAL -->
<div id="deleteModal" class="hidden fixed inset-0 bg-gray-900 bg-opacity-50 flex items-center justify-center p-4 z-50">
    <div class="bg-white rounded-lg shadow-2xl w-full max-w-sm p-6">
        <h3 class="text-xl font-semibold text-red-600 mb-4">Confirm Deletion</h3>
        <p class="text-gray-700 mb-6">Are you sure you want to delete <strong id="deleteOrgName"></strong>?</p>
        <div class="flex justify-end space-x-3">
            <button onclick="hideDeleteModal()" class="px-4 py-2 bg-gray-200 rounded-lg">Cancel</button>
            <button onclick="confirmDelete()" class="px-4 py-2 bg-red-600 text-white rounded-lg">Yes, Delete</button>
        </div>
    </div>
</div>

<script>
    // Add Modal
    function showAddModal() { document.getElementById('addModal').classList.remove('hidden'); }
    function hideAddModal() { document.getElementById('addModal').classList.add('hidden'); }

    // Edit Modal
    function showEditModal(id, name, email) {
        document.getElementById('editOrgId').value = id;
        document.getElementById('editOrgName').value = name;
        document.getElementById('editOrgEmail').value = email;
        document.getElementById('editModal').classList.remove('hidden');
    }
    function hideEditModal() { document.getElementById('editModal').classList.add('hidden'); }

    // Delete Modal
    let currentDeleteId = null;
    function showDeleteModal(id, name) {
        currentDeleteId = id;
        document.getElementById('deleteOrgName').textContent = name;
        document.getElementById('deleteModal').classList.remove('hidden');
    }
    function hideDeleteModal() { document.getElementById('deleteModal').classList.add('hidden'); }
    function confirmDelete() { window.location.href = 'deleteOrganization?id=' + currentDeleteId; }
</script>

</body>
</html>
