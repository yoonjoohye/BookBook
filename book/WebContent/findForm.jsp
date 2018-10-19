<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/find.css">
<title>BOOKBOOK</title>
</head>
<body>
	<div id="box">
	<a href="index.jsp"><img src="img/footer.png" width="300px"></a>
		<div id="find">
			<h3>아이디찾기</h3>
			<form id="id" action="findID.jsp">
				<table>
					<tr>
						<td>이름</td>
						<td><input type="text" name="name" required></td>
					</tr>
					<tr>
						<td>이메일</td>
						<td><input type="email" name="email" required></td>
					</tr>
					<tr>
						<td colspan=2 align="center"><input type="submit" value="아이디찾기"></td>
					</tr>
				</table>
			</form>
		</div>
		
		<div id="find">
			<h3>비밀번호찾기</h3>
			<form id="pw" action="findPW.jsp">
				<table>
					<tr>
						<td>이름</td>
						<td><input type="text" name="name" required></td>
					</tr>
					<tr>
						<td>아이디</td>
						<td><input type="text" name="id" required></td>
					</tr>
					<tr>
						<td colspan=2 align="center"><input type="submit" value="비밀번호찾기"></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>