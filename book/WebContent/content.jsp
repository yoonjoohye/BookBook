<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/main.css">
<script>
	window.onload = function() {
		var myIndex = 0;
		carousel();

		function carousel() {
			var i;
			var x = document.getElementsByClassName("mySlides");
			for (i = 0; i < x.length; i++) {
				x[i].style.display = "none"
			}
			myIndex++;
			if (myIndex > x.length) {
				myIndex = 1
			}
			x[myIndex - 1].style.display = "block"
			setTimeout(carousel, 5000); // Change image every 2 seconds
		}
	}
</script>
<title>BOOKBOOK</title>
</head>
<body>
	<div id="all">
		<center>
			<div class="slide" width="730px" height="500px">
				<img class="mySlides" src="img/banner1.png">
				<img class="mySlides" src="img/banner2_1.png">
				<img class="mySlides" src="img/banner3.png">
			</div>
			
			<a href="https://www.instagram.com/sangah0_0/" id="insta1" target="_blank">
				<img src="img/chae.jpg" width=230px height=240px />
			</a>
			
			<a href="https://www.instagram.com/p/BkhiUeSDx-d/?taken-by=yoonjoohye_jpg" id="insta2" target="_blank">
				<img src="img/yoon.png" width=230px height=240px />
			</a>
			
			<div id="today">
				<h3>[ 오늘의 책 ]</h3>
				<jsp:include page="todaysbook.jsp"></jsp:include>
			</div>
		</center>
	</div>
</body>
</html>