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
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Event", "root", "root");

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
