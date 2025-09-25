<%@ page import="java.sql.*" %>
<%
    String name = (String) session.getAttribute("name");
    if (name == null) {
        response.sendRedirect("admin_login.jsp");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));
    String eventName = "", description = "", location = "", category = "", image = "";
    Date eventDate = null;
    Time eventTime = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Event", "root", "root");
        PreparedStatement ps = con.prepareStatement("SELECT * FROM events WHERE id = ?");
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            eventName = rs.getString("name");
            description = rs.getString("description");
            location = rs.getString("location");
            eventDate = rs.getDate("event_date");
            eventTime = rs.getTime("event_time");
            category = rs.getString("category");
            image = rs.getString("image");
        }
        rs.close();
        ps.close();
        con.close();
    } catch (Exception e) {
        out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Event</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="navbar.jsp" />

<div style="display:flex">
    <jsp:include page="admin_sidebar.jsp" />

    <div class="container p-4" style="flex-grow: 1;">
        <h2 class="mb-4">Edit Event</h2>
        <form action="UpdateEventServlet" method="post" enctype="multipart/form-data">
            <input type="hidden" name="id" value="<%= id %>" />
            <input type="hidden" name="old_image" value="<%= image %>" />

            <div class="mb-3">
                <label>Event Name:</label>
                <input type="text" class="form-control" name="name" value="<%= eventName %>" required />
            </div>

            <div class="mb-3">
                <label>Description:</label>
                <textarea class="form-control" name="description" required><%= description %></textarea>
            </div>

            <div class="mb-3">
                <label>Venue:</label>
                <input type="text" class="form-control" name="location" value="<%= location %>" required />
            </div>

            <div class="mb-3">
                <label>Date:</label>
                <input type="date" class="form-control" name="event_date" value="<%= eventDate %>" required />
            </div>

            <div class="mb-3">
                <label>Time:</label>
                <input type="time" class="form-control" name="event_time" value="<%= eventTime %>" required />
            </div>

            <div class="mb-3">
                <label>Category:</label>
                <select class="form-select" name="category" required>
                    <option value="">Select</option>
                    <option value="Cultural" <%= category.equals("Cultural") ? "selected" : "" %>>Cultural</option>
                    <option value="Technical" <%= category.equals("Technical") ? "selected" : "" %>>Technical</option>
                    <option value="Sports" <%= category.equals("Sports") ? "selected" : "" %>>Sports</option>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Current Image</label><br>
                <% if (image != null && !image.isEmpty()) { %>
                    <img src="<%= image %>" alt="Event Image" style="width: 100px; height: auto; margin-bottom: 10px;"><br>
                <% } else { %>
                    <p>No image available.</p>
                <% } %>
                <label class="form-label mt-2">Change Image</label>
                <input type="file" name="event_image" class="form-control">
            </div>

            <button type="submit" class="btn btn-success">Update Event</button>
            <a href="manage_event.jsp" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
