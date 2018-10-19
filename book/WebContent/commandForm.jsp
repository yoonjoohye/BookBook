<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/command.css">
<%
String userID=null;
if(session.getAttribute("userID")!=null){
	userID=(String)session.getAttribute("userID");
}
if(userID==null){
	out.println("<script>");
	out.println("alert('로그인이 필요합니다.');");
	out.println("location.href='login.jsp';");
	out.println("</script>");
}
request.setCharacterEncoding("utf-8");
String re=request.getParameter("re");
%>
<title>BOOKBOOK</title>
</head>
<body>
<div id="all">
<div id="label">문의내역</div>
<center>
<table border>
<%
	int cnt=1;
	
	try{
		String DB_URL = "jdbc:mysql://localhost:3306/book?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";
		String DB_USER = "root";
		String DB_PASSWORD= "1234";
		
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
		
		PreparedStatement pstmt=null;
		pstmt=con.prepareStatement("select * from question where id=?");
		pstmt.setString(1,re);
		
		ResultSet rs = pstmt.executeQuery();
	   
		if(userID.equals("joosang")){
			while(rs.next()){%>
	   		<tr height=30px>
	   			<td>분류</td>
	   			<td><%=rs.getString("title")%></td>
	   		</tr>
	   		<tr height=30px>
	   			<td>날짜</td>
	   			<td><%=rs.getString("date") %></td>
	   		</tr>
	   		</table>
	   		
	   		<table id="talk1" border>
	   		<tr>
	   			<td>문의내용</td>
	   			<td><%=rs.getString("content") %></td>
	   		</tr>
	   		</table>
	   		<table id="talk3" border>
	   		<tr>
	   			<td>답변내용</td>
	   			<td>
	   			<%if(rs.getString("command")==null){%>
	   				<form id="cmdForm" method="post" action="commandAction.jsp">
	   					<textarea name="command"></textarea>
	   					<input type="hidden" name="re" value="<%=re %>">
	   					<input type="submit" value="등록" onclick="command()">
	   				</form>
	   			<%}else{
	   				out.println(rs.getString("command")); 
	   			} %>
	   			</td>
	   		</tr>
	 		<% }
		}
		else{
			while(rs.next()){%>
	   		<tr height=30px>
	   			<td>분류</td>
	   			<td><%=rs.getString("title")%></td>
	   		</tr>
	   		<tr height=30px>
	   			<td>날짜</td>
	   			<td><%=rs.getString("date") %></td>
	   		</tr>
	   		</table>
	   		
	   		<table id="talk1" border>
	   		<tr>
	   			<td>문의내용</td>
	   			<td><%=rs.getString("content") %></td>
	   		</tr>
	   		</table>
	   		
	   		<table id="talk2" border>
	   		<tr>
	   			<td>답변내용</td>
	   			<td class="a">
	   			<%if(rs.getString("command")==null){
	   				out.println("관리자님이 아직 확인하지 못했습니다.");
	   			}else{
	   				out.println(rs.getString("command")); 
	   			} %>
	   			</td>
	   		</tr>
	 		<% }
		}
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
</table><br><br>
<input type="button" value="돌아가기" onclick="go()">
</center>
</div>
<script>
	function go(){
		history.back();
	}
</script>
</body>
</html>