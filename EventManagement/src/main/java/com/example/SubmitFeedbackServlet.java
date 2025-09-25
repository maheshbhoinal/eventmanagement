package com.example;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet("/SubmitFeedbackServlet")
public class SubmitFeedbackServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String rating = request.getParameter("rating");
        String comments = request.getParameter("comments");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Event", "root", "root");

            String sql = "INSERT INTO feedback (name, email, rating, comments) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setInt(3, Integer.parseInt(rating));
            ps.setString(4, comments);

            ps.executeUpdate();
            ps.close();
            con.close();

            response.sendRedirect("thankyou.jsp"); // ✅ redirect after submission
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
