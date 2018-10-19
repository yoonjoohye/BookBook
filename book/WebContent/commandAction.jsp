<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String command=request.getParameter("command");
	String re=request.getParameter("re");
	try{
		String DB_URL = "jdbc:mysql://localhost:3306/book?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";
		String DB_USER = "root";
		String DB_PASSWORD= "1234";
		
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
		
		PreparedStatement pstmt=null;
		pstmt = con.prepareStatement("update question set command=? where id=?");
	   	pstmt.setString(1,command);
	   	pstmt.setString(2,re);
	 
	   	pstmt.executeUpdate();
	   	
	   	pstmt.close();
	   	con.close();
	   	
	   	response.sendRedirect("answer.jsp"); 
	}catch(Exception e){
		response.sendRedirect("answer.jsp"); 
	}
%>