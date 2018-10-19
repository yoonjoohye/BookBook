
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
 String id = request.getParameter("id");
 String pw = request.getParameter("pw");
  
 try{
	String DB_URL = "jdbc:mysql://localhost:3306/book?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";
	String DB_USER = "root";
	String DB_PASSWORD= "1234";
	 
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
	
	PreparedStatement pstmt=null;   	
	pstmt=con.prepareStatement("select * from member");
	ResultSet rs = pstmt.executeQuery();
	
    Boolean check=false;
    while(rs.next())
    {
	     if (id.equals(rs.getString("user_id")) && pw.equals(rs.getString("user_pw")))
	     {
		    check=true;
	    	break;
	     }
	     else
	     {
	    	 check=false;
	     }
    }
    if(check==true){
	    session.setAttribute("userID",id);
	    if(id.equals("joosang")){
			out.println("<script>");
			out.println("location.href='index.jsp';");
			out.println("alert('관리자 페이지입니다.');");
			out.println("</script>");
		}
	    else{
	    	out.println("<script>");
		    out.println("location.href='index.jsp';");
			out.println("alert('"+id+"님 환영합니다.');");
			out.println("</script>");
	    }
	    System.out.println("성공");
    }
    else{
    	System.out.println("실패");
    	out.println("<script>");
    	out.println("location.href='loginForm.jsp';");
		out.println("alert('아이디나 비밀번호가 틀렸습니다. 다시 입력해주세요');");
		out.println("</script>");
    }
    rs.close();
    pstmt.close();
    con.close();     
}
   catch(Exception e) {
    System.out.println(e);
   } 
%>

</body>
</html>