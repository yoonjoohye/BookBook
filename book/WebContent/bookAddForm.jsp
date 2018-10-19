<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/bookAdd.css">
<script>
	function smallKind() {	
		
		var bigKind = document.getElementById("bigKind").value;
		
		var div1 = document.getElementById("소설");
		var div2 = document.getElementById("취미");
		var div3 = document.getElementById("만화"); 
		var div4 = document.getElementById("문제집");
		
		switch(bigKind) {
		case "소설": 
			div1.style.display = "inline-block";
			div2.style.display = "none";
			div3.style.display = "none";
			div4.style.display = "none";
			break;
			
		case "취미/여행": 
			div1.style.display = "none";
			div2.style.display = "inline-block";
			div3.style.display = "none";
			div4.style.display = "none";
			break;
			
		case "만화": 
			div1.style.display = "none";
			div2.style.display = "none";
			div3.style.display = "inline-block";
			div4.style.display = "none";
			break;
			
		case "문제집": 
			div1.style.display = "none";
			div2.style.display = "none";
			div3.style.display = "none";
			div4.style.display = "inline-block";
			break;
		}
	}
	
	function getFileName() {
		var fileInput = document.getElementById('myimg');
		var fileName = fileInput.value.split(/(\\|\/)/g).pop();
		var span = document.getElementById('span');
		span.innerHTML = fileName;
	}
</script>
<title>BOOKBOOK</title>
</head>
<body>
	<form id="addForm" name="addForm" method="post" action="bookAddAction.jsp"
	enctype="multipart/form-data">
		<div id="box">
			<div id="content">
				분류
				<select id="bigKind" onchange="smallKind()" name="bigKind">
					<option value="소설" selected>소설
					<option value="취미/여행">취미/여행
					<option value="만화">만화
					<option value="문제집">문제집
				</select> >
				
				<div id="소설">
					<select name="소설">
						<option value="청소년" selected>청소년</option>
						<option value="추리">추리</option>
						<option value="에세이">에세이</option>
						<option value="기타">기타</option>
					</select>
				</div>
				
				<div id="취미">
					<select name="취미/여행">
						<option value="건강">건강</option>
						<option value="스포츠">스포츠</option>
						<option value="패션">패션</option>
						<option value="반려동물">반려동물</option>
					</select>
				</div>
				
				<div id="만화">
					<select name="만화">
						<option value="교양">교양</option>
						<option value="순정">순정</option>
						<option value="학원">학원</option>
						<option value="성인">성인</option>
					</select>
				</div>
				
				<div id="문제집">
					<select name="문제집">
						<option value="초/중/고">초/중/고</option>
						<option value="자격증">자격증</option>
						<option value="외국어">외국어</option>
						<option value="취업">취업</option>
					</select>
				</div>
			</div>
			<div id="content">
				<input type="text" id="title" name="title" placeholder=" 제목" required>
			</div>
			<div id="content">
				<div id="info">
				<input type="text" id="author" name="author" required placeholder=" 지은이"> 저 | 
				<input type="text" id="publisher" name="publisher" required placeholder=" 출판사"> | 
				<input type="text" id="cost" name="cost" required placeholder=" 가격">원
				</div>
			</div>
			<div id="content">
				<textarea id="summary" name="summary" rows=15 cols=80></textarea>
			</div>
			<div id="content">
				<input type="file" id="myimg" name="myimg" required onchange="getFileName()">
				<label for="myimg" id="label"><span id="span"><small> 이미지 선택</small></span></label>
				<input type="submit" value="상품등록">
			</div>
		</div>
	</form>
</body>
</html>