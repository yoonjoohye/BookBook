<%@page import="java.util.Date"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
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
<%! 
		ResultSet rs;
		String DBday = null;
		int DBpoint;
		String name;
%>

<%	
	name = (String)session.getAttribute("userID");
	request.setCharacterEncoding("utf-8");
	SimpleDateFormat DateFormat = new SimpleDateFormat ("yyyy-MM-dd", Locale.KOREA);
	Date date = new Date ();
	String day = DateFormat.format (date);
	
	out.println(day);
	
	String first = "";
	
	Random rand = new Random();
	int point = rand.nextInt(1000);
%>
	
<%	
	//드라이버 로딩
	String dbURL = "jdbc:mysql://localhost:3306/book?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";
	String dbID = "root";
	String dbPW="1234";
		
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager.getConnection(dbURL, dbID, dbPW);
	PreparedStatement pstmt=null;
	%>
<%
	try {
		pstmt=con.prepareStatement("SELECT * FROM point WHERE user_id=?");
		pstmt.setString(1, name);
		ResultSet rs = pstmt.executeQuery();
	    while(rs.next()){
	    	DBday = rs.getString("date");
	    	DBpoint = rs.getInt("point");
          }
	    if (DBpoint==0) {
	    	first = "YES";
	    }
	    else { first = "NO"; }
	   	
	    pstmt.close();
	}
	catch (Exception e) {
		out.println("rs받아오기 실패"+e.getMessage());
	}
	out.println(first);
%>
<%
	if (day.equals(DBday)) {
		out.println("<script>");
		out.println("alert('이미 포인트를 받으셨습니다.');");
		out.println("location.href='point.jsp';");
		out.println("</script>");
	}
	else {
		out.println(point+"p를 받음");
%>
<%
	int inputPoint = point + DBpoint;
	try {
	    PreparedStatement pstmt1=null; 
	    if (first.equals("NO")) {
		   	pstmt1 = con.prepareStatement("UPDATE point SET point=? WHERE user_id=?");    
		   	
		   	pstmt1.setInt(1,inputPoint);
		   	pstmt1.setString(2,name);
	    }
	    else {
	    	pstmt1 = con.prepareStatement("insert into point values(NULL,?,?,?)");
		   	
		   	pstmt1.setString(1,name);
		   	pstmt1.setString(2,day);
		   	pstmt1.setInt(3,inputPoint);
	    }
		
	   	pstmt1.executeUpdate();
	   	
	   	rs.close();
	   	pstmt1.close();
	   	con.close();
	} catch (Exception e) { out.println("DB 연동실패 " + e.getMessage()); }
}	

	out.println("<script>");
	out.println("alert('"+point+"포인트를 받으셨습니다.');");
	out.println("location.href='point.jsp';");
	out.println("</script>");
%>
</body>
</html>