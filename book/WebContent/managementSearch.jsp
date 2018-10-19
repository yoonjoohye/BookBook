<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/managementSearch.css">
<title>BOOKBOOK</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");

		String kind = request.getParameter("kind");
		switch (kind) {
		case "이름":
			kind = "name";
			break;
		case "생일":
			kind = "birth";
			break;
		case "이메일":
			kind = "email";
			break;
		case "주소":
			kind = "address";
			break;
		case "가입일":
			kind = "joindate";
			break;
		case "아이디":
			kind = "user_id";
			break;
		}
		String content = request.getParameter("content");

		try {
			// 드라이버 로딩
			String dbURL = "jdbc:mysql://localhost:3306/book?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";
			String dbID = "root";
			String dbPW = "1234";

			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection con = DriverManager.getConnection(dbURL, dbID, dbPW);
			PreparedStatement pstmt=null;
			
			if (kind.equals("no")) {
				pstmt=con.prepareStatement("SELECT * FROM member");
				//rs = stmt.executeQuery("SELECT * FROM member");
			} else {
				pstmt=con.prepareStatement("SELECT * FROM member WHERE ? LIKE '%?%'");
				pstmt.setString(1, kind);
				pstmt.setString(2, content);
				//rs = stmt.executeQuery("SELECT * FROM member WHERE " + kind + " LIKE '%" + content + "%'");
			}
			ResultSet rs = pstmt.executeQuery();
			
	%>

	<form action="managementAction.jsp">
		<table cellspacing=0 id="table">
			<tr id="header">
				<th><input type="checkbox">
				<th> 이름
				<th> 아이디
				<th> 생일
				<th> 이메일
				<th> 주소
				<th> 가입일
			</tr>
		<%
			while (rs.next()) {
			%>
				<tr>
					<td><input type="checkbox" name = "check" value="<%=rs.getString("user_id")%>">
					<td> <%=rs.getString("name")%>
					<td> <%=rs.getString("user_id")%>
					<td> <%=rs.getString("birth")%>
					<td> <%=rs.getString("email")%>
					<td> <%=rs.getString("address")%>
					<td> <%=rs.getString("joindate")%>
					</td>
				</tr>
			<%
			} // end of while
		%>
		</table>
		<input type="submit" value="삭제">
	</form>
	<%
		pstmt.executeUpdate();
			rs.close();
			pstmt.close();
			con.close();
		} // end of try
		catch (Exception e) {
			System.out.println("DB 연동 실패 " + e.getMessage());
		}
	%>
</body>
</html>