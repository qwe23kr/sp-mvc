<%@page import="DBPKG.Connector"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String rPath = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원목록조회/수정</title>
<style>
* {
	margin: auto 0;
	padding: 0;
}

ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
}

li {
	margin: 15px;
	float: left;
}
table{
    width: 800px;
    
    margin-left: auto;
    margin-right: auto;
}
section {
	clear: both;
	height: 650px;
	background-color: skyblue;
}

header {
	text-align: center;
	background-color: blue;
}

footer {
	bottom: 0px;
	text-align: center;
	background-color: purple;
}

h3 {
	text-align: center;
}
</style>
</head>
<body>
	<header> 쇼핑몰회원관리 ver 1.0 </header>

	<nav>
		<ul>
			<li><a href="<%=rPath%>/member-insert.jsp">회원등록</a></li>
			<li><a href="<%=rPath%>/member-list.jsp">회원목록조회/수정</a></li>
			<li><a href="<%=rPath%>/member-sales.jsp">회원매출조회</a></li>
			<li><a href="<%=rPath%>/">홈으로</a></li>

		</ul>
	</nav>
	<section>
		<h3>회원목록조회/수정</h3>
		<%
		Connection con = Connector.getConnection();
		String sql = "select met.custname, met.grade ,mot.CUSTNO,sum(mot.price) as PRICE from money_tbl_02 mot ,member_tbl_02 met"
				+" where mot.custno=met.custno"
				+" group by met.custname,met.grade,mot.custno"
				+" order by price desc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		%>
		<table border="1">
		<tr>
		<th>회원번호</th>
		<th>회원성명</th>
		<th>고객등급</th>
		<th>매출</th>
		
		</tr>
		<%
		while(rs.next()){
			%>	<tr>
		<th><%=rs.getInt("custno")%></th>
		<th><%=rs.getString("custname")%></th>
		<th><%=rs.getString("grade")%></th>
		<th><%=rs.getString("price")%></th>
		
		</tr>
			<%
		}
		
		
		%>
		</table>
		
	</section>
	<footer> 저작권무적권 </footer>
</body>
</html>