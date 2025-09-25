<%@ page import="java.sql.*" %>
<%
    // Check if user is logged in (optional)
    String name = (String) session.getAttribute("name");
    if (name == null) {
        response.sendRedirect("user_login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Events</title>
    <link rel="stylesheet" href="event.css">
    <style>
        body {
            background: unset;
            
        }
       
        
        .btn{
            margin-left: 113px;
        }
    </style>
</head>
<body>

<jsp:include page="navbar.jsp" />

<div class="container my-1">
    <h2 class="mb-4 text-center">Upcoming Events</h2>

    <div class="row g-4">
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/Event", "root", "root");
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM events");

                while (rs.next()) {
                    String image = rs.getString("image");
                    if (image == null || image.trim().isEmpty()) {
                        image = "default.jpg"; // fallback image
                    }
        %>
        <div class="col-md-4">
            <div class="card h-100 shadow">
                <img src="Uploads/<%= image %>" class="card-img-top" alt="Event Image" height=200px>
                <div class="card-body">
                    <h5 class="card-title"><%= rs.getString("name") %></h5>
                    <p class="card-text"><%= rs.getString("description") %></p>
                    <p><strong>Date:</strong> <%= rs.getDate("event_date") %></p>
                    <p><strong>Venue:</strong> <%= rs.getString("location") %></p>
                    <a href="register_event.jsp" class="btn btn-primary">Register</a>
                </div>
            </div>
        </div>
        <%
                }
                rs.close();
                stmt.close();
                con.close();
            } catch (Exception e) {
        %>
        <div class="col-12 text-danger">
            <strong>Error:</strong> <%= e.getMessage() %>
        </div>
        <%
            }
        %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
