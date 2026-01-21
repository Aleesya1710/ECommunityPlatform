<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Community Service - Sign Up</title>
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
        
        .signup-container {
            background-color: white; 
            padding: 40px;
            border-radius: 10px;
            width: 350px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            position: relative;
        }
        
        .signup-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        }
        
        .close-btn {
            position: absolute;
            top: 15px;
            right: 15px;
            background-color: transparent;
            color: #999;
            border: none;
            font-size: 24px;
            cursor: pointer;
            width: auto;
            padding: 0;
            margin: 0;
            line-height: 1;
            transition: color 0.3s ease;
        }
        
        .close-btn:hover {
            color: #333;
            background-color: transparent;
        }
        
        .error-message {
            background-color: #ffebee;
            color: #c62828;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
            border-left: 4px solid #c62828;
            text-align: left;
            font-size: 0.9em;
        }
        
        label {
            display: block;
            text-align: left;
            margin-right: 5px;
        }
        
        h1 {
            color: #F7DE4F; 
            margin-bottom: 20px;
        }
        
        input[type="text"], input[type="password"], input[type="email"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
            background-color: #FFFFF8; 
            margin-bottom: 20px;  
        }
        
        button[type="submit"] {
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
        
        button[type="submit"]:hover {
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
    <div class="signup-container">
        <button type="button" class="close-btn" onclick="window.history.back()">×</button>
        <h1>Create Account</h1>
        
        <% 
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null && !errorMessage.isEmpty()) {
        %>
            <div class="error-message">
                <%= errorMessage %>
            </div>
        <% } %>
        
        <form action="RegisterServlet" method="POST">
            <label> Full Name: </label>
            <input type="text" name="fullname" placeholder="Full Name" required>
            
            <label> Username: </label>
            <input type="text" name="username" placeholder="Username" required>
            
            <label> Password: </label>
            <input type="password" name="password" placeholder="Password" required>
            
            <label> Confirm Password: </label>
            <input type="password" name="confirmPassword" placeholder="Confirm Password" required>
            
            <button type="submit">SIGN UP</button>
        </form>
    </div>
</body>
</html>