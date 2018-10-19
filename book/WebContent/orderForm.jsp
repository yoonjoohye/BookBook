<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/order.css">
<title>BOOKBOOK</title>
<script>
	function price() {
		var point = document.getElementById("usePoint").value;	// 사용할 포인트
		var label = document.getElementById("pt");	// label
		var pointTotal_hidden = document.getElementById("pointTotal_hidden");
		var pointTotal = document.getElementById("pointTotal");
		var usedPoint = document.getElementById("usedPoint");	// 사용한 포인트 저장부분 
		var canUsePoint = document.getElementById("canUsePoint").value;	// 사용가능한 포인트
		var fixed = document.getElementById("fixed");	// fixed
		
		if (parseInt(point)>parseInt(canUsePoint)) {
			alert("최대 사용가능한 포인트는 " + canUsePoint +"P 입니다.");
			return;
		}
		
		label.innerHTML = point;
		usedPoint.value = point;
		
		pointTotal.innerHTML = fixed.value-point;
		pointTotal_hidden.value = fixed.value-point;
	}
	
</script>
</head>
<body>
<center>
	<div id="superBig">
	<%
		int point = 0;
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null) {
			out.println("<script>");
			out.println("alert('로그인이 필요합니다.');");
			out.println("location.href='login.jsp';");
			out.println("</script>");
		}

		request.setCharacterEncoding("utf-8");

		String part = request.getParameter("part");
		// 총 갯수
		int i=0;
		List<String> titles = new ArrayList<>();
		List<String> num = new ArrayList<>();
		
		if (part.equals("part") || part.equals("full")) {
			i = Integer.parseInt(request.getParameter("i"));			
			
			// for문을 돌려서 hidden값을 받아오고 check가 contain되어잇는지 확인
	
			for (int j = 1; j < i; j++) {
				String k = null;
				String l = null;
				k = request.getParameter("hidden_" + j);
				l = request.getParameter("checked_" + j);
				/* out.println("K: " + k + "/ <br>");
				out.println("L: " + l + "/ <br>"); */
				if (k.contains("check")) {
					String t[] = k.split("_");
					String n[] = l.split("_");
					num.add(t[0]);
					titles.add(n[0]);
				}
			}
		}

		/* for (int j=0; j<num.size(); j++) {
			out.println("num: "+num.get(j)+"/");
		}
		
		out.println("<br>");
		
		for (int j=0; j<titles.size(); j++) {
			out.println("title: "+titles.get(j)+"/");
		} */

		if (part.equals("part") && num.size() == 0) {
			out.println("<script>");
			out.println("location.href='cart.jsp';");
			out.println("alert('※상품을 선택해주세요');");
			out.println("</script>");
		}
		
		int price = 0;
		int dprice = 0;
		int total = 0;
		int k=1;
	%>
	<div id="bigBox">
		<form method="post" name="orderForm" id="orderForm" action="orderFinish.jsp">
			<div id="white">
				<span>상품정보</span>
				<table cellspacing=0 id="product">
					<tr>
						<th colspan=2>상품명</th>
						<th>수량</th>
						<th>상품금액</th>
						<th>합계</th>
						<th>배송상황</th>
					</tr>
					<%
						try {
							String DB_URL = "jdbc:mysql://localhost:3306/book?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";
							String DB_USER = "root";
							String DB_PASSWORD = "1234";

							Class.forName("com.mysql.jdbc.Driver").newInstance();
							Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

							PreparedStatement pstmt = null;

							String str = "";
							// 전체주문
							if (part.equals("full")) {
								pstmt = con.prepareStatement("SELECT * FROM cart WHERE user_id=?");
								pstmt.setString(1, userID);
							}

							// 부분주문
							else if (part.equals("part")) {
								for (int j = 0; j < num.size(); j++) {
									if (j < 1) {
										str = str + " AND title=?";
									} else {
										str = str + " OR title=?";
									}
								}
								pstmt = con.prepareStatement("SELECT * FROM cart WHERE user_id=?" + str);
								pstmt.setString(1, userID);

								for (int j = 0; j < num.size(); j++) {
									pstmt.setString(j + 2, titles.get(j));
								}
							}
							// 바로 구매하기를 눌렀을 때
							else if (part.equals("only")) {
								pstmt = con.prepareStatement("SELECT * FROM cart WHERE user_id=? AND title=?");
								pstmt.setString(1, userID);
								String title = (String)application.getAttribute("title");
								pstmt.setString(2, title);
							}

							ResultSet rs = pstmt.executeQuery();
							
							
							while (rs.next()) {
					%>
					<tr>
						<td>
							<img src="book_img/<%=rs.getString("image")%>" width=100px height=150px>
						</td>
						<td id="content">
							<%=rs.getString("title")%><br> <%=rs.getString("author")%><small>저
								| </small> <%=rs.getString("publisher")%>
							<input type="hidden" name=title_<%=k%> value="<%=rs.getString("title")%>">
						</td>
						<td>
							<%=rs.getInt("count")%>
							<input type="hidden" name=count_<%=k%> value="<%=rs.getInt("count")%>">
						</td>
						<td>
							<%=rs.getInt("cost")%>
							<input type="hidden" name=cost_<%=k%> value="<%=rs.getInt("cost")%>">
						</td>
						<td><%=rs.getInt("cost") * rs.getInt("count")%></td>
						<td>
							<%
								SimpleDateFormat DateFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
								Date date = new Date();
								String day = DateFormat.format(date);
								String[] days = day.split("-");
								int d = Integer.parseInt(days[2]) + 2;
								out.println(days[0] + "." + days[1] + "." + d + "<br> 도착예정");
							%>
							<input type="hidden" name="arriveDay" value="<%=days[0]%>.<%=days[1]%>.<%=d%>">
						</td>
					</tr>
					<%
						price = price + rs.getInt("count") * rs.getInt("cost");
								dprice = 2500;
								k++;
							}

							pstmt = con.prepareStatement("SELECT * FROM point WHERE user_id=?");
							pstmt.setString(1, userID);
							ResultSet rs2 = pstmt.executeQuery();
							while (rs2.next()) {
								point = rs2.getInt("point");
							}
							rs.close();
							rs2.close();	
							pstmt.close();
							con.close();
						} catch (Exception e) {
							System.out.println("db 연동 실패");
						}
						total = price + dprice;
					%>
				</table>
			</div>
			<%
				try {
					String DB_URL = "jdbc:mysql://localhost:3306/book?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";
					String DB_USER = "root";
					String DB_PASSWORD = "1234";

					Class.forName("com.mysql.jdbc.Driver").newInstance();
					Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

					PreparedStatement pstmt = null;
					pstmt = con.prepareStatement("SELECT * FROM member WHERE user_id=?");
					pstmt.setString(1, userID);
					ResultSet rs = pstmt.executeQuery();

					String name = "";
					String tel = "";
					String add = "";

					while (rs.next()) {
						name = rs.getString("name");
						add = rs.getString("address");
					}
			%>
			
			<span>주문고객</span>
			<table id="order" cellspacing=0>
				<tr>
					<th>이름</th>
					<td>
						<input type="text" value="<%=name%>" name="orderName" id="short">
					</td>
				</tr>
				<tr>
					<th>핸드폰</th>
					<td>
						<select name="orderPhone1">
							<option value="010" selected>010</option>
							<option value="011">011</option>
							<option value="016">016</option>
							<option value="017">017</option>
							<option value="018">018</option>
							<option value="019">019</option>
						</select>
						 - <input type="number" name="orderPhone2" required> - <input type="number" name="orderPhone3" required>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="text" id="long" required name="orderEmail"></td>
				</tr>
				<tr>
					<th>주소</th>
					<td><input type="text" id="long" name="orderAdd" required></td>
				</tr>
			</table>
			
			<span>배송정보</span>
			<table id="deliv" cellspacing=0>
				<tr>
					<th>이름</th>
					<td><input type="text" value="<%=name%>" name="arrName" id="short" align="center"></td>
				</tr>
				<tr>
					<th>핸드폰</th>
					<td>
						<select name="arrPhone1">
							<option value="010" selected>010</option>
							<option value="011">011</option>
							<option value="016">016</option>
							<option value="017">017</option>
							<option value="018">018</option>
							<option value="019">019</option>
						</select>
						 - <input type="number" required name="arrPhone2">	 - <input type="number" name="arrPhone3" required>
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="text" id="long" required name="arrEmail"></td>
				</tr>
				<tr>
					<th>주소</th>
					<td><input type="text" id="long" required name="arrAdd"></td>
				</tr>
			</table>
			
			<div id="span"><span id="finish">최종 결제 금액</span></div>
			<div id="finish">
				<table id="point" cellspacing=0>
					<tr>
						<th id="right">사용 가능한 포인트</th>
						<td id="right">
							<%=point %> p
							<input type="hidden" id="canUsePoint" value="<%=point%>">
						</td>
						<th id="right">사용 할 포인트</th>
						<td><input type="number" id="usePoint" onchange="price()" value="0"> p</td>
					</tr>
				</table>
				
				<table id="money" cellspacing=0>
					<tr>
						<th id="right">판매가격</th>
						<th id="right">배송비</th>
						<th id="right">포인트</th>
						<th id="right">할인가격</th>
						<th>총 결제 금액</th>
					</tr>
					<tr>
						<td id="right">
							<%=price%>
							<input type="hidden" name="hidden_price" value="<%=price%>">
						</td>
						<td id="right"><%=dprice%></td>
						<td id="right">
							<label id="pt">0 </label>P
							<input type="hidden" id="usedPoint" name="usedPoint" value="0">
						</td>
						<td id="right">
						<%
							int sale=0;
							if(price>50000) {
								sale=2500;
								total = total-sale;
							}
						%>
						<%=sale %>
						<input type="hidden" name="hidden_sale" value="<%=sale%>">
						</td>
						<td id="total">
							<label id="pointTotal"><%=total%></label>
							<input type="hidden" name="fixed" id="fixed" value="<%=total%>">
							<input type="hidden" name="pointTotal_hidden" id="pointTotal_hidden" value="<%=total%>">
						</td>
					</tr>
				</table>
			</div>
			
			<span>결제정보</span>
			<table id="info" cellspacing=0>
				<tr>
					<td align="left">
						<input type="radio" name="how" value="moo" required>무통장입금
					
						<select name="bank" id="bank">
							<option value="농협은행" selected>농협은행</option>
							<option value="국민은행">국민은행</option>
							<option value="기업은행">기업은행</option>
							<option value="신한은행">신한은행</option>
							<option value="우리은행">우리은행</option>
							<option value="제일은행">제일은행</option>
							<option value="하나은행">하나은행</option>
						</select>
					</td>
				</tr>
			</table>
			<input type="hidden" name="k" value="<%=k %>">
			<div id="button">
				<input type="submit" value="주문하기">
				<a href="cart.jsp"><input type="button" value="취소하기"></a>
			</div>
		</form>
	</div>
	<%
		} catch (Exception e) {

		}
	%>
	</div>
</center>
</body>
</html>