<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>    
<%@ page import = "db.DBConnect" %>    
<%
String sql = "select * from member_tbl_02 where custno = " + request.getParameter("click_custno");
Connection conn = DBConnect.getConnection();
PreparedStatement ps = conn.prepareStatement(sql);
ResultSet rs = ps.executeQuery();
rs.next();
%>    
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel = "stylesheet" href = "css/style.css">
<title>update</title>
<script type="text/javascript">
function checkValue() {
	if(document.data.custname.value) {
		alert("회원성명이 입력 안됨");
		data.custname.focus();
		return false;
	}
	else if(document.data.phone.value) {
		alert("전화번호 입력 안됨");
		data.phone.focus();
		return false;
	}
	else if(document.data.adress.value) {
		alert("주소 입력 안됨");
		data.adress.focus();
		return false;
	}
	else if(document.data.joindata.value) {
		alert("가입일자 입력 안됨");
		data.joindata.focus();
		return false;
	}
	else if(document.grade.joindata.value) {
		alert("고객등급 입력 안됨");
		data.grade.focus();
		return false;
	}
	else if(document.data.city.value) {
		alert("도시코드 입력 안됨");
		data.city.focus();
		return false;
	}

}
	
	function checkDel(custno) {
	msg = "삭제하시겠습니까?"; // 삭제 여부 확인
	if(confirm(msg)!= 0) { 
		location.href="delete.jsp?d_custno="+custno;
		alert("삭제되었습니다");	
	}else {
		alert("삭제가 취소되었습니다")
		return;
	}
}

</script>
</head>
<body>
<body>
	<header>
		<jsp:include page="./layout/header.jsp"></jsp:include>
	</header>
	<nav>
		<jsp:include page="./layout/nav.jsp"></jsp:include>
	</nav>
	<section class = "section">
	<h2>홈쇼핑 회원 정보수정</h2><br>
	<form name = "u_data" action = "update_p.jsp" method = "post" onsubmit = "return checkValue()">
			<table class="table_line">
				<tr>
					<th>회원번호</th>
					<td><input type="text" name="custno" value="<%=rs.getString("custno") %>" readonly></td>
				</tr>
				<tr>
					<th>회원성명</th>
					<td><input type="text" name="custname" value="<%=rs.getString("custname") %>" ></td>
				</tr>
				<tr>
					<th>회원전화</th>
					<td><input type="text" name="phone" value="<%=rs.getString("phone") %>" ></td>
				</tr>
				<tr>
					<th>회원주소</th>
					<td><input type="text" name="address" value="<%=rs.getString("address") %>"></td>
				</tr>
				<tr>
					<th>가입일자</th>
					<td><input type="text" name="joindate" value=<%=rs.getString("joindate") %>></td>
				</tr>
				<tr>
					<th>고객등급[A:VIP,B:일반,C:직원]</th>
					<td><input type="text" name="grade"value="<%=rs.getString("grade") %>" ></td>
				</tr>
				<tr>
					<th>도시코드</th>
					<td><input type="text" name="city" value="<%=rs.getString("city") %>"></td>
				</tr>
				<tr class="center">
					<td colspan="2" align = "center">
						<input type="submit" value="수정">
						<input type="button" value="조회" onclick = "location.href='member_list.jsp'">
					<input type="button" value="삭제" onclick="checkDel(<%= rs.getString("custno")%>)">
				</tr>
			</table>
		</form>	

	</section>
	<footer>
		<jsp:include page="./layout/footer.jsp"></jsp:include>
	</footer>


</body>
</html>