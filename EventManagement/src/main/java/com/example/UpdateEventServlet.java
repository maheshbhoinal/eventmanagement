package com.example;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

@WebServlet("/UpdateEventServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
                 maxFileSize = 1024 * 1024 * 10,       // 10MB
                 maxRequestSize = 1024 * 1024 * 50)    // 50MB
public class UpdateEventServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String location = request.getParameter("location");
        String date = request.getParameter("event_date");
        String time = request.getParameter("event_time");
        String category = request.getParameter("category");

        Part filePart = request.getPart("event_image");
        String fileName = filePart.getSubmittedFileName();

        // Save directory on server
        String uploadPath = getServletContext().getRealPath("") + "event_images";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        // Save the image file on server
        if (fileName != null && !fileName.isEmpty()) {
            filePart.write(uploadPath + File.separator + fileName);
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Event", "root", "root");

            String sql;
            PreparedStatement ps;

            if (fileName != null && !fileName.isEmpty()) {
                sql = "UPDATE events SET name=?, description=?, location=?, event_date=?, event_time=?, category=?, image=? WHERE id=?";
                ps = con.prepareStatement(sql);
                ps.setString(1, name);
                ps.setString(2, description);
                ps.setString(3, location);
                ps.setString(4, date);
                ps.setString(5, time);
                ps.setString(6, category);
                ps.setString(7, fileName); // ✅ Only store the file name
                ps.setInt(8, id);
            } else {
                sql = "UPDATE events SET name=?, description=?, location=?, event_date=?, event_time=?, category=? WHERE id=?";
                ps = con.prepareStatement(sql);
                ps.setString(1, name);
                ps.setString(2, description);
                ps.setString(3, location);
                ps.setString(4, date);
                ps.setString(5, time);
                ps.setString(6, category);
                ps.setInt(7, id);
            }

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
