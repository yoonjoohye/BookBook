<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel = "stylesheet" href="css/orderFinish.css">
<title>BOOKBOOK</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	out.println("<script>");
	out.println("alert('주문이 완료되었습니다.');");
	//out.println("location.href='cart.jsp';");
	out.println("</script>");
	request.setCharacterEncoding("UTF-8");

	int k = Integer.parseInt(request.getParameter("k"));	// 책의 갯수
	
	List<String> title = new ArrayList<>();
	List<String> count = new ArrayList<>();
	List<String> cost = new ArrayList<>();
	for (int i=1; i<k; i++) {
		title.add(request.getParameter("title_"+i));	// 상품명받아오기
		count.add(request.getParameter("count_"+i));	// 갯수받아오기
		cost.add(request.getParameter("cost_"+i));	// 갯수받아오기
	}
	
	String arriveDay = request.getParameter("arriveDay");
	
	// 주문고객
	String orderName = request.getParameter("orderName");	//주문자이름
	String orderPhone1 = request.getParameter("orderPhone1");	//주문자번호1
	String orderPhone2 = request.getParameter("orderPhone2");	//주문자번호2
	String orderPhone3 = request.getParameter("orderPhone3");	//주문자번호3
	String orderEmail = request.getParameter("orderEmail");	//주문자이메일
	String orderAdd = request.getParameter("orderAdd");	//주문자주소
	
	
	// 받는고객
	String arrName = request.getParameter("arrName");	//받는자이름
	String arrPhone1 = request.getParameter("arrPhone1");	//받는자번호1
	String arrPhone2 = request.getParameter("arrPhone2");	//받는자번호2
	String arrPhone3 = request.getParameter("arrPhone3");	//받는자번호3
	String arrEmail = request.getParameter("arrEmail");	//받는자이메일
	String arrAdd = request.getParameter("arrAdd");	//받는자주소
	
	String price = request.getParameter("hidden_price"); // 판매가
	String usedPoint = request.getParameter("usedPoint"); // 사용된 포인트
	String sale = request.getParameter("hidden_sale"); // 할인
	String total = request.getParameter("pointTotal_hidden"); // 최종금액
	
%>
	<center>
		<div id="bigBox" align="left">
			<span><h3>상품정보</h3></span>
				<table cellspacing=0>
					<tr>
						<th>상품명</th>
						<th>수량</th>
						<th>상품금액</th>
						<th>합계</th>
						<th>배송상황</th>
					</tr>
				<%
					for (int i=0; i<title.size(); i++) {
					%>
						<tr>
							<td><%=title.get(i)%></td>
							<td><%=count.get(i)%></td>
							<td><%=cost.get(i)%></td>
							<td><%=Integer.parseInt(count.get(i))*Integer.parseInt(cost.get(i))%></td>
							<td>
							<%
								SimpleDateFormat DateFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
								Date date = new Date();
								String day = DateFormat.format(date);
								String[] days = day.split("-");
								int d = Integer.parseInt(days[2]);
								String nowDate = days[0] + "." + days[1] + "." + d;
								String[] arrive = arriveDay.split("\\.");
								String[] now = nowDate.split("\\.");
								
								List<Integer> arriveInt = new ArrayList<>();
								List<Integer> nowInt = new ArrayList<>();
								
								for (int j=0; j<3; j++) {
									arriveInt.add(Integer.parseInt(arrive[j]));
									nowInt.add(Integer.parseInt(now[j]));
								}
								
								int arr = (arriveInt.get(0)*365) + (arriveInt.get(1)*31) + arriveInt.get(2);
								int n = (nowInt.get(0)*365) + (nowInt.get(1)*31) + nowInt.get(2);
								
								if (arr<n) {
									out.println(arriveDay+"에 도착했음");
								}
								else if (arr==n) {
									out.println("오늘 도착예정");
								}
								else {
									out.println(arriveDay+"<br> 도착예정");
								}
							%>
							</td>
						</tr>
					<%
					}
				%>
				</table>
				
				<span><h3>주문고객</h3></span>
				<table cellspacing=0>
					<tr>
						<th>이름</th>
						<th>핸드폰</th>
						<th>이메일</th>
						<th>주소</th>
						
					</tr>
					<tr>
						<td><%=orderName%></td>
						<td><%=orderPhone1%>-<%=orderPhone2%>-<%=orderPhone3%></td>
						<td><%=orderEmail%></td>
						<td><%=orderAdd%></td>
					</tr>
				</table>
				
				<span><h3>배송정보</h3></span>
				<table cellspacing=0>
					<tr>
						<th>이름</th>
						<th>핸드폰</th>
						<th>이메일</th>
						<th>주소</th>
						
					</tr>
					<tr>
						<td><%=arrName%></td>
						<td><%=arrPhone1%>-<%=arrPhone2%>-<%=arrPhone3%></td>
						<td><%=arrEmail%></td>
						<td><%=arrAdd%></td>
					</tr>
				</table>
				
				<span><h3>결재정보</h3></span>
				<table cellspacing=0>
					<tr>
						<th>판매가격</th>
						<th>+</th>
						<th>배송비</th>
						<th>-</th>
						<th>포인트</th>
						<th>-</th>
						<th>할인가격</th>
						<th>=</th>
						<th>총 결제금액</th>
						
					</tr>
					<tr>
						<td><%=price%></td>
						<td>+</td>
						<td>2500</td>
						<td>-</td>
						<td><%=usedPoint%></td>
						<td>-</td>
						<td><%=sale%></td>
						<td>=</td>
						<td><%=total%></td>
					</tr>
				</table>
				<a href="index.jsp"><input type="button" value="홈으로"></a>
		</div>
	</center>
</body>
</html>