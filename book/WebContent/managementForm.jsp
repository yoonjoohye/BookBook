<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
 <head>
  <meta charset="UTF-8">
  <link rel="stylesheet" href="css/managementMember.css">
  <script>
	  function search() {
			document.form.submit();
		} // end of search();
  </script>
<title>BOOKBOOK</title>
 </head>
 <body>
 <center>
 <div id="bigBox">
 <form action="managementSearch.jsp" target="smallIframe" name="form">
	<div id="box">
		<div id="search">
			<div id="select">
				<select id="kind" name="kind">
					<option value="아이디" selected>아이디
					<option value="이름">이름
					<option value="생일">생일
					<option value="이메일">이메일
					<option value="주소">주소
					<option value="가입일">가입일
				</select>
			</div>
			<div id="search_selected">
					<input type="text" name="content" placeholder="검색">
			</div>
		</div> <!--  end of search -->
		<div id="img"><img src="img/search.png" onclick="search()"></div>
	</div>
</form>
	
<iframe id="smallIframe" name="smallIframe" src="managementSearch.jsp?kind=no&content=no"></iframe>
	
</div>
</center>
 </body>
</html>