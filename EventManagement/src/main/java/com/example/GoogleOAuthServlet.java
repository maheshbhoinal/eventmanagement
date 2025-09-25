package com.example;

import jakarta.servlet.annotation.WebServlet; // if using Servlet 5+
import jakarta.servlet.http.*;

import java.io.IOException;

import jakarta.servlet.*;

@WebServlet("/GoogleOAuthServlet")
public class GoogleOAuthServlet extends HttpServlet {

    private static final String CLIENT_ID = "133711225652-pqaog52ev73tantrkq5qbhmsdv85lhj2.apps.googleusercontent.com";
    private static final String REDIRECT_URI = "http://localhost:8082/EventManagement/GoogleCallbackServlet";
    private static final String SCOPE = "email profile";
    private static final String RESPONSE_TYPE = "code";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String oauthUrl = "https://accounts.google.com/o/oauth2/v2/auth"
                + "?client_id=" + CLIENT_ID
                + "&redirect_uri=" + REDIRECT_URI
                + "&response_type=" + RESPONSE_TYPE
                + "&scope=" + SCOPE;

        response.sendRedirect(oauthUrl);
    }
}
