package com.example;

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


@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	
		String email=request.getParameter("email");
		String password=request.getParameter("password");
		
		try {
	    	Class.forName("com.mysql.cj.jdbc.Driver");
	    
	    	    String URL = "jdbc:mysql://localhost:3306/Event";
	    	     String USERNAME = "root";
	    	    String PASSWORD = "root";
	    	Connection con=DriverManager.getConnection(URL,USERNAME,PASSWORD);
	    	PreparedStatement psmt=con.prepareStatement("select * from admin where email=? and password=?");
	    	psmt.setString(1, email);
	    	psmt.setString(2, password);
	    	
//    		RequestDispatcher rd1 = request.getRequestDispatcher("/user_home.jsp");
//    		rd1.forward(request, response);

	    	
	    	ResultSet rs =psmt.executeQuery();
	    	if (rs.next()) {
	    	    HttpSession session = request.getSession();
	    	    session.setAttribute("name", rs.getString("name"));
	    	    session.setAttribute("role", "admin");
	    	    response.sendRedirect("/admin_home.jsp");
	    	} else {
	    	    HttpSession session = request.getSession();
	    	    session.setAttribute("loginError", "Admin not found");
	    	    response.sendRedirect("/admin_login.jsp");
	    	}

	    	
		}catch (Exception e) {
			// TODO: handle exception
		}
		
	}

	

}

