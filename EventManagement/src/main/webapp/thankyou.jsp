<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Thank You</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom CSS -->
  <link rel="stylesheet" href="event.css">
  
    <style>
        body {
            background-color: #f8f9fa;
            background:unset;
        }
        .thankyou-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 80vh;
            text-align: center;
        }
        .card {
            border-radius: 15px;
            padding: 30px;
        }
        .emoji {
            font-size: 3rem;
        }
    </style>
</head>
<body>
    <!-- Include Navbar -->
    <jsp:include page="navbar.jsp" />

    <div class="container thankyou-container">
        <div class="card shadow-lg">
            <div class="emoji mb-3">🙏</div>
            <h2 class="mb-3">Thank You for Your Feedback!</h2>
            <p class="text-muted">We truly appreciate your input. Your feedback helps us improve our events and services.</p>
            <a href="index.jsp" class="btn btn-primary mt-3">Back to Home</a>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
