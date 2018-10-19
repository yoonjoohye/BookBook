<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/template.css">
</head>
<body>
<%
	String content=request.getParameter("content");
%>
	<div id="top">
		<jsp:include page="top.jsp"/>
	</div>
	<div id="header">
		<jsp:include page="header.jsp"/>
	</div>
	<div id="content">
		<jsp:include page="<%=content %>"/>
	</div><br><br>
	<div id="footer">
		<jsp:include page="footer.jsp"/>
	</div>
</body>
</html>