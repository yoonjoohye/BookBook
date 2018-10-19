<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
	request.setCharacterEncoding("UTF-8");
%>

<jsp:forward page="template.jsp">
	<jsp:param name="content" value="orderForm.jsp"></jsp:param>
</jsp:forward>