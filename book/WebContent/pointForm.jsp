<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/point.css">
<title>Point</title>
<script>
	function send() {
		document.getElementById("getPoint").submit();
	}
</script>
</head>
<body>
<%!int DBpoint; %>
<%	
	String name = (String)session.getAttribute("userID");
	
	//드라이버 로딩
	String dbURL = "jdbc:mysql://localhost:3306/book?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";
	String dbID = "root";
	String dbPW="1234";
		
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager.getConnection(dbURL, dbID, dbPW);
	PreparedStatement pstmt=null;
	
	try {
		pstmt=con.prepareStatement("SELECT * FROM point WHERE user_id=?");
		pstmt.setString(1, name);
		ResultSet rs = pstmt.executeQuery();
		
	    while(rs.next()){
	    	DBpoint = rs.getInt("point");
          }
	   	pstmt.close();
	}
	catch (Exception e) {
		out.println("rs받아오기 실패"+e.getMessage());
	}
	
%>
	<center>
		<div id="point">
			현재 <%=name %>님의 포인트는 <span id="p"><%=DBpoint %>P</span>입니다.
			<p><small>※포인트는 하루에 한 번만 받을 수 있습니다.</small></p>
		</div>
		<form method="post" action="pointAction.jsp" id="getPoint">
			<input type="button" value="포인트 받기" onclick="send()">
		</form>
	</center>
</body>
</html>