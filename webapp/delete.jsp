<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "db.DBConnect"%>

<%
request.setCharacterEncoding("UTF-8");

int d_custno = Integer.parseInt(request.getParameter("d_custno"));
String sql = "delete from member_tbl_02 where custno = " + d_custno;

Connection conn = DBConnect.getConnection();
PreparedStatement ps = conn.prepareStatement(sql);
ps.executeUpdate();
%>
<!DOCTYPE html>		
<html>
<head>	
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel = "stylesheet" href = "css/style.css">
</head>
<body>
<jsp:forward page="member_list.jsp"></jsp:forward>


</body>
</html>