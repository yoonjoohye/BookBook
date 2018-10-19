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
	request.setCharacterEncoding("UTF-8");

	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	try{
		String DB_URL = "jdbc:mysql://localhost:3306/book?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";
		String DB_USER = "root";
		String DB_PASSWORD= "1234";
		 
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
		
		PreparedStatement pstmt=null;   	
		pstmt=con.prepareStatement("SELECT * FROM member WHERE name=? AND email=?");
		pstmt.setString(1, name);
		pstmt.setString(2, email);
		
		ResultSet rs = pstmt.executeQuery();
		
		String id = null;
		String dbName = null;
		boolean check = false;
		while(rs.next()) {
			id = rs.getString("user_id");
			dbName = rs.getString("name");
			
			if (name.equals(dbName)) {
				check = true;
			}
			else {
				check = false;
			}
		}
		rs.close();
		pstmt.close();
		con.close();
		
		if (check) {
			out.println("<script>");
	    	out.println("location.href='findForm.jsp';");
			out.println("alert('고객님의 아이디는 " + id + " 입니다.');");
			out.println("</script>");
		}
		else {
			out.println("<script>");
	    	out.println("location.href='findForm.jsp';");
			out.println("alert('이름이나 이메일이 틀렸습니다. 다시 입력해주세요');");
			out.println("</script>");
		}
		
	} catch (Exception e) {
		out.println(e.getMessage());
	}
	 
%>
</body>
</html>