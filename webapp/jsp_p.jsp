<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="db.DBConnect"%>
<%@ page import = "java.sql.*" %>
 <%
 	  request.setCharacterEncoding("UTF-8"); //오라클에 한글 입력시 깨지지 않음
      String sql = "insert into member_tbl_02 values (?,?,?,?,?,?,? )";
      
      Connection conn = DBConnect.getConnection();
      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setInt(1, Integer.parseInt(request.getParameter("custno")));
      //웹브라우저에서 불러오는 데이터는 문자열형식으로 인식되므로, 
      //숫자데이터인  경우 형변환 Integer.parseInt() 이 필요하다.
    pstmt.setString(2, request.getParameter("custname"));
	pstmt.setString(3, request.getParameter("phone"));
	pstmt.setString(4, request.getParameter("address"));
	pstmt.setString(5, request.getParameter("joindate"));
	pstmt.setString(6, request.getParameter("grade"));
	pstmt.setString(7, request.getParameter("city"));
	
	pstmt.executeUpdate();
 %>           
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쇼핑몰 회원등록</title>
</head>
<body>
<jsp:forward page="index.jsp"></jsp:forward>
<!-- 데이터입력 수행 완료 후 index 페이지로 이동 -->
</body>
</html>