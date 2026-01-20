<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="bean.Event" %>
<%@ page import="dao.ApplicationDao" %>
<%@ page import="java.time.LocalDateTime" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<%
    HttpSession userSession = request.getSession(false);
    Integer userId = null;  
    userId = (Integer) userSession.getAttribute("userId");
    ApplicationDao dao = new ApplicationDao();
    List<Event> events = dao.getCustomerHistory(userId);
    LocalDateTime now = LocalDateTime.now();
    request.setAttribute("now", now);
    request.setAttribute("events", events);
%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Programs - Volunteer Program Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #fcf2bb; }
        .custom-scroll::-webkit-scrollbar { width: 8px; }
        .custom-scroll::-webkit-scrollbar-thumb { background-color: #f4d10b; border-radius: 10px; }
        .btn-custom { background-color: #F7DE4F; color: #1f2937; font-weight: 600; transition: 0.2s; }
        .btn-custom:hover { background-color: #F4D10B; }
        .status-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
        }
        .status-completed {
            background-color: #fee2e2;
            color: #991b1b;
        }
        .status-upcoming {
            background-color: #dcfce7;
            color: #166534;
        }
        .status-ongoing {
            background-color: #dbeafe;
            color: #1e40af;
        }
        .program-ended {
            opacity: 0.7;
            background-color: #f9fafb;
        }     
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }
        .modal.show {
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .modal-content {
            background-color: white;
            padding: 2rem;
            border-radius: 0.5rem;
            max-width: 500px;
            width: 90%;
        }
    </style>
</head>
<%@ include file="popupNotification.jsp" %>  
<body class="min-h-screen items-center">
<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="My Programs - E-Community Platform" />
</jsp:include>

                
<div id="app" class="max-w-4xl mx-auto bg-white shadow-xl rounded-xl mt-10 p-6 md:p-8">
    <header class="mb-8">
        <h1 class="text-4xl font-extrabold text-gray-900">My Programs</h1>
        <p class="text-gray-500">View all programs you've registered for.</p>
    </header>

    <div id="listView" class="view">
        <div class="flex justify-between items-center mb-6">
            <h2 class="text-2xl font-semibold text-gray-800">Registered Programs</h2>
        </div>

        <div id="programList" class="space-y-4 custom-scroll max-h-96 overflow-y-auto pr-2">
            <c:forEach var="program" items="${events}">
                <%
                    Event program = (Event) pageContext.getAttribute("program");
                    LocalDateTime programTime = program.getTime();
                    LocalDateTime currentTime = (LocalDateTime) request.getAttribute("now");
                    
                    String statusClass = "";
                    String statusText = "";
                    String cardClass = "";
                    boolean canCancel = false;
                    
                    if (programTime.isBefore(currentTime)) {
                        statusClass = "status-completed";
                        statusText = "Completed";
                        cardClass = "program-ended";
                        canCancel = false;
                    } else if (programTime.toLocalDate().equals(currentTime.toLocalDate())) {
                        statusClass = "status-ongoing";
                        statusText = "Today";
                        cardClass = "";
                        canCancel = false;
                    } else {
                        statusClass = "status-upcoming";
                        statusText = "Upcoming";
                        cardClass = "";
                        canCancel = true;
                    }
                    
                    pageContext.setAttribute("statusClass", statusClass);
                    pageContext.setAttribute("statusText", statusText);
                    pageContext.setAttribute("cardClass", cardClass);
                    pageContext.setAttribute("canCancel", canCancel);
                %>
                
                <div class="p-4 bg-gray-50 border border-gray-200 rounded-lg shadow-sm hover:shadow-md transition ${cardClass}">
                    <div class="flex justify-between items-start mb-2">
                        <h3 class="text-xl font-bold text-gray-800">${program.name}</h3>
                        <span class="status-badge ${statusClass}">${statusText}</span>
                    </div>
                    
                    <p class="text-sm text-gray-500 mb-2">
                        📍 ${program.location} <br>
                        📅 Date: ${program.formattedDate} <br>
                        🕐 Time: ${program.formattedTime12}
                    </p>
                    
                    <p class="text-gray-600 mb-4">${program.description}</p>

                    <c:if test="${statusText == 'Completed'}">
                        <div class="mt-3 p-3 bg-red-50 border border-red-200 rounded-md">
                            <p class="text-sm text-red-700">
                                ✓ This program has ended
                            </p>
                        </div>
                    </c:if>
                    
                    <c:if test="${statusText == 'Today'}">
                        <div class="mt-3 p-3 bg-blue-50 border border-blue-200 rounded-md">
                            <p class="text-sm text-blue-700">
                                🔔 This program is happening today!
                            </p>
                        </div>
                    </c:if>
                    
                    <c:if test="${canCancel}">
                        <div class="mt-4 flex justify-end">
                            <button onclick="showCancelConfirm('${program.id}', '${program.name}')" 
                                    class="px-4 py-2 bg-red-500 text-white font-semibold rounded-lg hover:bg-red-600 transition">
                                Cancel Registration
                            </button>
                        </div>
                    </c:if>
                </div>
            </c:forEach>

            <c:if test="${empty events}">
                <div class="text-center py-12">
                    <p class="text-gray-400 text-lg mb-4">No programs found.</p>
                    <a href="application.jsp" class="btn-custom py-2 px-6 rounded-lg shadow-md inline-block">
                        Browse Available Programs
                    </a>
                </div>
            </c:if>
        </div>
    </div>
</div>

<div id="cancelModal" class="modal">
    <div class="modal-content">
        <h2 class="text-2xl font-bold text-gray-900 mb-4">Cancel Registration</h2>
        <p class="text-gray-600 mb-6">
            Are you sure you want to cancel your registration for <strong id="cancelProgramName"></strong>?
        </p>
        <div class="flex justify-end space-x-3">
            <button onclick="closeCancelModal()" 
                    class="px-4 py-2 bg-gray-300 text-gray-700 font-semibold rounded-lg hover:bg-gray-400 transition">
                No, Keep It
            </button>
            <button onclick="confirmCancel()" 
                    class="px-4 py-2 bg-red-500 text-white font-semibold rounded-lg hover:bg-red-600 transition">
                Yes, Cancel
            </button>
        </div>
    </div>
</div>

<script>
    let currentCancelId = null;

    function showCancelConfirm(eventId, eventName) {
        currentCancelId = eventId;
        document.getElementById('cancelProgramName').textContent = eventName;
        document.getElementById('cancelModal').classList.add('show');
    }

    function closeCancelModal() {
        document.getElementById('cancelModal').classList.remove('show');
        currentCancelId = null;
    }

    function confirmCancel() {
        if (currentCancelId) {
            window.location.href = 'CancelRegistrationServlet?eventId=' + currentCancelId;
        }
    }

    window.onclick = function(event) {
        const modal = document.getElementById('cancelModal');
        if (event.target === modal) {
            closeCancelModal();
        }
    }
</script>

</body>
</html>