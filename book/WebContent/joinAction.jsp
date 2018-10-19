<%@page import="java.util.Calendar"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String id=request.getParameter("user_id");
String pw=request.getParameter("user_pw");
String name=request.getParameter("name");

String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");

String birth = year+"-"+month+"-"+day;
out.println("birth");


String email1=request.getParameter("email1");
String email2=request.getParameter("email2");
String address=request.getParameter("address");

String email=email1+'@'+email2;

Calendar calendar = Calendar.getInstance();
int y = calendar.get(Calendar.YEAR); //년도를 구한다
int m = calendar.get(Calendar.MONTH) + 1; //달을 구한다
int d = calendar.get(Calendar.DATE); //날짜를 구한다

String date=y+"년"+m+"월"+d+"일";

try {
    String dbURL = "jdbc:mysql://localhost:3306/book?serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";
    String dbID = "root";
    String dbPW ="1234";

    Class.forName("com.mysql.jdbc.Driver").newInstance();
    Connection con = DriverManager.getConnection(dbURL, dbID, dbPW);
    
    PreparedStatement pstmt=null; 
    pstmt=con.prepareStatement("INSERT INTO member VALUES (?,?,?,?,?,?,?)");
    pstmt.setString(1,id);
   	pstmt.setString(2,pw);
   	pstmt.setString(3,name);
   	pstmt.setString(4,birth);
   	pstmt.setString(5,email);
   	pstmt.setString(6,address);
   	pstmt.setString(7,date);
   	
   	pstmt.executeUpdate();
    
   	pstmt.close();
    con.close();
    
    // 회원가입에 성공하였으면 로그인페이지로 보낸다
    out.println("<script>");
	out.println("location.href='loginForm.jsp';");
	out.println("alert('회원가입을 축하드립니다.');");
	out.println("</script>");   
    
} catch (Exception e) {%>   
	<script>alert('아이디 중복을 확인 해주세요!');</script>
<%	response.sendRedirect("join2.jsp");
    System.out.println("DB 연동 실패 " + e.getMessage());
} 
%>