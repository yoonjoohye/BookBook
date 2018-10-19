<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/top.css">
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null) {
	%>
		<div id="register">
			<a href="loginForm.jsp">로그인</a>
			<a href="joinForm1.jsp">회원가입</a>
			<a href="cart.jsp">장바구니</a>
			<a href="question.jsp">1:1문의</a>
		</div>
	<%} else if (userID.equals("joosang")) {%>
	<div id="register">
		<a href="#">관리자님</a>
		<a href="answer.jsp">문의사항</a>
		<a href="management.jsp">회원관리</a>
		<a href="bookNav.jsp">책관리</a>
		<a href="logout.jsp">로그아웃</a>
	</div>
	<%} else {%>
	<div id="register">
		<a href="editInfo.jsp"><%=userID%>님</a>
		<a href="point.jsp">포인트</a>
		<a href="cart.jsp">장바구니</a>
		<a href="question.jsp">1:1문의</a>
		<a href="logout.jsp">로그아웃</a>
	</div>
	<%}%>
</body>
</html>