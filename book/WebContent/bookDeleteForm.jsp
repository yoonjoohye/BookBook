<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/bookDelete.css">
<title>책 삭제</title>
<script>	
	function search() {
		document.form.submit();
	} // end of search();
</script>
<title>BOOKBOOK</title>
</head>
<body>
	<form action="bookSearchForm.jsp" target="smallIframe" name="form">
		<div id="box">
			<div id="search">
				<div id="select">
					<select id="kind" onchange="kind()" id="kind" name="kind">
						<option value="제목" selected>제목
						<option value="내용">내용
						<option value="지은이">지은이
					</select>
				</div>
				<div id="search_selected">
					<input type="text" name="content" placeholder="검색">
				</div>
			</div> <!--  end of search -->
			<div id="img"><img src="img/search.png" onclick="search()"></div>
		</div> <!--  end of box -->
	</form>
	
	<div id="list">
		<iframe id="smallIframe" name="smallIframe" src="bookSearchForm.jsp?kind=no&content=no"></iframe>
	</div>
	
	
	
</body>
</html>