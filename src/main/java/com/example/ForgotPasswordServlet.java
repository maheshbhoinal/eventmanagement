package com.example;

import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        try {
            // 1️⃣ Connect DB
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/Event", "root", "root");

            // 2️⃣ Check email exists
            PreparedStatement pst = conn.prepareStatement("SELECT * FROM users WHERE email=?");
            pst.setString(1, email);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                // 3️⃣ Generate unique token
                String token = UUID.randomUUID().toString();

                // 4️⃣ Save token in DB
                PreparedStatement pst2 = conn.prepareStatement(
                        "UPDATE users SET reset_token=? WHERE email=?");
                pst2.setString(1, token);
                pst2.setString(2, email);
                pst2.executeUpdate();

                // 5️⃣ Reset link
                String resetLink = "https://eventmanagement-1-161f.onrender.com/ResetPassword.jsp?token=" + token;

                // 6️⃣ Send email (HTML)
                final String senderEmail = "maheshbhoinal@gmail.com"; // your Gmail
                final String senderPassword = "hyth hgvp djch zixu";     // Gmail app password

                Properties props = new Properties();
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.starttls.enable", "true");
                props.put("mail.smtp.host", "smtp.gmail.com");
                props.put("mail.smtp.port", "587");

                Session mailSession = Session.getInstance(props, new Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(senderEmail, senderPassword);
                    }
                });

                Message message = new MimeMessage(mailSession);
                message.setFrom(new InternetAddress(senderEmail, "Your Project"));
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
                message.setSubject("Password Reset Request");

                String htmlContent = "<h2>Password Reset</h2>"
                        + "<p>Hello,</p>"
                        + "<p>Click the button below to reset your password:</p>"
                        + "<a href='" + resetLink + "' style='background:#4CAF50;color:white;"
                        + "padding:10px 20px;text-decoration:none;border-radius:5px;'>Reset Password</a>"
                        + "<p>If you didn’t request this, ignore this email.</p>";

                message.setContent(htmlContent, "text/html; charset=utf-8");
                
                Transport.send(message);

                request.setAttribute("message", "Check your email for password reset link!");
            } else {
                request.setAttribute("message", "Email not registered!");
            }

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error occurred while sending email.");
        }

        request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
    }
}
