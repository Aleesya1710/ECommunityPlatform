<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Community Service - Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #FCF2BB; 
            color: #333;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            transition: background-color 0.3s;
        }
        .login-container {
            background-color: white; 
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .login-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        }
        h1 {
            color: #F7DE4F; 
            margin-bottom: 20px;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            background-color: #FFFFF8; 
        }
        button {
            background-color: #F7DE4F; 
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
            font-size: 16px;
            margin-top: 10px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: #F4D10B;
        }
        p {
            margin-top: 15px;
            font-size: 0.9em;
        }
        a {
            color: #F4D10B;
            text-decoration: none;
            font-weight: bold;
            transition: color 0.3s;
        }
        a:hover {
            text-decoration: underline;
            color: #E2B000;
        }
    </style>
</head>
<body>
    <%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    if (username != null && password != null) {

        if (username.equals("admin") && password.equals("123")) {
            response.sendRedirect("crud.html?logged=admin");
            return;
        } else if (username.equals("user") && password.equals("123")) {
            response.sendRedirect("dashboard.html?logged=user");
            return;
        } else {
            request.setAttribute("error", "Invalid login");
        }
    }
%>

    <div class="login-container">
        <h1>E-Community Login</h1>
        <form>
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">LOGIN</button>
        </form>
        <p>Don't have an account? <a href="registerAccount.jsp">Sign Up</a></p>
    </div>
</body>
</html>

