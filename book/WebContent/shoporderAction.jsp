<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
 <head>
  <meta charset="UTF-8">
 </head>
 <body>
 <%
	 String userID=null;
	 if(session.getAttribute("userID")!=null){
	 	userID=(String)session.getAttribute("userID");
	 }
	 if(userID==null){
	 	out.println("<script>");
	 	out.println("alert('로그인이 필요합니다.');");
	 	out.println("location.href='loginForm.jsp';");
	 	out.println("</script>");
	 }
	request.setCharacterEncoding("utf-8");
	
	String myimg=request.getParameter("myimg");
	String title=request.getParameter("title");
	request.setAttribute("title", title);
	String author=request.getParameter("author");
	String publisher=request.getParameter("publisher");
	int cost=Integer.parseInt(request.getParameter("cost"));
	int count=Integer.parseInt(request.getParameter("count"));

	try {
	    String dbURL = "jdbc:mysql://localhost:3306/book?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";
	    String dbID = "root";
	    String dbPW="1234";
	   	
	    Class.forName("com.mysql.jdbc.Driver").newInstance();
	   	Connection con = DriverManager.getConnection(dbURL, dbID, dbPW);
	   	
	   	PreparedStatement pstmt=null;   	
	   	pstmt = con.prepareStatement("select * from cart where user_id=?");
	   	pstmt.setString(1,userID);
	   	
	   	Boolean check=true;
	    
	    ResultSet rs = pstmt.executeQuery(); 
	    while(rs.next()){
			if(myimg.equals(rs.getString("image"))){
				check=false;
				pstmt=con.prepareStatement("update cart set count=? where user_id=? AND image=?");
				pstmt.setInt(1,count);
				pstmt.setString(2,userID);
				pstmt.setString(3,myimg);
				break;
			}
			else{
				check=true;
			}
	   }
	    if(check){			   	
				pstmt = con.prepareStatement("insert into cart values(?,?,?,?,?,?,?)");
			   	pstmt.setString(1,userID);
			   	pstmt.setString(2,myimg);
			   	pstmt.setString(3,title);
			   	pstmt.setString(4,author);
			   	pstmt.setString(5,publisher);
			   	pstmt.setInt(6,cost);
			   	pstmt.setInt(7,count);
	    }
	   	pstmt.executeUpdate();
	   	
	   	rs.close();
	   	pstmt.close();
	   	con.close();
	   	
	   	response.sendRedirect("order.jsp?part=only");
	   	//pageContext.forward("order.jsp?part=only");
	   	out.println("연동성동!");
	   	
	} catch (Exception e) {       
		/* out.println("<script>");
		out.println("history.back();");
		out.println("</script>");
	    System.out.println("DB 연동 실패 " + e.getMessage()); */
	    out.println(e.getMessage());
	    }
 %>
 </body>
</html>