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
	String id = request.getParameter("id");
	
	try{
		String DB_URL = "jdbc:mysql://localhost:3306/book?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";
		String DB_USER = "root";
		String DB_PASSWORD= "1234";
		 
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
		
		PreparedStatement pstmt=null;   	
		pstmt=con.prepareStatement("SELECT * FROM member WHERE name=? AND user_id=?");
		pstmt.setString(1, name);
		pstmt.setString(2, id);
		
		ResultSet rs = pstmt.executeQuery();
		
		String pw = null;
		String dbID = null;
		boolean check = false;
		while(rs.next()) {
			pw = rs.getString("user_pw");
			dbID = rs.getString("user_id");
			
			if (id.equals(dbID)) {
				check = true;
			}
			else {
				check = false;
			}
		}
		rs.close();
		pstmt.close();
		con.close();
		
		int leng = pw.length();
		pw = pw.substring(0, 3);
		for (int i=3; i<leng; i++) {
			pw += "*";
		}
		
		if (check) {
			out.println("<script>");
	    	out.println("location.href='findForm.jsp';");
			out.println("alert('고객님의 비밀번호는 " + pw + " 입니다.');");
			out.println("</script>");
		}
		else {
			out.println("<script>");
	    	out.println("location.href='findForm.jsp';");
			out.println("alert('이름이나 아이디가 틀렸습니다. 다시 입력해주세요');");
			out.println("</script>");
		}
		
	} catch (Exception e) {
		out.println(e.getMessage());
	}
	 
%>
</body>
</html>