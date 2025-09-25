<%@ page import="java.sql.*" %>
<%
    String name = (String) session.getAttribute("name");
    if (name == null) {
        response.sendRedirect("admin_login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Events</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body >

 <jsp:include page="navbar.jsp" />

    <!-- Sidebar -->
    <div style="display: flex;">
    <jsp:include page="admin_sidebar.jsp" />

    <!-- Main Content -->
    <div class="container-fluid p-4" style="flex-grow: 1; margin-left:240px">
        <h2 class="mb-4">Manage Events</h2>

        <table class="table table-bordered table-striped">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                   
                    <th>Venue</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Category</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Event", "root", "root");
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM events");

                    int counter = 1;
                    while (rs.next()) {
            %>
                <tr>
                <td><%= counter++ %></td>
                   
                    <td><%= rs.getString("name") %></td>
                   
                    <td><%= rs.getString("location") %></td>
                    <td><%= rs.getDate("event_date") %></td>
                    <td><%= rs.getTime("event_time") %></td>
                    <td><%= rs.getString("category") %></td>
                    <td>
                        <a href="edit_event.jsp?id=<%= rs.getInt("id") %>" class="btn btn-warning btn-sm">
                            <i class="bi bi-pencil-square"></i> Edit
                        </a>
                        <a href="DeleteEventServlet?id=<%= rs.getInt("id") %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?');">
                            <i class="bi bi-trash"></i> Delete
                        </a>
                    </td>
                </tr>
            <%
                    }
                    rs.close();
                    stmt.close();
                    con.close();
                } catch (Exception e) {
                    out.println("<tr><td colspan='8' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
                }
            %>
            </tbody>
        </table>
    </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
