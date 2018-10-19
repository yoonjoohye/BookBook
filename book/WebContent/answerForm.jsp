<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/answer.css">
<title>BOOKBOOK</title>
</head>
<body>
	<table cellspacing=0 align="center">
		<tr>
			<th>번호</th>
			<th>회원아이디</th>
			<th>건의사항</th>
			<th>날짜</th>
		</tr>
		<%
			String userID = null;
			if (session.getAttribute("userID") != null) {
				userID = (String) session.getAttribute("userID");
			}
			if (userID == null) {
				out.println("<script>");
				out.println("alert('로그인이 필요합니다.');");
				out.println("location.href='login.jsp';");
				out.println("</script>");
			}

			try {
				String DB_URL = "jdbc:mysql://localhost:3306/book?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";
				String DB_USER = "root";
				String DB_PASSWORD = "1234";

				Class.forName("com.mysql.jdbc.Driver").newInstance();
				Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
				PreparedStatement pstmt = null;
				pstmt = con.prepareStatement("select * from question");
				ResultSet rs = pstmt.executeQuery();
				while (rs.next()) {
		%>
		<tr>
			<td><a href="command.jsp?re=<%=rs.getString("id")%>"><%=rs.getString("id")%></a></td>
			<td><%=rs.getString("user_id")%></td>
			<td><a href="command.jsp?re=<%=rs.getString("id")%>"><%=rs.getString("title")%></a></td>
			<td><%=rs.getString("date")%></td>
		</tr>
		<%
			}
				rs.close();
				pstmt.close();
				con.close();

				response.sendRedirect("answer.jsp");
				System.out.println("연동 성공!");
			} catch (Exception e) {
				response.sendRedirect("answer.jsp");
			}
		%>
	</table>
</body>
</html>