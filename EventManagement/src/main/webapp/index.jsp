<%@ page session="true" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Event Portal</title>

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Bootstrap Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <!-- FontAwesome -->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
  <!-- Custom CSS -->
  <link rel="stylesheet" href="event.css">
</head>

<body>

 <!-- Include Navbar -->
    <jsp:include page="navbar.jsp" />

<!-- Hero Section -->
<section class="hero-section">
  <div class="overlay"></div>
  <div class="content text-white text-center slide-left">
    <h1>Welcome to Event Portal</h1>
    <p>Register, Discover, and Manage Your Events Easily!</p>
<%
    String userName = (String) session.getAttribute("name");
    if (userName == null) {
%>
    <!-- If not logged in → go to Login -->
    <a href="Login.jsp" class="btn btn-danger btn-lg">Explore Events</a>
<%
    } else {
%>
    <!-- If logged in → go to view_events.jsp -->
    <a href="view_event.jsp" class="btn btn-danger btn-lg">Explore Events</a>
<%
    }
%>
  </div>
</section>



<!-- Footer -->
<footer class="bg-dark text-white text-center py-3">
  &copy; 2025 Event Portal. All rights reserved.
</footer>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
