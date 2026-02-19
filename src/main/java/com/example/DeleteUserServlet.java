package com.example;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int userId = Integer.parseInt(request.getParameter("id"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            String URL = "jdbc:mysql://mysql-15e14a5-maheshbhoinal-4c5b.j.aivencloud.com:19200/defaultdb?ssl-mode=REQUIRED";
	    	String USERNAME = "avnadmin";
	    	String PASSWORD = "AVNS_hyfbdDL-q3L0YCM0n3N";
	    	
            Connection con = DriverManager.getConnection(URL,USERNAME,PASSWORD);

            String deleteQuery = "DELETE FROM users WHERE id=?";
            PreparedStatement ps = con.prepareStatement(deleteQuery);
            ps.setInt(1, userId);
            ps.executeUpdate();

            ps.close();
            con.close();

            response.sendRedirect("manage_users.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
