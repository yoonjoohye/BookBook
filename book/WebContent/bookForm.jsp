<%@page import="java.util.Calendar"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/booksForm.css">
<title>BOOKBOOK</title>
</head>
<body>
	<center>
		<%
			String userID = null;
			if (session.getAttribute("userID") != null) {
				userID = (String) session.getAttribute("userID");
			}
			request.setCharacterEncoding("utf-8");
			String bigkind = request.getParameter("re");
			
			switch (bigkind) {
			case "소설": %> 
				<div id="aside_left">
				<jsp:include page="aside_소설.jsp"/>
				</div><% break;
			case "취미/여행": %> 
			<div id="aside_left">
			<jsp:include page="aside_취미.jsp"/>
			</div><% break;
			case "만화": %> 
			<div id="aside_left">
			<jsp:include page="aside_만화.jsp"/>
			</div><% break;
			case "문제집": %> 
			<div id="aside_left">
			<jsp:include page="aside_문제집.jsp"/>
			</div><% break;
			}

			try {
				// 드라이버 로딩
				String dbURL = "jdbc:mysql://localhost:3306/book?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";
				String dbID = "root";
				String dbPW = "1234";

				Class.forName("com.mysql.jdbc.Driver").newInstance();
				Connection con = DriverManager.getConnection(dbURL, dbID, dbPW);

				PreparedStatement pstmt = null;
				pstmt = con.prepareStatement("select * from product where main=?");
				pstmt.setString(1, bigkind);
				ResultSet rs = pstmt.executeQuery();
		%>
		
		<table align="center">
			<%
				int cols=1;
				while (rs.next()) {
						if (cols % 4 == 1) {
			%>
			<tr>
				<%}%>
				<td width="200px" align="center">
					<div>
						<a href="shop.jsp?re=<%=rs.getInt("id")%>"> <img
							src="book_img/<%=rs.getString("filename")%>" width="100px"
							height="150px">
						</a>
					</div>
					<div id="title">
						<a href="shop.jsp?re=<%=rs.getInt("id")%>"> <%=rs.getString("title")%>
						</a>
					</div>
					<div>
						<small><%=rs.getString("author")%> | <%=rs.getString("publisher")%></small>
					</div>
					<div>
						<small><b><%=rs.getString("cost")%></b>원<small>
					</div>
				</td>
				<%
					if (cols % 4 == 0) {
				%>
			</tr>
			<%}
				cols++;
			}%>
		</table>
		<%
				rs.close();
				pstmt.close();
				con.close();

			} catch (Exception e) {
				System.out.println("DB 연동 실패 " + e.getMessage());
			}
		%>
	</center>
</body>
</html>