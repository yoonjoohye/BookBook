<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>BOOKBOOK</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
	function check() {
		var id = document.getElementById("id").value;
		var pw = document.getElementById("pw").value;
		if (id != "" && pw != "") {
			document.getElementById("loginform").submit();
		} else {
			alert("입력을 확인해주세요!");
		}
	}
</script>
<link rel="stylesheet" href="css/login.css">
</head>
<body>
	<center>
	<div id="loginBox">
		<a href="index.jsp"><img src="img/logo.png" width="250px" align="center"></a>
		<form id="loginform" action="loginAction.jsp" method="post">
			<div id="row">
				<span>
					<input type="text" name="id" id="id" placeholder="아이디">
				</span>
			</div>
			<div id="row">
				<span>
					<input type="password" name="pw" id="pw" placeholder="비밀번호">
				</span>
			</div>
			<input type="button" value="로그인" onclick="check()">
			<a href="index.jsp"><input type="button" value="취소"></a>
			
			<div id="links">
			<small>
				<ul>
					<li> <a href="joinForm1.jsp">회원가입하기</a> </li>
					<li> <a href="findForm.jsp">아이디 / 비밀번호 찾기</a> </li>
				</ul>
			</small>
			</div>
		</form>
	</div>
	</center>
</body>
</html>