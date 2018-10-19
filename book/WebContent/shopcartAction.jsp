<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
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
			out.println("location.href='loginForm.jsp';");
			out.println("</script>");
		}
		request.setCharacterEncoding("utf-8");
		
		String title = request.getParameter("title");
		String myimg = request.getParameter("myimg");
		String author = request.getParameter("author");
		String publisher = request.getParameter("publisher");
		int cost = Integer.parseInt(request.getParameter("cost"));
		int deliver = 2500;
		int count = Integer.parseInt(request.getParameter("count"));

		out.println(myimg + "<br>");
		out.println(title + "<br>");
		out.println(author + "<br>");
		out.println(publisher + "<br>");
		out.println(cost + "<br>");
		out.println(deliver + "<br>");
		out.println(count + "<br>");
		out.println(userID + "<br>");

		try {
			String dbURL = "jdbc:mysql://localhost:3306/book?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";
			String dbID = "root";
			String dbPW = "1234";

			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection con = DriverManager.getConnection(dbURL, dbID, dbPW);
			
			PreparedStatement pstmt1 = null;
			
			pstmt1 = con.prepareStatement("SELECT * FROM cart WHERE user_id = ? ");
			pstmt1.setString(1, userID);
			
			ResultSet rs1 = pstmt1.executeQuery();
			
			String check = "";
			while (rs1.next()) {
				if (rs1.getString("title").equals(title)) {
					out.println("중복값 있음" + title);
					check += "false";
				} else {
					out.println("중복값 없음" + title);
					check += "true";
				}
			}
			rs1.close();
			pstmt1.close();
			
			
			PreparedStatement pstmt2 = null;
			
			
			if (check.contains("false")) {
				pstmt2 = con.prepareStatement("UPDATE cart SET count = ? WHERE user_id = ? AND title = ?");
				pstmt2.setInt(1, count);
				pstmt2.setString(2, userID);
				pstmt2.setString(3, title);
			}
			else {
				pstmt2 = con.prepareStatement("insert into cart values(?,?,?,?,?,?,?)");
				pstmt2.setString(1, userID);
				pstmt2.setString(2, myimg);
				pstmt2.setString(3, title);
				pstmt2.setString(4, author);
				pstmt2.setString(5, publisher);
				pstmt2.setInt(6, cost);
				pstmt2.setInt(7, count);
			}
			
			pstmt2.executeUpdate();
			pstmt2.close();
			con.close();
			
			out.println("<script>");
			out.println("alert('장바구니에 상품을 담았습니다.');");
			out.println("location.href='cart.jsp';");
			out.println("</script>");
			System.out.println("연동 성공!");

		} catch (Exception e) {
			out.println(e.getMessage());
		}
	%>
</body>
</html>