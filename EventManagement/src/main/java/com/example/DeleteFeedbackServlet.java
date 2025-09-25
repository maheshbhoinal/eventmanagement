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
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Event", "root", "root");

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
