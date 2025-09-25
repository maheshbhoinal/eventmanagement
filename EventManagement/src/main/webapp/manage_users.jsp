<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String adminName = (String) session.getAttribute("name");
    if(adminName == null){
        response.sendRedirect("admin_login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Users</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body style=margin-left:230px>
<!-- Navbar (optional include) -->
    <jsp:include page="navbar.jsp" />
    
    <!-- Sidebar -->
    <div style="display: flex;">
    <jsp:include page="admin_sidebar.jsp" />
<div class="container mt-5">
    <h3>Manage Users</h3>
    <table class="table table-striped table-hover mt-3">
        <thead class="table-dark">
            <tr>
                <th>#</th>
                <th>Name</th>
                <th>Email</th>
                <th>Age</th>
                <th>Role</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Event", "root", "root");
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("SELECT * FROM users");

                int count = 1; // counter for serial number
                while(rs.next()){
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    int age = rs.getInt("age");
                    String role = rs.getString("role");
        %>
            <tr>
                <td><%= count %></td>
                <td><%= name %></td>
                <td><%= email %></td>
                <td><%= age %></td>
                <td>
                    <% if(role.equals("admin")) { %>
                        Admin
                    <% } else { %>
                        User
                    <% } %>
                </td>
                <td>
                    <a href="DeleteUserServlet?id=<%= rs.getInt("id") %>" class="btn btn-sm btn-danger"
                       onclick="return confirm('Are you sure you want to delete this user?');">Delete</a>
                </td>
            </tr>
        <%
                    count++; // increment serial number
                }
                rs.close();
                st.close();
                con.close();
            } catch(Exception e) {
                e.printStackTrace();
            }
        %>
        </tbody>
    </table>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
