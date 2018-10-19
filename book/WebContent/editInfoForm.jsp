<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="css/edit.css"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BOOKBOOK</title>
<script>
	function edit() {
		var pw1 = mypageForm.edit_pw1.value;
		var pw2 = mypageForm.edit_pw2.value;
		var name = mypageForm.edit_name.value;
		var email = mypageForm.edit_email.value;
		var address = mypageForm.edit_address.value;
		if (pw == "" || name == "" || email == "" || address == "") {
			alert("정보를 모두 입력해주세요!");
			return;
		} else if (pw1 != pw2) {
			alert("비밀번호를 확인해주세요!");
			joinForm2.pw_chk.focus();
			return;
		} else {
			document.getElementById("mypageForm").submit();
		}
	}
	function cancel(){
		history.back();
	}
</script>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null) {

			out.println("<script>");
			out.println("alert('로그인이 필요합니다.');");
			out.println("location.href='loginForm.jsp';");
			out.println("</script>");
		}
	%>
	<h2>회원정보 수정</h2>
		<form id="mypageForm" action="mypageAction.jsp" align="left">
		<center>
			<table id="join" align="center">
				<tr>
					<th>이름</th>
					<td><input type="text" name="edit_name"></td>
				</tr>
				<tr>
					<th>아이디</th>
					<td><input type="text" value="<%=userID%>" disabled ></td>
				</tr>
				<tr>
					<th>현재 비밀번호</th>
					<td><input type="password" name="pw"></td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="edit_pw1" ></td>
				</tr>
				<tr>
					<th>비밀번호확인</th>
					<td><input type="password" name="edit_pw2"></td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td>
					<input type="number" placeholder="년도(YYYY)" maxlength="4" name="year" id="bir_y"> <b>년</b>
						<select name="month" id="bir_m">
							<option value="1" selected>1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5" >5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
						</select><b> 월</b> 
					<input type="number" name="day" palceholder="일(DD)" size="8" maxlength="2" max="31" min="1" step="1" id="bir_d"> <b>일</b>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td>
						<input type="text" id="email1" name="email1"> @ 
						<input type="text" name="email2" id="email2">
						<select name="email" id="email" onchange="email_chk()">
							<option value="">직접입력</option>
							<option value="naver.com">naver.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="nate.com">nate.com</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>
						<input type="text" name="edit_address1" id="address1"><br>
						<input type="text" name="edit_address2" id="address2"><br>
					</td>
				</tr>
				<tr>
					<td colspan=2 align="center">
						<input type="button" onclick="edit()" value="등록"> 
						<input type="button" id="cancel" value="취소" onclick="cancel()">	
					</td>
				</tr>
			</table>
		</center>
	</form>
</body>
</html>