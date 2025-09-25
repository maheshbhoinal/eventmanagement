<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>Admin - View Feedback</title>
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
        <h2 class="text-center mb-4">User Feedback</h2>

        <div class="table-responsive">
            <table class="table table-bordered table-hover shadow">
                <thead class="table-dark">
                    <tr>
                        <th>#</th>
                        <th>User Name</th>
                        <th>Email</th>
                        <th>Rating</th>
                        <th>Comments</th>
                        <th>Submitted At</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Event", "root", "root");
                            Statement st = con.createStatement();
                            ResultSet rs = st.executeQuery("SELECT * FROM feedback ORDER BY submitted_at DESC");

                            int count = 1;
                            while (rs.next()) {
                                int feedbackId = rs.getInt("id"); // keep id internally for deletion
                    %>
                        <tr>
                            <td><%= count++ %></td>
                            <td><%= rs.getString("name") %></td>
                            <td><%= rs.getString("email") %></td>
                            <td>
                                <%
                                    int rating = rs.getInt("rating");
                                    for (int i = 0; i < rating; i++) {
                                        out.print("⭐");
                                    }
                                %>
                            </td>
                            <td><%= rs.getString("comments") %></td>
                            <td><%= rs.getTimestamp("submitted_at") %></td>
                            <td>
                                <form action="DeleteFeedbackServlet" method="post" style="display:inline;">
                                    <input type="hidden" name="id" value="<%= feedbackId %>">
                                    <button type="submit" class="btn btn-danger btn-sm"
                                        onclick="return confirm('Are you sure you want to delete this feedback?');">
                                        Delete
                                    </button>
                                </form>
                            </td>
                        </tr>
                    <%
                            }
                            rs.close();
                            st.close();
                            con.close();
                        } catch (Exception e) {
                    %>
                        <tr>
                            <td colspan="7" class="text-danger">Error: <%= e.getMessage() %></td>
                        </tr>
                    <%
                        }
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
