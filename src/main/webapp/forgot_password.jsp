<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Forgot Password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card shadow-lg border-0 rounded-3">
                <div class="card-body p-4">
                    <h3 class="text-center mb-4">Forgot Password</h3>

                    <form action="ForgotPasswordServlet" method="post">
                        <div class="mb-3">
                            <label class="form-label">Enter your registered Email</label>
                            <input type="email" name="email" class="form-control" required>
                        </div>
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">Send Reset Link</button>
                        </div>
                    </form>

                    <p class="text-center mt-3">
                        <a href="Login.jsp">Back to Login</a>
                    </p>

                    <% String msg = (String) request.getAttribute("message");
                       if (msg != null) { %>
                       <div class="alert alert-info text-center mt-3"><%= msg %></div>
                    <% } %>

                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
