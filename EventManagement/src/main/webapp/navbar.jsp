<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
 <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- Bootstrap Icons (optional) -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <!-- FontAwesome Icons (optional) -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

  <style>
     body{
      .user-view {
    /* Example: a larger margin for users */
}
     }
  </style>
</head>
<body>
<!-- Navbar Start -->
<nav class="navbar navbar-expand-lg custom-navbar bg-dark fixed-top">
<%
    String role1 = (String) session.getAttribute("role");
    String mainContentClass = "";

    if (role1 != null) {
        if (role1.equals("user")) {
            mainContentClass = "user-view";
        } else if (role1.equals("admin")) {
            mainContentClass = "admin-view";
        }
    }
%>
  <div class="container-fluid <%= mainContentClass %>">
    <a class="navbar-brand text-white fw-bold" href="#">Event</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
      aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
      <ul class="navbar-nav">
        <%
          String name = (String) session.getAttribute("name");
          String role = (String) session.getAttribute("role");
          
          if (name == null) {
        %>
          <li class="nav-item">
            <a class="nav-link " href="admin_login.jsp"><i class="fa-solid fa-user-tie"></i> <strong>Admin</strong></a>
          </li>
          <li class="nav-item">
            <a class="nav-link " href="Login.jsp"><i class="fa-solid fa-user"></i> <b>User</b></a>
          </li>
        <%
          } else if ("admin".equals(role)) {
        %>
          <li class="nav-item">
            <a class="nav-link text-white" href="#"><i class="fa-solid fa-user-tie"></i><STRONG> Welcome, <%=name%></STRONG></a>
          </li>
          
        <%
          } else if ("user".equals(role)) {
        	  
        %>
        <!-- User-specific links -->
    <li class="nav-item">
      <a class="nav-link" href="view_event.jsp"><i class="fa-solid fa-calendar-days"></i> <strong>View Events</strong></a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="feedbacks.jsp"><i class="fa-solid fa-comment-dots"></i> <strong>Feedback</strong></a>
    </li>

    <!-- User info and logout -->
    <li class="nav-item">
      <a class="nav-link text-white" href="index.jsp"><i class="fa-solid fa-user"></i><strong> Welcome, <%= name %></strong></a>
    </li>
    <li class="nav-item">
      <a class="nav-link " href="logout.jsp"><b>🚪 Logout</b></a>
    </li>
        <%
          }
        //  session.removeAttribute("name");
         
        %>
      </ul>
    </div>
  </div>
</nav>
<!-- Navbar End -->
</body>
</html>