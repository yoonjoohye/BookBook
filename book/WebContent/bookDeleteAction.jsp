<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="java.io.File"%>
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
		request.setCharacterEncoding("UTF-8");

		String[] check = request.getParameterValues("check");

		// 선택한 값이 없으면
		if (check == null || check.length <= 0) {
			out.println("<script>");
			out.println("alert('책을 선택해주세요');");
			out.println("#top");
			out.println("</script>");
		}

		try {
			String DB_URL = "jdbc:mysql://localhost:3306/book?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";
			String DB_USER = "root";
			String DB_PASSWORD = "1234";

			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

			PreparedStatement pstmt1 = null;

			for (int i = 0; i < check.length; i++) {
				pstmt1 = con.prepareStatement("DELETE from product WHERE title=?");
				pstmt1.setString(1, check[i]);
				pstmt1.executeUpdate();
			}
			pstmt1.close();

			PreparedStatement pstmt2 = null;
			pstmt2 = con.prepareStatement("select * from productNum");

			ResultSet rs = pstmt2.executeQuery();
			int id = 0;
			while (rs.next()) {
				id = rs.getInt("id");
			}
			rs.close();
			id -= 1;
			PreparedStatement pstmt3 = null;

			if (id == 0) {
				pstmt3 = con.prepareStatement("INSERT INTO productNum VALUE(?)");
			} else if (id != 0) {
				pstmt3 = con.prepareStatement("UPDATE productNum SET id = ?");
			}

			pstmt3.setInt(1, id);
			pstmt3.executeUpdate();

			pstmt2.close();
			pstmt3.close();

			con.close();

			for (int j = 0; j < check.length; j++) {
				out.println(check[j] + "<br>");
			}
			out.println("가(이) 삭제되었습니다.");

		} catch (Exception e) {
			out.println("DB연동 실패");
		}
	%>