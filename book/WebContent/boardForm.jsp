<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/board.css">
<title>BOOKBOOK</title>
</head>
<body>
<form method="post" action="boardAction.jsp">
<center>
<table>
<tr>
	<th>주제</th>
	<td align="left">
		<select name="title">
			<option value="회원관련">회원관련</option>
			<option value="주문/결제/취소">주문/결제/취소</option>
			<option value="제품/기타">제품/기타</option>
		</select>
	</td>	
</tr>
<tr>
	<th>내용</th>
	<td><textarea name="content"></textarea></td>
</tr>
</table><br><br>
<input type="submit" value="등록">
<a href="question.jsp"><input type="button" value="취소"></a>
</center>
</form>
</body>
</html>