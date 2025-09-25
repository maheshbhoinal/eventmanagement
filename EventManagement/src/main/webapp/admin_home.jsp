<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Session check
    String name = (String) session.getAttribute("name");
    if (name == null) {
        response.sendRedirect("admin_login.jsp");
        return;
    }

    int totalEvents = 0;
    int totalUsers = 0;
    int totalRegistrations = 0;
    int totalFeedbacks = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Event", "root", "root");

        Statement st = con.createStatement();

        // Total events
        ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM events");
        if (rs.next()) totalEvents = rs.getInt(1);
        rs.close();

        // Total users
        rs = st.executeQuery("SELECT COUNT(*) FROM users");
        if (rs.next()) totalUsers = rs.getInt(1);
        rs.close();

        // Total registrations
        rs = st.executeQuery("SELECT COUNT(*) FROM registrations");
        if (rs.next()) totalRegistrations = rs.getInt(1);
        rs.close();

        // Total feedback
        rs = st.executeQuery("SELECT COUNT(*) FROM feedback");
        if (rs.next()) totalFeedbacks = rs.getInt(1);
        rs.close();

        st.close();
        con.close();

    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap 5 + Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body, html {
            height: 100%;
            overflow: hidden;
        }
        .main {
            display: flex;
            min-height: 100vh;
        }
        .main-content {
            flex-grow: 1;
            padding: 20px;
            background-color: #f8f9fa;
            margin-left: 240px; /* space for sidebar */
            overflow-y: auto;
        }
        .card {
            border-radius: 15px;
        }
    </style>
</head>
<body>
    <jsp:include page="navbar.jsp" />

    <div class="main">
        <!-- Sidebar -->
        <jsp:include page="admin_sidebar.jsp" />

        <!-- Main Content -->
        <div class="main-content">
            <h4>Welcome, <%= name %>!</h4>
            <p class="text-muted">Here’s what’s happening in your system:</p>

            <div class="row g-4 mb-4">
                <div class="col-md-3">
                    <div class="card text-white bg-primary shadow">
                        <div class="card-body text-center">
                            <h5 class="card-title"><i class="bi bi-calendar-event-fill"></i> Total Events</h5>
                            <p class="card-text fs-4"><%= totalEvents %></p>
                            <a href="manage_event.jsp" class="btn btn-light btn-sm">Manage</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card text-white bg-success shadow">
                        <div class="card-body text-center">
                            <h5 class="card-title"><i class="bi bi-people-fill"></i> Users</h5>
                            <p class="card-text fs-4"><%= totalUsers %></p>
                            <a href="manage_users.jsp" class="btn btn-light btn-sm">Manage</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card text-white bg-warning shadow">
                        <div class="card-body text-center">
                            <h5 class="card-title"><i class="bi bi-pencil-square"></i> Registrations</h5>
                            <p class="card-text fs-4"><%= totalRegistrations %></p>
                            <a href="view_registrations.jsp" class="btn btn-light btn-sm">View</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card text-white bg-danger shadow">
                        <div class="card-body text-center">
                            <h5 class="card-title"><i class="bi bi-chat-dots-fill"></i> Feedback</h5>
                            <p class="card-text fs-4"><%= totalFeedbacks %></p>
                            <a href="admin_feedback.jsp" class="btn btn-light btn-sm">View</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Optional: Recent Registrations Table -->
            <div class="mt-4">
                <h5>Recent Registrations</h5>
                <table class="table table-striped table-hover mt-2">
                    <thead class="table-dark">
                        <tr>
                            <th>User</th>
                            <th>Event</th>
                            <th>Date</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Event", "root", "root");
                            Statement st = con.createStatement();
                            String query = "SELECT r.name AS user_name, e.name AS event_name, " +
                                    "DATE_FORMAT(e.event_date, '%d-%m-%Y') AS event_date " +
                                    "FROM registrations r " +
                                    "JOIN events e ON r.event_id = e.id " +
                                    "ORDER BY r.registered_at DESC LIMIT 5";
                            ResultSet rs = st.executeQuery(query);
                            while(rs.next()) {
                        %>
                        <tr>
                            <td><%= rs.getString("user_name") %></td>
                            <td><%= rs.getString("event_name") %></td>
                            <td><%= rs.getString("event_date") %></td>
                            <td><span class="badge bg-success">Registered</span></td>
                        </tr>
                        <%
                            }
                            rs.close();
                            st.close();
                            con.close();
                        } catch(Exception ex) { ex.printStackTrace(); }
                        %>
                    </tbody>
                </table>
            </div>

        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
