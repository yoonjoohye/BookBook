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
		response.setContentType("text/html; charset=utf-8");
		request.setCharacterEncoding("UTF-8");

		String path = request.getRealPath("/book_img");
		//out.println(path+"<br>");

		MultipartRequest multi = new MultipartRequest(request, path, 1024 * 1024 * 5, "utf-8",
				new DefaultFileRenamePolicy());

		String bigKind = multi.getParameter("bigKind");
		String kind = multi.getParameter(bigKind);

		String title = multi.getParameter("title");
		String author = multi.getParameter("author");
		String publisher = multi.getParameter("publisher");
		String summary = multi.getParameter("summary");
		int cost = Integer.parseInt(multi.getParameter("cost"));
		String fileName = multi.getFilesystemName("myimg");
		out.println(fileName + "<br>");

		String img = path + "\\" + fileName;

		out.println(bigKind + "<br>");
		out.println(kind + "<br>");
		out.println(title + "<br>");
		out.println(author + "<br>");
		out.println(publisher + "<br>");
		out.println(summary + "<br>");
		out.println(cost + "<br>");
		out.println(fileName + "<br>");

		try {
			// 드라이버 로딩
			String dbURL = "jdbc:mysql://localhost:3306/book?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";
			String dbID = "root";
			String dbPW = "1234";

			Class.forName("com.mysql.jdbc.Driver").newInstance();
			Connection con = DriverManager.getConnection(dbURL, dbID, dbPW);

			PreparedStatement pstmt1 = null;
			pstmt1 = con.prepareStatement("select * from productNum");

			ResultSet rs = pstmt1.executeQuery();
			int id = 0;
			while (rs.next()) {
				id = rs.getInt("id");
			}
			PreparedStatement pstmt2 = null;

			if (id == 0) {
				pstmt2 = con.prepareStatement("INSERT INTO productnum VALUE(?)");
				out.println("id: " + id + " insert <Br>");
			} else if (id != 0) {
				pstmt2 = con.prepareStatement("UPDATE productnum SET id = ?");
				out.println("id: " + id + " update <Br>");
			}
			id++;
			pstmt2.setInt(1, id);

			pstmt2.executeUpdate();
			pstmt1.close();
			pstmt2.close();

			PreparedStatement pstmt3 = null;

			pstmt3 = con.prepareStatement("insert into product values(?,?,?,?,?,?,?,?,?)");
			pstmt3.setInt(1, id);
			pstmt3.setString(2, bigKind);
			pstmt3.setString(3, kind);
			pstmt3.setString(4, title);
			pstmt3.setString(5, author);
			pstmt3.setString(6, publisher);
			pstmt3.setString(7, summary);
			pstmt3.setInt(8, cost);
			pstmt3.setString(9, fileName);

			pstmt3.executeUpdate();
			pstmt3.close();
			con.close();

			System.out.println("연동 성공!");
			out.println("<script>");
			out.println("alert('책 등록 완료!');");
			out.println("location.href='bookAddForm.jsp';");
			out.println("</script>");
		} catch (Exception e) {
			out.println("<script>");
			out.println("alert('책 내용이 이상합니다');");
			out.println("location.href='bookAddForm.jsp';");
			out.println("</script>");
			System.out.println("DB 연동 실패 " + e.getMessage());
		}
	%>