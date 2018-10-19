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
			String serve = request.getParameter("re");
			
			switch (serve) {
			case "청소년": case "추리": case "에세이": case "기타":%> 
				<div id="aside_left">
				<jsp:include page="aside_소설.jsp"/>
				</div><% break;
				
			case "건강": case "스포츠": case "패션": case "반려동물": %> 
			<div id="aside_left">
			<jsp:include page="aside_취미.jsp"/>
			</div><% break;
			case "교양": case "순정": case "학원": case "성인": %>
			<div id="aside_left">
			<jsp:include page="aside_만화.jsp"/>
			</div><% break;
			case "초/중/고": case "자격증": case "외국어": case "취업": %>
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

				if (serve.equals("성인")) {
					PreparedStatement pstmt = null;
					pstmt = con.prepareStatement("select year(birth) from member where user_id=?");
					pstmt.setString(1, userID);
					ResultSet rs = pstmt.executeQuery();

					Calendar calendar = Calendar.getInstance();
					int y = calendar.get(Calendar.YEAR);
					while (rs.next()) {
						if ((y - rs.getInt(1)) + 1 < 20) {
							out.println("<script>");
							out.println("alert('성인만 열람 가능합니다.');");
							out.println("location.href='index.jsp';");
							out.println("</script>");
						}
					}
				}
				PreparedStatement pstmt = null;
				pstmt = con.prepareStatement("select * from product where serve=?");
				pstmt.setString(1, serve);
				ResultSet rs = pstmt.executeQuery();

				int cols = 1;
		%>
		<table align="center">
			<%
				while (rs.next()) {
						if (cols % 4 == 1) {
			%>
			<tr>
				<%
					}
				%>
				<td width="200px" align="center">
					<div>
						<a href="shop.jsp?re=<%=rs.getString("id")%>"> <img
							src="book_img/<%=rs.getString("filename")%>" width="100px"
							height="150px">
						</a>
					</div>
					<div id="title">
						<a href="shop.jsp?re=<%=rs.getString("id")%>"> <%=rs.getString("title")%>
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
			<%
				}
						cols++;
					} // end of while
			%>
		</table>
		<%
				rs.close();
				pstmt.close();
				con.close();
			} // end of try
			catch (Exception e) {
				out.println("DB 연동 실패 " + e.getMessage());
			}
		%>
	</center>
</body>
</html>