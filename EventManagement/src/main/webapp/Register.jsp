<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>User Registration</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background: #f0f2f5;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .register-box {
            background: #fff;
            padding: 40px 30px;
            width: 350px;
            box-shadow: 0 0 15px rgba(0,0,0,0.2);
            border-radius: 10px;
            text-align: center;
        }

        .register-box h2 {
            margin-bottom: 30px;
            font-weight: 700;
            color: #333;
        }

        .register-box input[type="text"],
        .register-box input[type="email"],
        .register-box input[type="password"],
        .register-box input[type="number"] {
            width: 91%;
            padding: 12px 15px;
            margin: 12px 0;
            border: 1.5px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }

        .register-box input[type="text"]:focus,
        .register-box input[type="email"]:focus,
       .register-box input[type="password"]:focus,
        .register-box input[type="number"]:focus {
            border-color: #007BFF;
            outline: none;
        }

        .register-box input[type="submit"] {
            width: 91%;
            padding: 12px 0;
            background-color: #007BFF;
            border: none;
            border-radius: 6px;
            color: white;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            margin-top: 20px;
            transition: background-color 0.3s ease;
        }

        .register-box input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .login-link {
            margin-top: 20px;
            font-size: 14px;
            color: #555;
        }

        .login-link a {
            color: #007BFF;
            text-decoration: none;
            font-weight: 600;
        }

        .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="register-box">
    <h2>User Registration</h2>

    <!-- Optional: Display error or success message from server -->
    <% 
        String msg = (String) request.getAttribute("msg");
        if (msg != null) {
    %>
        <p style="color: green; font-weight: bold;"><%= msg %></p>
    <% } %>
    
    
    
    
    
    

    <form action="RegisterServlet" method="post">
        <input type="text" name="name" placeholder="Full Name" required><br>
        <input type="email" name="email" placeholder="Email" required><br>
        <input type="password" name="password" placeholder="Password" required><br>
        <input type="number" name="age" placeholder="Age " required><br>
        <input type="submit" value="Register">
    </form>

    <div class="login-link">
        Already registered? <a href="Login.jsp">Click here to Login</a>
    </div>
</div>

</body>
</html>
