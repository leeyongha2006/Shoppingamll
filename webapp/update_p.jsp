<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="db.DBConnect"%>
<%@ page import="java.sql.*"%>
<%
 	 request.setCharacterEncoding("UTF-8"); //오라클에 한글 입력시 깨지지 않음
      String sql = "update MEMBER_TBL_02 set custname = ?, phone = ?,"
    				  + " address = ?, joindate = ?, grade = ?,"
    				  + " city = ? where custno = " + request.getParameter("custno"); 
 	 
      Connection conn = DBConnect.getConnection();

      PreparedStatement ps = conn.prepareStatement(sql);
      //웹브라우저에서 불러오는 데이터는 문자열형식으로 인식되므로, 
      //숫자데이터인  경우 형변환 Integer.parseInt() 이 필요하다.
    ps.setString(1, request.getParameter("custname"));
    ps.setString(2, request.getParameter("phone"));
    ps.setString(3, request.getParameter("address"));
    ps.setString(4, request.getParameter("joindate"));
    ps.setString(5, request.getParameter("grade"));
    ps.setString(6, request.getParameter("city"));
	ps.executeUpdate();
	
 %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:forward page="member_list.jsp"></jsp:forward>
</body>
</html>