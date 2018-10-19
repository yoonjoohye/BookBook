<%@page import="java.util.Random"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BOOKBOOK</title>
<link rel="stylesheet" href="css/todaysbook.css">
</head>
<body>
	<%
	int n=0;
	int rCnt=0;
	
	try {
		//드라이버 로딩
		String dbURL = "jdbc:mysql://localhost:3306/book?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8&useSSL=false";
		String dbID = "root";
		String dbPW="1234";
		
		int cost=0;
		String main = null;
		String serve = null;
		String title = null;
		String author = null;
		String publisher = null;
		String content = null;
		String filename = null;
	
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection con = DriverManager.getConnection(dbURL, dbID, dbPW);
		
		PreparedStatement pstmt=null;   	
	   	pstmt = con.prepareStatement("SELECT id FROM productNum");
	   
	   	ResultSet rs = pstmt.executeQuery(); 
		while(rs.next()){
	    	rCnt = rs.getInt("id");
         }
	%>
		
	<%
		Random rand = new Random();
		if (rCnt!=0) {
			n = rand.nextInt(rCnt);
			n+=1;
		
	%>
	
	<%
			// 오늘의 책 가져오기
			try {
				pstmt = con.prepareStatement("SELECT * FROM product WHERE id=?");
				pstmt.setInt(1,n);
				
				rs = pstmt.executeQuery(); 
				while(rs.next()){
					main = rs.getString("main");
					serve = rs.getString("serve");
					title = rs.getString("title");
					author = rs.getString("author");
					publisher = rs.getString("publisher");
					content = rs.getString("content");
					filename = rs.getString("filename");
					cost = rs.getInt("cost");
		          }
			}catch (Exception e) {
				out.println("책 정보 가져오기 실패");
				out.println(e.getMessage());
			}
		}
		else {
			main = "main";
			serve = "sub";
			title = "책의 제목이 들어올 공간입니다.";
			author = "지은이";
			publisher = "출판사";
			content = "책의 내용이 처음부터 100번째 글자까지 짤린 채 들어올 공간입니다.";
			content += "책의 내용이 처음부터 100번째 글자까지 짤린 채 들어올 공간입니다.";
			content += "책의 내용이 처음부터 100번째 글자까지 짤린 채 들어올 공간입니다."; 
			filename = "main";
			cost = 0;
		}
	%>
	<table>
		<tr>
			<td colspan=2><%=main %> > <%=serve %></td>
		</tr>
		<tr>
			<td>
				<a href="shop.jsp?re=<%=n%>">
					<img src="book_img/<%=filename%>" width="271px" height="400px">
				</a>
			</td>
			<td>
				<div id="content">
					<a href="shop.jsp?re=<%=n%>">
						<h1><%=title %></h1>
					</a>
				</div>
				<div id="content">
					<%=author %> <small>저</small> | 
					<%=publisher %> | 
					<%=cost %><small>원</small>
				</div>
				<div id="content">
					<a href="shop.jsp?re=<%=n%>">
						<%=content.substring(0,100) %>...
					</a>
				</div>
			</td>
		</tr>
	</table>
	<%
	rs.close();
   	pstmt.close();
   	con.close();
	} 
	catch (Exception e) { 
		out.println("<script>");
		out.println("history.back()");
		out.println("</script>");
	    System.out.println("DB 연동 실패 " + e.getMessage());
	} %>
</body>
</html>