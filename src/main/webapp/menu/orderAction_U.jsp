<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="http://192.168.10.225/jsp_prj/common/favicon.ico" />
<!--bootstrap 시작-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<!--bootstrap 끝-->
<link rel="stylesheet"
	href="http://192.168.10.225/jsp_prj/common/css/main.css"
	type="text/css" media="all" />
<link rel="stylesheet"
	href="http://192.168.10.225/jsp_prj/common/css/board.css"
	type="text/css" media="all" />

<!--jQuery CDN 시작-->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!--jQuery CDN 끝-->

<style type="text/css">
</style>
<script type="text/javascript">
	$(function() {

	});//ready
</script>
</head>
<body>


	<%
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String id = "scott";
	String pass = "tiger";

	Connection con = null;
	PreparedStatement pstmt = null;

	try {
		Class.forName("oracle.jdbc.OracleDriver");
		con = DriverManager.getConnection(url, id, pass);

		String updateMenu = " update title_bar set title=? where sub_title=? ";

		pstmt = con.prepareStatement(updateMenu);
		
		pstmt.setString(1, "title");
		pstmt.setString(2, "sub_title");

		pstmt.executeUpdate();
		
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		if(pstmt != null){pstmt.close();}
		if(con != null){con.close();}
	}
	%>

</body>
</html>