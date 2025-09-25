<%@ page import="java.sql.*" %>
<%
    String name = (String) session.getAttribute("name");
    if (name == null) {
        response.sendRedirect("admin_login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin - View Registrations</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<jsp:include page="navbar.jsp" />

<!-- Sidebar -->
    <div style="display: flex;">
    <jsp:include page="admin_sidebar.jsp" />
    
<div class="container mt-4" style=margin-left:240px>
    <h2 class="text-center mb-4">All Event Registrations</h2>

    <div class="table-responsive">
        <table class="table table-bordered table-hover shadow">
            <thead class="table-dark">
                <tr>
                    <th>Reg Id</th>
                    <th>User Name</th>
                    <th>Email</th>
                    <th>Event Name</th>
                    <th>Registered At</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int counter = 1;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Event", "root", "root");
                        
                        String query = "SELECT r.id, r.name, r.email, e.name AS event_name, " +
                                "DATE_FORMAT(r.registered_at, '%d-%m-%Y %r') AS registered_at " +
                                "FROM registrations r " +
                                "JOIN events e ON r.event_id = e.id " +
                                "ORDER BY r.registered_at DESC";
                        Statement st = con.createStatement();
                        ResultSet rs = st.executeQuery(query);
                       
                       
                        while (rs.next()) {
                %>
                    <tr>
                        <td><%= counter++ %></td>
                        <td><%= rs.getString("name") %></td>
                        <td><%= rs.getString("email") %></td>
                        <td><%= rs.getString("event_name") %></td>
                        <td><%= rs.getString("registered_at") %></td>
                    </tr>
                <%
                        }
                        rs.close();
                        st.close();
                        con.close();
                    } catch (Exception e) {
                %>
                    <tr>
                        <td colspan="5" class="text-danger">Error: <%= e.getMessage() %></td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
