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
    <title>View Users</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>

<jsp:include page="navbar.jsp" />

<div style="display: flex;">
    <!-- Sidebar -->
    <jsp:include page="admin_sidebar.jsp" />

    <!-- Main Content -->
    <div class="container-fluid p-4" style="flex-grow: 1;">
        <h2 class="mb-4">Registered Users</h2>

        <table class="table table-bordered table-striped">
            <thead class="table-dark">
                <tr>
                    <th>User ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Registered Date</th>
                </tr>
            </thead>
            <tbody>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Event", "root", "root");

                    String query = "SELECT id, name, email, phone, created_at FROM users";
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery(query);

                    while (rs.next()) {
            %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("email") %></td>
                    <td><%= rs.getString("phone") %></td>
                    <td><%= rs.getDate("created_at") %></td>
                </tr>
            <%
                    }
                    rs.close();
                    stmt.close();
                    con.close();
                } catch (Exception e) {
                    out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
