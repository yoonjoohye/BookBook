<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/header.css">
<title>BOOKBOOK</title>
</head>
<body>
<%
String userID=null;
if(session.getAttribute("userID")!=null){
	userID=(String)session.getAttribute("userID");
}%>
<div id="header_div">
	<a href="index.jsp"><img src="img/logo.png"></a>
</div>

<div id="nav">
	<ul>
		<li><a href="book.jsp?re=소설">소설</a>
		<div id="novel">
			<ul id="novel1">
				<li><a href="books.jsp?re=청소년">청소년</a></li>
				<li><a href="books.jsp?re=추리">추리</a></li>
				<li><a href="books.jsp?re=에세이">에세이</a></li>
				<li><a href="books.jsp?re=기타">기타</a></li>
			</ul>
		</div>
		</li>
		
		<li><a href="book.jsp?re=취미/여행">취미/여행</a>
		<div id="hobby">
			<ul id="hobby1">	
				<li><a href="books.jsp?re=건강">건강</a></li>
				<li><a href="books.jsp?re=스포츠">스포츠</a></li>
				<li><a href="books.jsp?re=패션">패션</a></li>
				<li><a href="books.jsp?re=반려동물">반려동물</a></li>
			</ul>
		</div>
		</li>

		<li><a href="book.jsp?re=만화">만화</a>
		<div id="comic">
			<ul id="comic1">	
				<li><a href="books.jsp?re=교양">교양</a></li>
				<li><a href="books.jsp?re=순정">순정</a></li>
				<li><a href="books.jsp?re=학원">학원</a></li>
				<li><a href="books.jsp?re=성인">성인</a></li>
			</ul>
		</div>
		</li>
		
		<li><a href="book.jsp?re=문제집">문제집</a>
		<div id="problem">
			<ul id="problem1">
				<li><a href="books.jsp?re=초/중/고">초/중/고</a></li>
				<li><a href="books.jsp?re=자격증">자격증</a></li>
				<li><a href="books.jsp?re=외국어">외국어</a></li>
				<li><a href="books.jsp?re=취업">취업</a></li>
			</ul>
		</div>
		</li>
		
	</ul>
</div>
</body>
</html>