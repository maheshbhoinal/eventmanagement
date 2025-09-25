<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
</head>
<body>
<!-- File: admin_sidebar.jsp -->
<div class="sidebar">
    
    <a href="admin_home.jsp"><i class="bi bi-house-door-fill"></i> Home</a>
    <a href="add_event.jsp"><i class="bi bi-calendar-plus"></i> Add Event</a>
    <a href="manage_event.jsp"><i class="bi bi-card-list"></i> Manage Events</a>
    <a href="view_registrations.jsp"><i class="bi bi-people-fill"></i> View Registrations</a>
    <a href="admin_feedback.jsp"><i class="bi bi-chat-left-text"></i> Feedback</a>
    
   <a href="logout.jsp" class="logout" ><i class="bi bi-box-arrow-right"></i> Logout</a>

   
</div>

<style>

    .sidebar {
        position: fixed;
    top: 56px;   /* start below navbar */
    left: 0;
    width: 240px;
    height: calc(100vh - 56px); /* fill remaining screen height */
    background-color: #343a40;
    color: #fff;
    overflow-y: auto;
    }


    .sidebar a {
        color: #fff;
        padding: 12px 20px;
        display: block;
        text-decoration: none;
    }
    .sidebar a:hover {
        background-color: #495057;
    }
    
    body{
    margin-top:50px /* Same as navbar height */
    }
    
    
</style>

</body>
</html>