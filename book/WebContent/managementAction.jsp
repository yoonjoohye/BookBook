<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BOOKBOOK</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

String check[]=request.getParameterValues("check");
try{
	String DB_URL = "jdbc:mysql://localhost:3306/book?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";
	String DB_USER = "root";
	String DB_PASSWORD= "1234";
	 
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
	
	PreparedStatement pstmt=null;
	pstmt = con.prepareStatement("delete from member where user_id=?");
	for(int i=0; i<check.length; i++){
	pstmt.setString(1,check[i]);
	pstmt.executeUpdate();
	}
	
	pstmt.close();
	con.close();
	
	
	out.println("<script>");
    out.println("location.href='managementSearch.jsp?kind=no&content=no'");
	out.println("alert('삭제가 완료되었습니다!');");
	out.println("</script>");      
}
catch(Exception e){
	
}
%>
</body>
</html>