<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<script>
	function send(index) {
		switch(index) {
			case 1: document.cartForm.action = "cartAction.jsp"; break;
			case 2: document.cartForm.action = "order.jsp?part=part"; break;
			case 3: document.cartForm.action = "order.jsp?part=full"; break;
		}
		document.cartForm.submit();
	}
	
	var cnt=0;
	function checking(id) {
		var hidden = document.getElementById(eval("'hidden_"+id+"'"));
		var name = document.getElementsByName(eval("'hidden_"+id+"'"));
		var value = hidden.value.split("_");
		var img = document.getElementById(eval("'img_"+id+"'"));
		
		// 체크하기
		if (cnt%2==1) {
			img.src="img/check.png";
			hidden.value=value[0]+"_unCheck";
			name.value=value[0]+"_unCheck";
		}
		else {
			img.src="img/checked.png";
			hidden.value=value[0]+"_check";
			name.value=value[0]+"_check";
		}
		cnt++;
	}
	
</script>
<link rel="stylesheet" href="css/cart.css">
<title>BOOKBOOK</title>
</head>
<body>
	<center>
		<!-- <a href="orderList.jsp">주문현황보기</a> -->
		<form method="post" id="cartForm" name="cartForm">
			<table cellspacing=0>
				<tr>
					<th>
						<img src="img/checked.png">
					</th>
					<th colspan=2>상품명</th>
					<th>수량</th>
					<th>상품금액</th>
					<th>합계</th>
					<th>배송상황</th>
				</tr>
				<%
					String userID = null;
					int i=1;
					if (session.getAttribute("userID") != null) {
						userID = (String) session.getAttribute("userID");
					}
					if (userID == null) {
						out.println("<script>");
						out.println("alert('로그인이 필요합니다.');");
						out.println("location.href='loginForm.jsp';");
						out.println("</script>");
					}
					
					try {
						String DB_URL = "jdbc:mysql://localhost:3306/book?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";
						String DB_USER = "root";
						String DB_PASSWORD = "1234";

						Class.forName("com.mysql.jdbc.Driver").newInstance();
						Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

						PreparedStatement pstmt = null;
						pstmt = con.prepareStatement("select * from cart where user_id=?");
						pstmt.setString(1, userID);

						ResultSet rs = pstmt.executeQuery();
						
						while (rs.next()) {
				%>
				<tr>
					<td>
						<img src="img/check.png" id="img_<%=i%>" onclick="checking(<%=i%>)">
						<input type="hidden" name="hidden_<%=i%>" id="hidden_<%=i%>" value="<%=i%>_unCheck">
					</td>
					<td>
						<img src="book_img/<%=rs.getString("image")%>" width=100px height=150px>
						<input type="hidden" name="checked_<%=i%>" value="<%=rs.getString("title")%>_<%=i%>">
					</td>
					<td id="content">
						<%=rs.getString("title")%><br>
						<%=rs.getString("author")%><small>저</small> |
						<%=rs.getString("publisher")%>
					</td>
					<td><%=rs.getInt("count")%></td>
					<td><%=rs.getInt("cost")%></td>
					<td><%=rs.getInt("cost")*rs.getInt("count")%></td>
					<td>주문대기</td>
				</tr>
				<%
					i++;
				} // end of while
						rs.close();
						pstmt.close();
						con.close();
						
						response.sendRedirect("cart.jsp");
					} catch (Exception e) {
						response.sendRedirect("cart.jsp");
						System.out.println("DB 연동 실패 " + e.getMessage());
					}
				%>
			</table>
			<input type="hidden" name="i" value="<%=i%>">
			<input type="button" value="상품삭제" onclick="send(1)">
			<input type="button" value="선택주문" onclick="send(2)">
			<input type="button" value="전체주문" onclick="send(3)">
		</form>
	</center>
</body>
</html>