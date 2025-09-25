package com.example;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

@WebServlet("/DeleteEventServlet")
public class DeleteEventServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int eventId = Integer.parseInt(request.getParameter("id"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/Event", "root", "root");

            String deleteQuery = "DELETE FROM events WHERE id=?";
            PreparedStatement ps = con.prepareStatement(deleteQuery);
            ps.setInt(1, eventId);
            ps.executeUpdate();

            ps.close();
            con.close();

            response.sendRedirect("manage_event.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
