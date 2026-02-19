package com.example;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

@WebServlet("/RegisterEventServlet")
public class RegisterEventServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String eventId = request.getParameter("eventId");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            String URL = "jdbc:mysql://mysql-15e14a5-maheshbhoinal-4c5b.j.aivencloud.com:19200/defaultdb?ssl-mode=REQUIRED";
	    	String USERNAME = "avnadmin";
	    	String PASSWORD = "AVNS_hyfbdDL-q3L0YCM0n3N";
	    	
            Connection con = DriverManager.getConnection(URL,USERNAME,PASSWORD);

            PreparedStatement ps = con.prepareStatement("INSERT INTO registrations (event_id, name, email) VALUES (?, ?, ?)");
            ps.setInt(1, Integer.parseInt(eventId));
            ps.setString(2, username);
            ps.setString(3, email);

            int rows = ps.executeUpdate();
            ps.close();
            con.close();

            if (rows > 0) {
                response.sendRedirect("thanks.jsp");
            } else {
                response.getWriter().println("Failed to register.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
