<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "db.DBConnect" %>
<%@ page import = "java.sql.*" %>


    <%
        int total = 0;
        Connection conn = DBConnect.getConnection();
        
        String sql = "select a.custno, a.custname," + 
                     " case when grade = 'A' then 'VIP' when grade = 'B' then '일반' else '직원' end as grade," +
                     " sum(b.price)"+
                     " from member_tbl_02 a, money_tbl_02 b" +
                     " where a.custno = b.custno" +
                     " group by a.custno, a.custname, a.grade" +
                     " order by sum(b.price) desc";
                    
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
                
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sales_list</title>
<link rel = "stylesheet" type = "text/css" href = "css/style.css">
</head>
<body>
<header>
		<jsp:include page="layout/header.jsp"></jsp:include>
	</header>
	<nav>
		<jsp:include page="layout/nav.jsp"></jsp:include>
	</nav>
	<section class = "section">
    <h2> 회원 매출 조회 </h2>
        <table class = "table_line">
            <tr>
                <th>회원번호</th>
                <th>회원성명</th>
                <th>고객등급</th>
                <th>매출</th>
            </tr>
            <tr>
                <% while(rs.next()){ %>
                <td><%= rs.getString("custno") %></td>        
                <td><%= rs.getString("custname") %></td>        
                <td><%= rs.getString("grade") %></td>        
                <td><%= rs.getString("sum(b.price)") %></td>
                <% total += rs.getInt("sum(b.price)"); %>
            </tr> <%} %>
            
            <tr>
               	<th colspan="3">총합</th>	
                <td><%= total %></td>
            </tr>
        </table>
        
</section>
	<footer>
		<jsp:include page="layout/footer.jsp"></jsp:include>
	</footer>

</body>
</html>