<%@ page import="java.sql.*" %>
<%
String name = (String) session.getAttribute("name");
String email = (String) session.getAttribute("email"); // get email from session
if (name == null || email == null) {
    response.sendRedirect("admin_login.jsp");
    return;
}

   
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Feedback</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom CSS -->
  <link rel="stylesheet" href="event.css">
  
  <style>
   body {
            background: unset;
        }
        .mt-n3 {
  margin-top: -2rem !important;
}

  
  </style>
</head>
<body class="bg-white">

 <!-- Include Navbar -->
    <jsp:include page="navbar.jsp" />

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6 mt-n3">
            <div class="card shadow-lg">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">Event Feedback</h4>
                </div>
                <div class="card-body">
                    <form action="SubmitFeedbackServlet" method="post">
                        <!-- Name -->
                        <div class="mb-3">
                            <label class="form-label">Your Name</label>
                            <input type="text" class="form-control" name="name" value="<%=name%>" readonly>
                        </div>

                        <!-- Email -->
                        <div class="mb-3">
                            <label class="form-label">Your Email</label>
                            <input type="email" class="form-control" name="email" value="<%=email%>" readonly>
                        </div>

                        <!-- Rating -->
                        <div class="mb-3">
                            <label class="form-label">Rating</label>
                            <select class="form-select" name="rating" required>
                                <option value="">Choose...</option>
                                <option value="5"><span style="color: orange;">&#9733;&#9733;&#9733;&#9733;&#9733;</span> Excellent</option>
                                <option value="4"><span style="color: orange;">&#9733;&#9733;&#9733;&#9733;</span> Good</option>
                                <option value="3"><span style="color: orange;">&#9733;&#9733;&#9733;</span> Average</option>
                                <option value="2"><span style="color: orange;">&#9733;&#9733;</span> Poor</option>
                                <option value="1"><span style="color: orange;">&#9733;</span> Very Bad</option>
                            </select>
                        </div>

                        <!-- Comments -->
                        <div class="mb-3">
                            <label class="form-label">Comments</label>
                            <textarea class="form-control" name="comments" rows="3" required></textarea>
                        </div>

                        <!-- Submit -->
                        <button type="submit" class="btn btn-primary w-100">Submit Feedback</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>