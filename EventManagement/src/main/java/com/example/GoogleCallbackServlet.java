package com.example;

import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleTokenResponse;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.client.auth.oauth2.TokenResponse;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collections;

@WebServlet("/GoogleCallbackServlet")
public class GoogleCallbackServlet extends HttpServlet {

    private static final String CLIENT_ID = "133711225652-pqaog52ev73tantrkq5qbhmsdv85lhj2.apps.googleusercontent.com";
    private static final String CLIENT_SECRET = "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";
    private static final String REDIRECT_URI = "http://localhost:8082/EventManagement/GoogleCallbackServlet";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");

        if (code == null || code.isEmpty()) {
            response.sendRedirect("Login.jsp?error=auth_failed");
            return;
        }

        try {
            GoogleAuthorizationCodeFlow flow = new GoogleAuthorizationCodeFlow.Builder(
                    new NetHttpTransport(),
                    GsonFactory.getDefaultInstance(),
                    CLIENT_ID,
                    CLIENT_SECRET,
                    Collections.singletonList("email profile")
            ).setAccessType("online").setApprovalPrompt("auto").build();

            TokenResponse tokenResponse = flow.newTokenRequest(code)
                    .setRedirectUri(REDIRECT_URI)
                    .execute();
            
            GoogleIdToken idToken = ((GoogleTokenResponse) tokenResponse).parseIdToken();
            if (idToken != null) {
                GoogleIdToken.Payload payload = idToken.getPayload();
                String name = (String) payload.get("name");
                String email = payload.getEmail();

                // Start of Database operations
                try {
                    try {
						Class.forName("com.mysql.cj.jdbc.Driver");
					} catch (ClassNotFoundException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
                    Connection con = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/Event", "root", "root");

                    PreparedStatement selectPs = con.prepareStatement("SELECT * FROM users WHERE email=?");
                    selectPs.setString(1, email);
                    ResultSet rs = selectPs.executeQuery();

                    if (!rs.next()) {
                        PreparedStatement insertPs = con.prepareStatement(
                            "INSERT INTO users (name, email,password, provider,age) VALUES (?,?,?,?,?)");
                        insertPs.setString(1, name);
                        insertPs.setString(2, email);
                        insertPs.setString(3, null); // Set a null value for password
                        insertPs.setString(4, "google");
                        insertPs.setString(5, null);
                        insertPs.executeUpdate();
                        insertPs.close();
                    }
                    rs.close();
                    selectPs.close();
                    con.close();

                } catch (SQLException dbException) {
                    System.err.println("Database error during Google login: " + dbException.getMessage());
                    dbException.printStackTrace();
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error during authentication.");
                    return; // Prevent further execution
                }
                // End of Database operations

                // Store in session
                HttpSession session = request.getSession();
                session.setAttribute("name", name);
                session.setAttribute("email", email);
                session.setAttribute("role", "user");

                // Redirect to homepage
                response.sendRedirect("index.jsp");

            } else {
                System.err.println("Invalid ID token received.");
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID token received.");
            }

        } catch (IOException | IllegalArgumentException e) {
            System.err.println("Authentication failed due to: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An internal server error occurred during authentication.");
        }
    }
}