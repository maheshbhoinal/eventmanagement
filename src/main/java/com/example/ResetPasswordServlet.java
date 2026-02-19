package com.example;


import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String token = request.getParameter("token");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("message", "Passwords do not match!");
            request.getRequestDispatcher("ResetPassword.jsp?token=" + token).forward(request, response);
            return;
        }

        try {
            // 1️⃣ Connect DB
            Class.forName("com.mysql.cj.jdbc.Driver");
            String URL = "jdbc:mysql://mysql-15e14a5-maheshbhoinal-4c5b.j.aivencloud.com:19200/defaultdb?ssl-mode=REQUIRED";
	    	String USERNAME = "avnadmin";
	    	String PASSWORD = "AVNS_hyfbdDL-q3L0YCM0n3N";
	    	
            Connection conn = DriverManager.getConnection(URL,USERNAME,PASSWORD);


            // 2️⃣ Update password where token matches
            PreparedStatement pst = conn.prepareStatement(
                    "UPDATE users SET password=?, reset_token=NULL WHERE reset_token=?");
            pst.setString(1, newPassword);
            pst.setString(2, token);

            int row = pst.executeUpdate();

            if (row > 0) {
                request.setAttribute("message", "Password reset successful! Login now.");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            } else {
                request.setAttribute("message", "Invalid or expired reset link!");
                request.getRequestDispatcher("ResetPassword.jsp?token=" + token).forward(request, response);
            }

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error occurred while resetting password.");
            request.getRequestDispatcher("ResetPassword.jsp?token=" + token).forward(request, response);
        }
    }
}
