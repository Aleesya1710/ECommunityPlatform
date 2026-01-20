<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="Staff Dashboard - E-Community Platform" />
</jsp:include>
<style>
    .stat-card {
        background: white;
        border-radius: 12px;
        padding: 24px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        transition: transform 0.2s;
    }
    .stat-card:hover {
        transform: translateY(-4px);
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    }
    .chart-container {
        background: white;
        border-radius: 12px;
        padding: 24px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        margin-top: 24px;
    }
</style>
<body class="bg-[#FCF2BB]">
<main class="bg-[#FCF2BB] flex-1 max-w-7xl mx-auto pt-8 pb-16 px-4 sm:px-6 lg:px-8 w-full">
    <div class="mb-8">
        <h1 class="text-4xl font-extrabold text-gray-900">Staff Dashboard</h1>
        <p class="text-gray-600 mt-2">Welcome back, <span class="font-semibold"><%= username %></span>! Monitor and manage volunteer programs.</p>
    </div>
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        <a href="adminForm.jsp" class="stat-card cursor-pointer border-l-4 border-[#F7DE4F]">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-gray-500 text-sm font-medium">Create New</p>
                    <p class="text-2xl font-bold text-gray-900 mt-1">Program</p>
                </div>
                <div class="bg-green-100 p-3 rounded-full">
                    <svg class="w-8 h-8 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"/>
                    </svg>
                </div>
            </div>
        </a>      
        <a href="listForm.jsp" class="stat-card cursor-pointer border-l-4 border-[#F7DE4F]">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-gray-500 text-sm font-medium">Manage</p>
                    <p class="text-2xl font-bold text-gray-900 mt-1">Programs</p>
                </div>
                <div class="bg-blue-100 p-3 rounded-full">
                    <svg class="w-8 h-8 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
                    </svg>
                </div>
            </div>
        </a>
        <a href="manageOrganizations.jsp" class="stat-card cursor-pointer border-l-4 border-[#F7DE4F]">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-gray-500 text-sm font-medium">Manage</p>
                    <p class="text-2xl font-bold text-gray-900 mt-1">Organization</p>
                </div>
                <div class="bg-purple-100 p-3 rounded-full">
                    <svg class="w-8 h-8 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"/>
                    </svg>
                </div>
            </div>
        </a>
    </div>
    <div class="chart-container">
        <div class="flex justify-between items-center mb-6">
            <div>
                <h2 class="text-2xl font-bold text-gray-900">Volunteer Statistics</h2>
                <p class="text-gray-600 text-sm mt-1">Number of registered volunteers per event</p>
            </div>
        </div>
        <div id="loadingChart" class="text-center py-12">
            <div class="inline-block animate-spin rounded-full h-12 w-12 border-b-2 border-[#F7DE4F]"></div>
            <p class="text-gray-600 mt-4">Loading statistics...</p>
        </div>
        <canvas id="volunteerChart" style="display:none; max-height: 400px;"></canvas>

        <div id="emptyState" style="display:none;" class="text-center py-12">
            <svg class="w-16 h-16 text-gray-400 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
            </svg>
            <p class="text-gray-600 text-lg">No events found</p>
            <p class="text-gray-500 text-sm mt-2">Create your first event to see statistics</p>
        </div>
    </div>
    <div class="mt-6 grid grid-cols-1 md:grid-cols-1 gap-6">
        <div id="insightCard" class="stat-card border-l-4 border-[#F7DE4F]">
            <h3 class="text-lg font-bold text-gray-900 mb-2">💡 Quick Insights</h3>
            <div id="insights" class="text-gray-700 space-y-2 text-sm">
                <p>Loading insights...</p>
            </div>
        </div>
    </div>
</main>
</body>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<script>
    let volunteerChart = null;
   
    document.addEventListener('DOMContentLoaded', function() {
        loadChartData();
    });
    
     function loadChartData() {
        document.getElementById('loadingChart').style.display = 'block';
        document.getElementById('volunteerChart').style.display = 'none';
        document.getElementById('emptyState').style.display = 'none';
        
        fetch('EventRegistrationServlet')
            .then(response => {            
                return response.json();
            })
            .then(data => {              
                if (data.length === 0) {
                    showEmptyState();
                } else {
                    renderChart(data);
                    generateInsights(data);
                }
            })
            .catch(error => {
                console.error('Error loading chart data:', error);
                showError();
            });
    }
    
    function renderChart(data) {
        document.getElementById('loadingChart').style.display = 'none';
        document.getElementById('volunteerChart').style.display = 'block';
        const labels = data.map(item => item.eventName);
        const values = data.map(item => item.volunteerCount);
        if (volunteerChart) {
            volunteerChart.destroy();
        }
        const ctx = document.getElementById('volunteerChart').getContext('2d');
        volunteerChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Number of Volunteers',
                    data: values,
                    backgroundColor: 'rgba(247, 222, 79, 0.8)',
                    borderColor: 'rgba(244, 209, 11, 1)',
                    borderWidth: 2,
                    borderRadius: 6,
                    hoverBackgroundColor: 'rgba(244, 209, 11, 0.9)'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,
                plugins: {
                    legend: {
                        display: true,
                        position: 'top',
                    },
                    title: {
                        display: false
                    },
                    tooltip: {
                        backgroundColor: 'rgba(0, 0, 0, 0.8)',
                        padding: 12,
                        titleFont: {
                            size: 14,
                            weight: 'bold'
                        },
                        bodyFont: {
                            size: 13
                        }
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            stepSize: 1,
                            font: {
                                size: 12
                            }
                        },
                        title: {
                            display: true,
                            text: 'Number of Volunteers',
                            font: {
                                size: 14,
                                weight: 'bold'
                            }
                        }
                    },
                    x: {
                        ticks: {
                            font: {
                                size: 12
                            },
                            maxRotation: 45,
                            minRotation: 45
                        },
                        title: {
                            display: true,
                            text: 'Event Name',
                            font: {
                                size: 14,
                                weight: 'bold'
                            }
                        }
                    }
                }
            }
        });
    }
    
     function generateInsights(data) {
        const insightsDiv = document.getElementById('insights');       
        if (!data || data.length === 0) {
            insightsDiv.innerHTML = '<p class="text-gray-500">No data available</p>';
            return;
        }       
        try {
            const totalVolunteers = data.reduce((sum, item) => {
                const count = parseInt(item.volunteerCount) || 0;
                return sum + count;
            }, 0);          
            const avgVolunteers = data.length > 0 ? (totalVolunteers / data.length).toFixed(1) : '0';
            
            let mostPopular = data[0];
            for (let item of data) {
                if ((item.volunteerCount || 0) > (mostPopular.volunteerCount || 0)) {
                    mostPopular = item;
                }
            }          
            let leastPopular = data[0];
            for (let item of data) {
                if ((item.volunteerCount || 0) < (leastPopular.volunteerCount || 0)) {
                    leastPopular = item;
                }
            }          
         /*   console.log('debug', {
                totalVolunteers: totalVolunteers,
                avgVolunteers: avgVolunteers,
                mostPopular: mostPopular,
                leastPopular: leastPopular
            });           */
            let html = '<p><strong>Total volunteers registered:</strong> ' + totalVolunteers + '</p>';
            html += '<p><strong>Average per event:</strong> ' + avgVolunteers + '</p>';
            html += '<p><strong>Most popular:</strong> ' + (mostPopular.eventName || 'N/A') + ' (' + (mostPopular.volunteerCount || 0) + ' volunteers)</p>';          
            if (leastPopular.volunteerCount === 0) {
                html += '<p class="text-orange-600"><strong>⚠️ No registrations:</strong> ' + leastPopular.eventName + '</p>';
            } else if (leastPopular.volunteerCount < avgVolunteers / 2) {
                html += '<p class="text-orange-600"><strong>⚠️ Low interest:</strong> ' + leastPopular.eventName + ' (' + leastPopular.volunteerCount + ' volunteers)</p>';
            }         
            insightsDiv.innerHTML = html;
           // console.log('debug');     
        } catch (error) {
          //  console.error('debug1', error);
            insightsDiv.innerHTML = '<p class="text-red-600">Error calculating insights</p>';
        }
    }
    
    function showEmptyState() {
        document.getElementById('loadingChart').style.display = 'none';
        document.getElementById('volunteerChart').style.display = 'none';
        document.getElementById('emptyState').style.display = 'block';
    }
    
    function showError() {
        document.getElementById('loadingChart').style.display = 'none';
        alert('Error loading chart data. Please try again.');
    }
    
</script>