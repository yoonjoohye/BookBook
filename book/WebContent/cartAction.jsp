<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BOOKBOOK</title>
</head>
<body>
	<%
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

		// 총 갯수
		int i = Integer.parseInt(request.getParameter("i"));

		List<String> titles = new ArrayList<>();
		List<String> num = new ArrayList<>();

		// for문을 돌려서 hidden값을 받아오고 check가 contain되어잇는지 확인

		for (int j = 1; j < i; j++) {
			String k = null;
			String l = null;
			k = request.getParameter("hidden_" + j);
			l = request.getParameter("checked_" + j);
			out.println("K: " + k + "/ <br>");
			out.println("L: " + l + "/ <br>");
			if (k.contains("check")) {
				String t[] = k.split("_");
				String n[] = l.split("_");
				num.add(t[0]);
				titles.add(n[0]);
			}
		}

		/* for (int j=0; j<num.size(); j++) {
			out.println("num: "+num.get(j)+"/");
		}
		
		out.println("<br>");
		
		for (int j=0; j<titles.size(); j++) {
			out.println("title: "+titles.get(j)+"/");
		} */

		if (num.size() == 0) {
			out.println("<script>");
			out.println("location.href='cart.jsp';");
			out.println("alert('※상품을 선택해주세요');");
			out.println("</script>");
		} else {

			try {
				String DB_URL = "jdbc:mysql://localhost:3306/book?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";
				String DB_USER = "root";
				String DB_PASSWORD = "1234";

				Class.forName("com.mysql.jdbc.Driver").newInstance();
				Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

				PreparedStatement pstmt = null;

				String str = "";
				for (int j = 0; j < titles.size(); j++) {
					if (j < 1) {
						str = str + " AND title=?";
					} else {
						str = str + " OR title=?";
					}
				}
				pstmt = con.prepareStatement("DELETE FROM cart WHERE user_id=?" + str);
				pstmt.setString(1, userID);

				for (int j = 0; j < titles.size(); j++) {
					pstmt.setString(j + 2, titles.get(j));
				}

				pstmt.executeUpdate();
				pstmt.close();
				con.close();

				out.println("<script>");
				out.println("alert('상품을 삭제하였습니다.');");
				out.println("location.href='cart.jsp';");
				out.println("</script>");
				System.out.println("삭제완료!");
			} catch (Exception e) {
				out.println("<script>");
				out.println("history.back();");
				out.println("</script>");
				System.out.println("DB 연동 실패 " + e.getMessage());
			}
		}
	%>
</body>
</html>