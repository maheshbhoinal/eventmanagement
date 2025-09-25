<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
String name = (String) session.getAttribute("name");
String email = (String) session.getAttribute("email"); // get email from session
if (name == null || email == null) {
	response.sendRedirect("admin_login.jsp");
	return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Register Event</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="event.css">
</head>
<body class="bg-light" style=background:unset>

<jsp:include page="navbar.jsp" />

	<div class="container mt-5">
		<div class="row justify-content-center">
			<div class="col-md-5">
				<div class="card shadow-lg">
					<div class="card-header bg-primary text-white">
						<h4 class="mb-0">Register for Event</h4>
					</div>
					<div class="card-body">
						<form action="RegisterEventServlet" method="post">
							<!-- User Name -->
							<div class="mb-3">
								<label class="form-label">Your Name</label> <input type="text"
									class="form-control" name="username" value="<%=name%>" readonly>
							</div>

							<!-- Email -->
							<div class="mb-3">
								<label class="form-label">Your Email</label> <input type="email"
									class="form-control" name="email" value="<%=email%>" readonly>
							</div>

							<!-- Select Event -->
							<div class="mb-3">
								<label class="form-label">Select Event</label> <select
									class="form-select" name="eventId" required>
									<%
									try {
										Class.forName("com.mysql.cj.jdbc.Driver");
										Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Event", "root", "root");
										Statement st = con.createStatement();
										ResultSet rs = st.executeQuery("SELECT id, name FROM events");

										while (rs.next()) {
									%>
									<option value="<%=rs.getInt("id")%>"><%=rs.getString("name")%></option>
									<%
									}
									rs.close();
									st.close();
									con.close();
									} catch (Exception e) {
									out.print("<option disabled>Error loading events</option>");
									}
									%>
								</select>
							</div>

							<!-- Submit -->
						
							<button type="submit" class="btn btn-primary w-100">Register</button>
						    
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
