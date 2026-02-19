package com.example;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

@WebServlet("/DeleteFeedbackServlet")
public class DeleteFeedbackServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String URL = "jdbc:mysql://mysql-15e14a5-maheshbhoinal-4c5b.j.aivencloud.com:19200/defaultdb?ssl-mode=REQUIRED";
	    	String USERNAME = "avnadmin";
	    	String PASSWORD = "AVNS_hyfbdDL-q3L0YCM0n3N";
	    	
            Connection con = DriverManager.getConnection(URL,USERNAME,PASSWORD);

            PreparedStatement ps = con.prepareStatement("DELETE FROM feedback WHERE id = ?");
            ps.setInt(1, id);
            ps.executeUpdate();

            ps.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // redirect back to feedback page
        response.sendRedirect("admin_feedback.jsp");
    }
}
