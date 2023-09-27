# Shoppingmall
쇼핑몰 회원가입 페이지 만들기
# DB연결
DB에 접속하기 위해 디비 연결문을 작성한다.
``` javascript
package db;
import java.sql.*;
public class DBConnect {
	public static Connection getConnection() {

		Connection conn = null;

		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String id = "system";
		String pw = "1234";
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			conn = DriverManager.getConnection(url,id,pw);
			System.out.println("dd");
		}catch (Exception e){
			e.printStackTrace();
		}
		return conn;
	}
}
```
---
# 회원등록 
![image](https://github.com/leeyongha2006/Shoppingmall/assets/126844590/95e87b23-d82d-4675-a0f7-5dd1e3569eb1)

```javascript
<%@ page import = "db.DBConnect" %>
<%@ page import = "java.sql.*" %>
<%
	String sql = "select max(custno) from member_tbl_02";
	//DB 연결 기능을 객체변수 conn 에 저장 -> 1.DB 연결
	Connection conn = DBConnect.getConnection();
	// sql변수에 저장되어 있는 문장이 쿼리문이 됨 -> 2. DB 연결 후 쿼리문이 생성
	// PreparedStatement <- 쿼리문l 형식으로 변환 해준다.
	PreparedStatement pstmt = conn.prepareStatement(sql);
	// 변수 pstmt에 저장되어 있는 SQL문을 실행하여 객체 변수 rs에 저장
	// 쿼리문 결과값을 받아온다.
	ResultSet rs = pstmt.executeQuery();
	// 기준이 되는 변수에 결과값이 저장되어 있는 경우 next()를 호출하여 마지막 값을 확인
	// 결과값이 없을 경우엔 실행 하지 않아도 됨.
	rs.next();
	int num = rs.getInt(1) + 1;
%>
```
회원번호 자동 발행을 위한 쿼리문을 실행하는 코드로, 가장 최근에 발행된 회원정보를 불러와 1을 더하여 회원번호를 발행한다
```javascript
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
	alert("회원등록이 완료 되었습니다")
	return true;
}
</script>
```
사용자가 입력한 데이터가 유효한지 확인하는 코드로 value 값을 통하여 유효성을 확인한다

# 회원 정보 삽입
``` javascrip
<%@ page import="db.DBConnect"%>
<%@ page import = "java.sql.*" %>
 <%
 	  request.setCharacterEncoding("UTF-8"); //오라클에 한글 입력시 깨지지 않음
      String sql = "insert into member_tbl_02 values (?,?,?,?,?,?,? )";
      
      Connection conn = DBConnect.getConnection();
      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setInt(1, Integer.parseInt(request.getParameter("custno")));
      //웹브라우저에서 불러오는 데이터는 문자열형식으로 인식되므로, 
      //숫자데이터인  경우 형변환 *Integer.parseInt() 이 필요하다.
    pstmt.setString(2, request.getParameter("custname"));
	pstmt.setString(3, request.getParameter("phone"));
	pstmt.setString(4, request.getParameter("address"));
	pstmt.setString(5, request.getParameter("joindate"));
	pstmt.setString(6, request.getParameter("grade"));
	pstmt.setString(7, request.getParameter("city"));
	
	pstmt.executeUpdate();
 %>
```
사용자가 입력한 데이터를 request라는 객체에 보내어 데이터베이스에 회원정보 삽입하고 데이터를 저장한 후 
``` javascript
<jsp:forward page="index.jsp"></jsp:forward>
```
index페이지로 이동한다

# 회원 목록 조회
![image](https://github.com/leeyongha2006/Shoppingmall/assets/126844590/4c7e9d38-24bb-4a96-97f7-bcb1f101b1c9)

``` java
<%@ page import="db.DBConnect"%>
<%@ page import="java.sql.*"%>
<%
String sql = "select custno, custname, phone, address, to_char(joindate, 'yyyy-mm-dd') AS joindate, "
		+ " case when grade = 'A' then 'VIP' when grade = 'B' then '일반' else '직원' end AS grade, city"
		+ " from member_tbl_02 order by custno";

Connection conn = DBConnect.getConnection();
PreparedStatement ps = conn.prepareStatement(sql);
ResultSet rs = ps.executeQuery();
%>
```
먼저 데이터베이스에 있는 회원의 정보를 불러온다
``` java
<table class=table_line>
			<tr>
				<th>회원번호</th>
				<th>회원성명</th>
				<th>전화번호</th>
				<th>주소</th>
				<th>가입일자</th>
				<th>고객등급</th>
				<th>거주지역</th>
			</tr>
			<%
			while(rs.next()) {

			%>
			<tr class = "center">
				<td><%=rs.getString("custno")%></td>
				<td><%=rs.getString("custname")%></td>
				<td><%=rs.getString("phone")%></td>
				<td><%=rs.getString("address")%></td>
				<td><%=rs.getString("joindate")%></td>
				<td><%=rs.getString("grade")%></td>
				<td><%=rs.getString("city")%></td>
			</tr>
			<%}%>
		</table>
```
회원 목록을 표시할 테이블을 생성하고 while문을 사용하여 회원의 데이터를 가져온다

# 회원정보 조회
![image](https://github.com/leeyongha2006/Shoppingmall/assets/126844590/b671b71e-e52f-4af5-8dc1-43d5d97d8563)

``` javascript
<script type="text/javascript">
	function checkValue2() {
		if (!document.data1.in_custno.value) {
			alert("회원정보를 입력하세요");

			return false;
		}
		return true;

	}
</script>
```
회원정보를 입력하지 않았을때 알림창을 띄운다
``` java
<form name="data1" action="./member_search_list.jsp" method="post"	onsubmit="return checkValue2()">
			<table class="table_line">
				<tr>
					<th>회원 번호</th>
					<td><input type="text" name="in_custno" size="10"></td>
				</tr>
				<tr>
					<td colspan="2" align="center"><input type="button" value="취소"
						onclick="location.href='member_list.jsp'"> <input
						type="submit" value="조회">
				</tr>
			</table>
		</form>
```

``` java
int custno1 = Integer.parseInt(request.getParameter("in_custno"));
Connection conn = DBConnect.getConnection();
String sql = "select custno, custname, phone, address, " + " to_char(joindate, 'yyyy-mm-dd') as joindate, "
		+ " case when grade = 'A' then 'VIP' when grade = 'B' then '일반' else '직원' end as grade, city "
		+ " from member_tbl_02 " + " where custno = ?";

PreparedStatement ps = conn.prepareStatement(sql);
ps.setInt(1, custno1);

ResultSet rs = ps.executeQuery();
```
조회 버튼을 눌렀을 때 위의 쿼리문이 실행된다. custno1 이라는 변수 안에 회원 번호를 저장하고 rs 변수안엔 회원 정보를 저장한다

### 회원정보가 존재한다면
![image](https://github.com/leeyongha2006/Shoppingmall/assets/126844590/0e229804-33e9-4b03-9879-48d9f05ba3ac)
``` javascript
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
```
데이터베이스를 통하여 회원 번호와 정보를 테이블에 표시한다

### 회원번호가 존재 하지 않는다면 
![image](https://github.com/leeyongha2006/Shoppingmall/assets/126844590/729aeab2-7c02-4350-ba7a-42094c9a0bad)
``` javascript
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
```
회원 정보가 없다는 글이 표시되고 다시 조회 버튼을 눌러 다시 조회해야 한다\

# 회원매출조회
![image](https://github.com/leeyongha2006/Shoppingmall/assets/126844590/954abf22-d778-4e75-a0a4-28f3783f2ebf)

``` javascript
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
```
price에 값이 있는 회원 정보만 조회하는 sql문을 작성하고 총합을 저장할 변수 total을 생성하였다
``` javascript
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
                <td><%= total %></td>
            </tr>
        </table>
```
while문을 사용하여 테이블 안에다가 조회된 회원 정보를 출력한 뒤 total에 price의 총합을 저장하고 출력한다

# 회원정보 수정
``` javascript
<%
request.setCharacterEncoding("UTF-8"); //오라클에 한글 입력시 깨지지 않음
String sql = "update MEMBER_TBL_02 set custname = ?, phone = ?," + " address = ?, joindate = ?, grade = ?,"
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
```
``` javascript
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
```
사용자가 수정 버튼을 입력했을 때,  request.getParameter에 있는 값을 표시하는 쿼리문을 작성한다

# 회원정보 삭제
``` java
<%
request.setCharacterEncoding("UTF-8");

int d_custno = Integer.parseInt(request.getParameter("d_custno"));
String sql = "delete from member_tbl_02 where custno = " + d_custno;

Connection conn = DBConnect.getConnection();
PreparedStatement ps = conn.prepareStatement(sql);
ps.executeUpdate();
%>
```


