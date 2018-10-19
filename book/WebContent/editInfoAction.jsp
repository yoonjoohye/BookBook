<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String userID=null;
if(session.getAttribute("userID")!=null){
	userID=(String)session.getAttribute("userID");
}
if(userID==null){
	
	out.println("<script>");
	out.println("alert('로그인이 필요합니다.');");
	out.println("location.href='login.jsp';");
	out.println("</script>");
}
%>
<%
request.setCharacterEncoding("utf-8");

String pw=request.getParameter("edit_pw");
String name=request.getParameter("edit_name");
String email=request.getParameter("edit_email");
String address=request.getParameter("edit_address");

System.out.println(pw);
System.out.println(name);
System.out.println(email);
System.out.println(address);

try{
	String DB_URL = "jdbc:mysql://localhost:3306/book?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8&autoReconnect=true&useSSL=false";
	String DB_USER = "root";
	String DB_PASSWORD= "1234";
	
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
	
	String query = "update member set user_pw=?, name=?,email=?,address=? where user_id=?";
	PreparedStatement pstmt = conn.prepareStatement(query);
	pstmt.setString(1, pw);
	pstmt.setString(2, name);
	pstmt.setString(3, email);
	pstmt.setString(4, address);
	pstmt.setString(5, userID);
	
	pstmt.executeUpdate();
	
	pstmt.close();
	conn.close();
	response.sendRedirect("index.jsp");      
}
catch(Exception e){
	response.sendRedirect("mypage.jsp");      
}
%>