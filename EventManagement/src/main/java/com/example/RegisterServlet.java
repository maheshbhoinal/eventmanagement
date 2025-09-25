package com.example;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String name=request.getParameter("name");
		String email=request.getParameter("email");
		String password=request.getParameter("password");
	    int age=Integer.parseInt(request.getParameter("age"));
	    
	    try {
	    	Class.forName("com.mysql.cj.jdbc.Driver");
	    
	    	    String URL = "jdbc:mysql://localhost:3306/Event";
	    	     String USERNAME = "root";
	    	    String PASSWORD = "root";
	    	Connection con=DriverManager.getConnection(URL,USERNAME,PASSWORD);
	    	
	    	PreparedStatement psmt=con.prepareStatement("insert into users(name, email, password, age,provider) values(?,?,?,?,?)");
	    	psmt.setString(1, name);
	    	psmt.setString(2, email);
	    	psmt.setString(3, password);
	    	psmt.setInt(4, age);
	    	psmt.setString(5, "manually");
	    	
           int row= psmt.executeUpdate();
	    	if(row>0) {
	    	PrintWriter out=response.getWriter();
	    	response.setContentType("text/html");
	    	
            request.setAttribute("msg", "User Registered Successfully");
           
	    	RequestDispatcher rd=request.getRequestDispatcher("Register.jsp");          
	    	rd.forward(request, response);
	    	}
    	else {
	    		PrintWriter out=response.getWriter();
		    	response.setContentType("text/html");
		    	
	            request.setAttribute("msg1", "Multiple user Not Added");
		    	RequestDispatcher rd=request.getRequestDispatcher("Register.jsp");
		    	rd.include(request, response);
	    	}
	    	
	    }catch(Exception e) {
	    	
	    	
	    	
	    	e.printStackTrace();
	    }
	    
	}

}
