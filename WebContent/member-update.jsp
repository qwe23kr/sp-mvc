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
<title>회원목록수정</title>
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

table {
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

a:link { //링크걸때 밑줄사라지게 하는 태그 text-decoration:none;
	
}

a:visited {
	text-decoration: none;
}

a:hover {
	text-decoration: underline;
}

a:active {
	text-decoration: underline;
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
		<h3>회원정보수정</h3>
		<%
			request.setCharacterEncoding("utf-8");

		if (request.getParameter("custname") != null) {
			String custno = request.getParameter("custno");
			String custname = request.getParameter("custname");
			String phone = request.getParameter("phone");
			String address = request.getParameter("address");
			String joindate = request.getParameter("joindate");
			String grade = request.getParameter("grade");
			String city = request.getParameter("city");
			String sql = "update member_tbl_02" 
					+" set custname=?,"
							+"phone=?,"
									+"address=?,"
									+"joindate=?,"
									+"grade=?,"
									+"city=?"
									+"where custno=?";
			Connection con = Connector.getConnection();
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, custname);
			ps.setString(2, phone);
			ps.setString(3, address);
			ps.setString(4, joindate);
			ps.setString(5, grade);
			ps.setString(6, city);
			ps.setString(7,custno);

			int result = ps.executeUpdate();

			if (result == 1) {
				out.write("<script>");
				out.write("alert('회원 수정이 완료 되었습니다ㅣ!')");
				out.write("</script>");

			}

		}
		Connection con = Connector.getConnection();
		String sql = "select custno,custname,phone,address,to_char(joindate,'YYYY-MM-DD') AS JOINDATE," + " grade"
				+ " ,city from member_tbl_02 where custno=?";
		PreparedStatement ps = con.prepareStatement(sql);
		String custno = request.getParameter("custno");
		ps.setString(1, custno);
		ResultSet rs = ps.executeQuery();
		String custname = "";
		String phone = "";
		String address = "";
		String joindate = "";
		String grade = "";
		String city = "";

		if (rs.next()) {
			custname = rs.getString("custname");
			phone = rs.getString("phone");
			address = rs.getString("address");
			joindate = rs.getString("joindate");
			grade = rs.getString("grade");
			city = rs.getString("city");

		}
		%>

		<form method="post">

			<table border=1>
				<tr>
					<td colspan="2" align=center bgcolor="pink"><b><font
							size=5>홈쇼핑 회원등록</font></b></td>
				</tr>
				<tr>

					<td>회원번호(자동발행):</td>
					<td><input type="text" name="custno" value="<%=custno%>"></td>
				</tr>
				<tr>
					<td>회원성명:</td>
					<td><input type="text" name="custname" value="<%=custname%>"></td>
				</tr>
				<tr>
					<td>회원전화:</td>
					<td><input type="text" name="phone" value="<%=phone%>"></td>
				</tr>
				<tr>
					<td>회원주소:</td>
					<td><input type="text" name="address" value="<%=address%>"></td>
				</tr>
				<tr>
					<td>가입일자:</td>
					<td><input type="text" name="joindate" value="<%=joindate%>"></td>
				</tr>
				<tr>
					<td>고객등급[A:vip,B:일반,C:직원]:</td>
					<td><input type="text" name="grade" value="<%=grade%>"></td>
				</tr>
				<tr>
					<td>도시코드:</td>
					<td><input type="text" name="city" value="<%=city%>"></td>
				</tr>

				<tr>
					<td colspan="2">
						<button>수정</button>
						<button type="button"
							onclick="location.href='<%=rPath%>/member-list.jsp'">조회</button>

					</td>
				</tr>

			</table>

		</form>
	</section>
	<footer> 저작권무적권 </footer>
</body>
</html>