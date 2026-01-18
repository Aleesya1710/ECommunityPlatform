<%-- 
    Document   : popupNotification
    Created on : Jan 18, 2026, 3:57:03 PM
    Author     : Hp V
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="toast-container" style="position: fixed; top: 20px; right: 20px; z-index: 9999; display: flex; flex-direction: column; gap: 10px;">
</div>

<style>
    .toast {
        min-width: 300px;
        max-width: 500px;
        padding: 16px 20px;
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        display: flex;
        align-items: center;
        gap: 12px;
        animation: slideIn 0.3s ease-out;
        font-family: 'Inter', sans-serif;
        font-size: 14px;
        color: white;
    }
    
    .toast-success {
        background-color: #10b981;
    }
    
    .toast-error {
        background-color: #ef4444;
    }
    
    .toast-warning {
        background-color: #f59e0b;
    }
    
    .toast-info {
        background-color: #3b82f6;
    }
    
    .toast-icon {
        font-size: 20px;
        flex-shrink: 0;
    }
    
    .toast-message {
        flex: 1;
        font-weight: 500;
    }
    
    .toast-close {
        background: none;
        border: none;
        color: white;
        font-size: 20px;
        cursor: pointer;
        padding: 0;
        width: 24px;
        height: 24px;
        display: flex;
        align-items: center;
        justify-content: center;
        opacity: 0.8;
        transition: opacity 0.2s;
    }
    
    .toast-close:hover {
        opacity: 1;
    }
    
    @keyframes slideIn {
        from {
            transform: translateX(400px);
            opacity: 0;
        }
        to {
            transform: translateX(0);
            opacity: 1;
        }
    }
    
    @keyframes slideOut {
        from {
            transform: translateX(0);
            opacity: 1;
        }
        to {
            transform: translateX(400px);
            opacity: 0;
        }
    }
    
    .toast-exit {
        animation: slideOut 0.3s ease-out forwards;
    }
</style>

<script>
    function showToast(message, type = 'success', duration = 4000) {
        const container = document.getElementById('toast-container');
        const toast = document.createElement('div');
        toast.className = 'toast toast-' + type;
        let icon = '';
        switch(type) {
            case 'success':
                icon = '✓';
                break;
            case 'error':
                icon = '✕';
                break;
            case 'warning':
                icon = '⚠';
                break;
            case 'info':
                icon = 'ℹ';
                break;
        }
        
        toast.innerHTML = `
            <span class="toast-icon">` + icon + `</span> 
            <span class="toast-message">` + message + `</span>
            <button class="toast-close" onclick="dismissToast(this)">×</button>
        `;
        container.appendChild(toast);
        setTimeout(function() {
            dismissToast(toast.querySelector('.toast-close'));
        }, duration);
    }
    function dismissToast(closeButton) {
        const toast = closeButton.closest('.toast');
        toast.classList.add('toast-exit');
        
        setTimeout(function() {
            toast.remove();
        }, 300);
    }
  document.addEventListener('DOMContentLoaded', function () {
    const urlParams = new URLSearchParams(window.location.search);
    let shown = false;

    if (urlParams.get('created') === 'true') {
        showToast('Event created successfully!', 'success');
        shown = true;
    } else if (urlParams.get('registered') === 'true') {
        showToast('Successfully registered for the event!', 'success');
        shown = true;
    } else if (urlParams.get('added') === 'true') {
        showToast('Organization added successfully!', 'success');
        shown = true;
    } else if (urlParams.get('updated') === 'true') {
        showToast('Updated successfully!', 'success');
        shown = true;
    } else if (urlParams.get('deleted') === 'true') {
        showToast('Deleted successfully!', 'success');
        shown = true;
    } else if (urlParams.get('error') === 'true') {
        showToast('An error occurred. Please try again.', 'error');
        shown = true;
    }
          if (shown) {
        setTimeout(() => {
            const cleanUrl = window.location.pathname;
            window.history.replaceState({}, document.title, cleanUrl);
        }, 100);
    }
    });
</script>
