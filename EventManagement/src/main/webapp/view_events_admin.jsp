<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View All Events - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
     
       
    </style>
</head>
<body>
 
 <!-- Include Navbar -->
    <jsp:include page="navbar.jsp" />
<div class="container mt-4">
 
    <h3 class="mb-3 text-center">All Events</h3>
    <table class="table table-bordered table-striped">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Date</th>
                <th>Time</th>
                <th>Location</th>
                <th>Category</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Event", "root", "root");
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM events");

                while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getDate("event_date") %></td>
                <td><%= rs.getString("event_time") %></td>
                <td><%= rs.getString("location") %></td>
                <td><%= rs.getString("category") %></td>
                <td>
                    <a href="edit_event.jsp?id=<%= rs.getInt("id") %>" class="btn btn-sm btn-primary">Edit</a>
                    <a href="delete_event.jsp?id=<%= rs.getInt("id") %>" class="btn btn-sm btn-danger" onclick="return confirm('Delete this event?')">Delete</a>
                </td>
            </tr>
        <%
                }
                conn.close();
            } catch (Exception e) {
                out.println("<tr><td colspan='8' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
            }
        %>
        </tbody>
    </table>
</div>

</body>
</html>
