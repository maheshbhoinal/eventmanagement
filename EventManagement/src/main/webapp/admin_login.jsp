<%@page import="java.io.PrintWriter"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Admin Login</title>
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

        .login-box {
            background: #fff;
            padding: 40px 30px;
            width: 350px;
            box-shadow: 0 0 15px rgba(0,0,0,0.2);
            border-radius: 10px;
            text-align: center;
        }

        .login-box h2 {
            margin-bottom: 30px;
            font-weight: 700;
            color: #333;
        }

        .login-box input[type="email"],
        .login-box input[type="password"] {
            width: 91%;
            padding: 12px 15px;
            margin: 12px 0;
            border: 1.5px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
            transition: border-color 0.3s ease;
        }

        .login-box input[type="email"]:focus,
        .login-box input[type="password"]:focus {
            border-color: #007BFF;
            outline: none;
        }

        .login-box input[type="submit"] {
            width: 100%;
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

        .login-box input[type="submit"]:hover {
            background-color: #0056b3;
        }

       
    </style>
</head>
<body>

<div class="login-box">
    <h2>Admin Login</h2>

    <!-- Optional: Display error message from servlet -->
<%
    String loginError = (String) session.getAttribute("loginError");
    if(loginError!=null){
    
%>
    <p style="color: red; font-weight: bold;"><strong><%=loginError %></strong></p>
<%
    
      //  session.removeAttribute("loginError"); // Prevent showing again on refresh
    }
%>


    

    <form action="AdminLoginServlet" method="post">
        <input type="email" name="email" placeholder="Email" required><br>
        <input type="password" name="password" placeholder="Password" required><br>
        <input type="submit" value="Login">
    </form>

    
</div>

</body>
</html>
