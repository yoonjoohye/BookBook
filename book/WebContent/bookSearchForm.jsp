<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/bookSearch.css">
<title>BOOKBOOK</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");

		String kind = request.getParameter("kind");
		switch (kind) {
		case "제목":
			kind = "title";
			break;
		case "내용":
			kind = "content";
			break;
		case "지은이":
			kind = "author";
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
				pstmt=con.prepareStatement("select * from product");
			} 
			else {
				pstmt=con.prepareStatement("SELECT * FROM product WHERE ? LIKE '%?%'");
				pstmt.setString(1, kind);
				pstmt.setString(2, content);
				//rs = stmt.executeQuery("SELECT * FROM product WHERE " + kind + " LIKE '%" + content + "%'");
			}
			ResultSet rs=pstmt.executeQuery();
			
	%>

	<form action="bookDeleteAction.jsp">
		<%
			while (rs.next()) {
		%>
		<div id="row">
			<div id="check">
				<input type="checkbox" name="check" value="<%=rs.getString("title")%>">
			</div>
			<div id="title">
				<h3><%=rs.getString("title")%></h3>
				| <small><%=rs.getString("author")%></small>
			</div>
			<div id="content">
				<%=rs.getString("content").substring(0, 40)%>...
			</div>
		</div>
		<%
			} // end of while
		%>
		<input type="submit" value="삭제">
	</form>
	<%
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