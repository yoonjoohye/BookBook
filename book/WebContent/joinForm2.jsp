<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>BOOKBOOK</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
try{
String DB_URL = "jdbc:mysql://localhost:3306/book?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";
String DB_USER = "root";
String DB_PASSWORD= "1234";

Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

PreparedStatement pstmt=null; 
pstmt=con.prepareStatement("select * from member");
ResultSet rs = pstmt.executeQuery();
%>
<script>
	function checkID(){
		var id=document.getElementById("user_id").value;
		var check=false;
		
		<%while(rs.next()){%>
		if(id==""||id=="<%=rs.getString("user_id")%>"){
			alert("사용불가능한 아이디입니다.");
			return;
		 }
		 else check=false;
	    <%}
		rs.close();
		pstmt.close();
		con.close();
	} catch(Exception e){
		
	}%>
	 if(check==true){
		    //alert("사용불가능한 아이디입니다.");   
	    	document.getElementById("user_id").value="";
	    }
	 else{
	    alert("사용가능한 아이디입니다.");
	  }
	}
	function email_chk(){
		if(joinForm2.email.value!=""){
			joinForm2.email2.value=joinForm2.email.value;
		}
	}
	function join(){
		var id=joinForm2.user_id.value;
		var pw=joinForm2.user_pw.value;
		var pw_chk=joinForm2.pw_chk.value;
		var name=joinForm2.name.value;
		var email1=joinForm2.email1.value;
		var email2=joinForm2.email2.value;
		var address=joinForm2.address.value;
		if(id=="" || pw=="" ||pw_chk==""||name==""||email1==""||email2==""||address==""){
			alert("정보를 모두 입력해주세요!");
			return;
		}
		else if(pw!=pw_chk){
			alert("비밀번호를 확인해주세요!");
			joinForm2.pw_chk.focus();
			return;
		}
		else{
			document.getElementById("joinForm2").submit();
		}
	}
</script>
<link rel="stylesheet" href="css/join2.css">
</head>
<body>
	<div>
		<center>
			<a href="index.jsp"><img src="img/logo.png" width="250px" align="center"></a>
			<form id="joinForm2" name="joinForm2" action="joinAction.jsp" method="post" align="left">
				<div id="rowGroup">
					<div id="row">
						<span>
							<input type="text" placeholder="아이디" name="user_id" id="user_id">
							<input type="button" onclick="checkID()" id="id" value="중복">
						</span>
					</div>
					<div id="row">
						<span>
							<input type="password" placeholder="비밀번호" name="user_pw" id="user_pw">
						</span>
					</div>
					<div id="row">
						<span>
						<input type="password" placeholder="비밀번호 확인" name="pw_chk" id="pw_chk">
						</span>
					</div>
				</div>
				
				<div id="rowGroup">
					<div id="row">
						<span>
							<input type="text" placeholder="이름" name="name" id="name">
						</span>
					</div>
					<div id="row">
						<div id="button">생일</div>
						<span>
						<input type="text" placeholder="  년도(YYYY)" maxlength="4" name="year" id="bir_y"> <b>년</b>
						<select name="month">
		                    <option value="1">1</option> <option value="2">2</option>
		                    <option value="3">3</option> <option value="4">4</option>
		                    <option value="5" selected>5</option> <option value="6">6</option>
		                    <option value="7">7</option> <option value="8">8</option>
		                    <option value="9">9</option> <option value="10">10</option>
		                    <option value="11">11</option> <option value="12">12</option>
		                 </select><b> 월</b>
		                 <input type="number" name="day" palceholder="일(DD)" size="8" maxlength="2" max="31" min="1" step="1" id="bir_d">
		                 <b>일</b>
		                 </span>
					</div>
					<div id="row">
						<input type="text" id="email1" name="email1"> @ 
						<input type="text" name="email2" id="email2">
						<select name="email" id="email" onchange="email_chk()">
							<option value="">직접입력</option>
							<option value="naver.com">naver.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="nate.com">nate.com</option>
						</select>
					</div>
					<div id="row">
					<div id="row_address">
						<span>
							<input type="text" name="address" id="address" placeholder="주소">
						</span>
					</div>	
					</div>
				</div>
				<center>
					<input type="button" onclick="join()" value="회원가입">
				</center>
			</from>
		</center>
	</div>
</body>
</html>