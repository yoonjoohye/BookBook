<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>이용약관동의</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function check(){
	if(document.getElementById("check1").checked && document.getElementById("check2").checked){
		document.getElementById("joinForm1").submit();
	}
	else{
		alert("이용약관에 동의하셔야합니다.");
	}
}
</script>
<link rel="stylesheet" href="css/join1.css">
<title>BOOKBOOK</title>
</head>
<body>
<center>
<form name="joinForm1" id="joinForm1" action="joinForm2.jsp" method="post">
	<div id="label">약관동의</div>
	<table>
		<tr><td> 이용약관</td></tr>
		<tr>
			<td><iframe src="agree1.jsp" id="iframe1" frameborder=0></iframe></td>
		</tr>
		<tr>
			<td id="padding">
				<small>약관에 동의하십니까?
				<input type="checkbox" id="check1" value="agree">동의함</small>
			</td>
		</tr>
	</table><br>
	
	<table>
		<tr><td>개인정보취급방침</td></tr>
		<tr>
			<td><iframe src="agree2.jsp" id="iframe2" frameborder=0></iframe></td>
		</tr>
		
		<tr>
			<td id="padding">
				<small>약관에 동의하십니까?
				<input type="checkbox" id="check2"value="agree">동의함</small>
			</td>
		</tr>
	</table><br>
	<table>
		<tr>
			<td align="center">
				<input type="button" onclick="check()" value="동의"> 
				<a href="index.jsp"><input type="button" id="cancel" value="취소"></a>
			</td>
		</tr>
	</table><br>
</form>
</center>
</body>
</html>