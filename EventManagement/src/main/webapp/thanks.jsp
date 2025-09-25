<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Thank You</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="event.css">
</head>
<body class="bg-light" style="background:unset;">
  <!-- Include Navbar -->
  <jsp:include page="navbar.jsp" />
  
  <div class="container mt-5 text-center">
      <div class="alert alert-success shadow-lg">
          <h4>🙏 Thank you for registering</h4>
          <p>🎉 We’ve received your event registration successfully.</p>
          <a href="index.jsp" class="btn btn-primary mt-3">🏠 Back to Home</a>
      </div>
  </div>
</body>
</html>
