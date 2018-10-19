<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
	function send(index){
		if(index==1){
			document.shopForm.action="shopcartAction.jsp";
		}
		if(index==2){
			document.shopForm.action="shoporderAction.jsp";
		}
		document.shopForm.submit();
	}
</script>
<link rel="stylesheet" href="css/shop.css">
</head>
<body>
<center>
<form id="shopForm" name="shopForm" method="post">
<%
String userID=null;
if(session.getAttribute("userID")!=null){
	userID=(String)session.getAttribute("userID");
}
	request.setCharacterEncoding("utf-8");
	int id=Integer.parseInt(request.getParameter("re"));
try {
    String dbURL = "jdbc:mysql://localhost:3306/book?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";
    String dbID = "root";
    String dbPW="1234";
   	
    Class.forName("com.mysql.jdbc.Driver").newInstance();
   	Connection con = DriverManager.getConnection(dbURL, dbID, dbPW);
   	
   	PreparedStatement pstmt=null;
   	pstmt=con.prepareStatement("select * from product where id=?");
   	pstmt.setInt(1, id);
	ResultSet rs = pstmt.executeQuery();
   
   while(rs.next()){%>
   <table>
		<tr>
			<td>
				<img src="book_img/<%=rs.getString("filename")%>" width="300px" height="450px">
				<input type="hidden" name="myimg" value="<%=rs.getString("filename")%>">
			</td>
			<td id="td_right">
				<table>
					<tr>
						<td colspan=2>
							<div id="title">
								<h1><%=rs.getString("title")%></h1>
								<input type="hidden" name="title" value="<%=rs.getString("title")%>">
								<% application.setAttribute("title", rs.getString("title")); %>
							</div>
							<hr>
						</td>
					</tr>
					<tr>
						<td id="box">
							<div id="content_1">
								<%=rs.getString("author") %> <small>저</small> | 
								<input type="hidden" name="author" value="<%=rs.getString("author")%>">
								<%=rs.getString("publisher") %>
								<input type="hidden" name="publisher" value="<%=rs.getString("publisher")%>">
							</div>
							<div id="content_1">
								가격 <%=rs.getInt("cost") %><small>원</small>
								<input type="hidden" name="cost" value="<%=rs.getString("cost")%>">
							</div>
							<div id="content_1">
								배송비 2500원
							</div>
						</td>
						<td>
							<div id="content_2">
								수량 <input type="number" id="count" size=3 name="count" min=1 max=100 value="1">
							</div>
							<div id="content_2">
								<input type="button" onclick="send(1)" value="카트담기">
							</div>
							<div id="content_2">
								<input type="button" onclick="send(2)" value="구매하기">
							</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	
	<table id="content">
		<tr>
			<td id="hr"> <h4> | 책소개</h4> </td>
		</tr>
		<tr>
			<td>
			<%
				String str[] = rs.getString("content").split("\n");
								
				for (int i=0; i<str.length; i++) {
					out.println(str[i]+"<br>");
				}
			%></td>
		</tr>
	</table>
<% }  	
	rs.close();
   	pstmt.close();
   	con.close();
   	
} catch (Exception e) {  
    System.out.println("DB 연동 실패 " + e.getMessage());
}

%> 
</form>
</center>
</body>
</html>