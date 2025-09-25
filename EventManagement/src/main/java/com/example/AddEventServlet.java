package com.example;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/AddEventServlet")
@MultipartConfig
public class AddEventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String eventName = request.getParameter("event_name");
        String description = request.getParameter("description");
        String location = request.getParameter("location");
        String eventDate = request.getParameter("event_date");
        String eventTime = request.getParameter("event_time");
        String category = request.getParameter("category");

        // Handle file upload
        Part filePart = request.getPart("event_image");
        String fileName = null;

        if (filePart != null && filePart.getSize() > 0) {
            fileName = filePart.getSubmittedFileName(); // ✅ Only filename

            // Path where file will be saved
            String uploadPath = getServletContext().getRealPath("") + File.separator + "Uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            // Save file to Uploads folder
            File file = new File(uploadPath, fileName);
            try (InputStream inputStream = filePart.getInputStream()) {
                Files.copy(inputStream, file.toPath());
            }
        }

        // Save event details into DB
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/Event", "root", "root");

            String sql = "INSERT INTO events(name, description, location, event_date, event_time, category, image) "
                       + "VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, eventName);
            ps.setString(2, description);
            ps.setString(3, location);
            ps.setString(4, eventDate);
            ps.setString(5, eventTime);
            ps.setString(6, category);
            ps.setString(7, fileName); // ✅ only store filename

            ps.executeUpdate();
            ps.close();
            con.close();

            response.sendRedirect("admin_home.jsp?msg=success");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("add_event.jsp?msg=error");
        }
    }
}
