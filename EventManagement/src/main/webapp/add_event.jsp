<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <title>Add New Event</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
                padding-top: 56px; /* Same as navbar height */
            
         
        }
        .form-container {
        
            max-width: 700px;
            margin: 40px auto;
            padding: 20px;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
             margin-left: 500px; 
              margin-top: 70px;
                width: calc(100% - 500px);
       
        }
        
       
    </style>
</head>
<body>

    <!-- Navbar (optional include) -->
    <jsp:include page="navbar.jsp" />
    
    <!-- Sidebar -->
    <div style="display: flex;">
    <jsp:include page="admin_sidebar.jsp" />

    <div class="form-container" >
        <h3 class="mb-4 text-center">Add New Event</h3>

        <!-- Show success/error messages -->
        <%
            String msg = request.getParameter("msg");
            if ("success".equals(msg)) {
        %>
            <div class="alert alert-success">Event Added Successfully!</div>
        <% } else if ("error".equals(msg)) { %>
            <div class="alert alert-danger">Something went wrong. Please try again.</div>
        <% } %>

        <form action="AddEventServlet" method="post" enctype="multipart/form-data">
            
            <div class="mb-3">
                <label class="form-label">Event Name</label>
                <input type="text" name="event_name" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Description</label>
                <textarea name="description" class="form-control" rows="4" required></textarea>
            </div>

            <div class="mb-3">
                <label class="form-label">Venue</label>
                <input type="text" name="location" class="form-control" required>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Date</label>
                    <input type="date" name="event_date" class="form-control" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Time</label>
                    <input type="time" name="event_time" class="form-control" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Category</label>
                <select name="category" class="form-select" required>
                    <option value="">-- Select Category --</option>
                    <option value="Workshop">Workshop</option>
                    <option value="Seminar">Seminar</option>
                    <option value="Webinar">Webinar</option>
                    <option value="Cultural">Cultural</option>
                    <option value="Technical">Technical</option>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">Event Image</label>
                <input type="file" name="event_image" class="form-control" required>
            </div>

            <div class="text-center">
                <button type="submit" class="btn btn-primary">
                    <i class="bi bi-plus-circle"></i> Add Event
                </button>
            </div>
        </form>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
