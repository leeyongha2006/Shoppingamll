<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="db.DBConnect"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>

<%
int custno1 = Integer.parseInt(request.getParameter("in_custno"));
Connection conn = DBConnect.getConnection();
String sql = "select custno, custname, phone, address, " + " to_char(joindate, 'yyyy-mm-dd') as joindate, "
		+ " case when grade = 'A' then 'VIP' when grade = 'B' then '일반' else '직원' end as grade, city "
		+ " from member_tbl_02 " + " where custno = ?";

PreparedStatement ps = conn.prepareStatement(sql);
ps.setInt(1, custno1);

ResultSet rs = ps.executeQuery();
%>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/style.css">

</head>
<body>
	<header>
		<jsp:include page="layout/header.jsp"></jsp:include>
	</header>

	<nav>
		<jsp:include page="layout/nav.jsp"></jsp:include>
	</nav>

	<section class="section">
		<h2>회원 조회 결과</h2>
		<%
		if (rs.next()) {
		%>
		<table class="table_line">
			<tr>
				<th>회원번호</th>
				<th>회원성명</th>
				<th>전화번호</th>
				<th>주소</th>
				<th>가입일자</th>
				<th>고객등급</th>
				<th>거주지역</th>
			</tr>
			<tr>
				<td><%=rs.getString("custno")%></td>
				<td><%=rs.getString("custname")%></td>
				<td><%=rs.getString("phone")%></td>
				<td><%=rs.getString("address")%></td>
				<td><%=rs.getString("joindate")%></td>
				<td><%=rs.getString("grade")%></td>
				<td><%=rs.getString("city")%></td>

			</tr>
			<tr>
				<th colspan="7" align="center"><input type="button"
					onclick="location.href = 'index.jsp'" value=홈으로></th>
			</tr>
		</table>
		<%
		} else {
		%>
		<p align="center">
			회원번호
			<%=custno1%>의 회원 정보가 없습니다.
		</p>
		<br>
		<p align="center">
			<input type="button" onclick="location.href = 'member_search.jsp'"
				value=다시조회>
		</p>
		<%
		}
		%>

	</section>
	<footer>
		<jsp:include page="layout/footer.jsp"></jsp:include>
	</footer>
</body>
</html>