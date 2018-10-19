<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/question.css">
<title>Insert title here</title>
</head>
<body>
<%
String userID=null;
if(session.getAttribute("userID")!=null){
	userID=(String)session.getAttribute("userID");
}
if(userID==null){
	out.println("<script>");
	out.println("alert('로그인이 필요합니다.');");
	out.println("location.href='loginForm.jsp';");
	out.println("</script>");
}
request.setCharacterEncoding("utf-8");
%>
<center>
<table cellspacing=0>
<tr>
	<th>번호</th>
	<th>문의사항</th>
	<th>날짜</th>
</tr>
<%
	int cnt=1;
	try{
		String DB_URL = "jdbc:mysql://localhost:3306/book?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";
		String DB_USER = "root";
		String DB_PASSWORD= "1234";
		
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
		
		PreparedStatement pstmt=null;
		pstmt=con.prepareStatement("select * from question where user_id=?");
		pstmt.setString(1,userID);
		
		ResultSet rs = pstmt.executeQuery();
	   	while(rs.next()){%>
	   		<tr>
	   			<td><%=cnt++%></td>
	   			<td><a href="command.jsp?re=<%=rs.getString("id") %>"><%=rs.getString("title") %></a></td>
	   			<td><%=rs.getString("date") %></td>
	   		</tr>
	 <% }
		pstmt.executeUpdate();
	   	
	   	rs.close();
	   	pstmt.close();
	   	con.close();
	   	
	   	response.sendRedirect("question.jsp");   
	   	System.out.println("연동 성공!");
	}
	catch(Exception e){
		response.sendRedirect("question.jsp"); 
	}
%>
</table><br>
<a href="board.jsp"><input type="button" value="게시하기"></a>
</center>
</body>
</html>