<%@page import="java.util.Calendar"%>
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
	request.setCharacterEncoding("utf-8");
	String userID=null;
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}
	if(userID==null){
		out.println("<script>");
		out.println("alert('로그인이 필요합니다.');");
		out.println("location.href='login.jsp';");
		out.println("</script>");
	}
	Calendar cal = Calendar.getInstance( );
	int year=cal.get(Calendar.YEAR);
    int month=cal.get(Calendar.MONTH) + 1;
    int day=cal.get(Calendar.DAY_OF_MONTH);
    int hour=cal.get(Calendar.HOUR_OF_DAY); 
    int minute=cal.get(Calendar.MINUTE);
    int second=cal.get(Calendar.SECOND);
    
    String date=year+"년"+month+"월"+day+"일"+hour+"시"+minute+"분"+second+"초";
	
    String title=request.getParameter("title");
	String content=request.getParameter("content");
	
	out.println(date);
	out.println(title);
	out.println(content);
			
	
	try {
	    // 드라이버 로딩
	    String dbURL = "jdbc:mysql://localhost:3306/book?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";
	    String dbID = "root";
	    String dbPW="1234";
	   	
	    Class.forName("com.mysql.jdbc.Driver").newInstance();
	   	Connection con = DriverManager.getConnection(dbURL, dbID, dbPW);
	   	
	   	PreparedStatement pstmt=null; 
	   	pstmt = con.prepareStatement("insert into question values(NULL,?,?,?,?,NULL)");
	   	pstmt.setString(1,userID);
	   	pstmt.setString(2,title);
	   	pstmt.setString(3,content);
	   	pstmt.setString(4,date);

	   	pstmt.executeUpdate();
	   	pstmt.close();
	   	con.close();
	   	
	   	response.sendRedirect("question.jsp");   
	   	System.out.println("연동 성공!");
	} catch (Exception e) {       
		response.sendRedirect("board.jsp");  
	    System.out.println("DB 연동 실패 " + e.getMessage());
	} 
%>
</body>
</html>