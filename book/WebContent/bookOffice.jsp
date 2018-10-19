<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>책 관리</title>
<link rel="stylesheet" href="css/bookOffice.css">
<script>
	function changeColor(index) {
		var button1 = document.getElementById("add");
		var button2 = document.getElementById("delete");
		if (index==1) { 
			button1.style.backgroundColor="#fbcc00";
			button2.style.backgroundColor="white";
		}
		else if (index==2) { 
			button1.style.backgroundColor="white";
			button2.style.backgroundColor="#fbcc00";
		}
		
	}
</script>
<title>BOOKBOOK</title>
</head>
<body>
	<center>
		<table>
			<tr>
				<td>
					<a href="bookAddForm.jsp" target="iframe">
						<div id="add" onclick="changeColor(<%=1%>)"> 책 추가 </div>
					</a>
					<a href="bookDeleteForm.jsp" target="iframe">
						<div id="delete" onclick="changeColor(<%=2%>)"> 책 삭제 </div>
					</a>
			</tr>
			<tr>
				<td><iframe name="iframe" src="bookAddForm.jsp"></iframe>
			</tr>
		</table>
	</center>
	
</body>
</html>