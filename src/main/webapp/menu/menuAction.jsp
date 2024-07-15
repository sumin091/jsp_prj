<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  
<%!
String url="jdbc:oracle:thin:@localhost:1521:orcl";
String id="scott";
String pass="tiger";
String updateMenu=" update title_bar set sub_title=? where title=? ";
%>

<meta http-equiv="Content-Type" content="text/html; charset-UTF-8">
<title>Menu action</title>
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
<input type="button" value="동적테이블"/>
	 
	<%
	request.setCharacterEncoding("UTF-8");
	String title = request.getParameter("문의");	//name 속성의 값
	String sub_title = request.getParameter("고객센터");
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	try {
		
		Class.forName("oracle.jdbc.OracleDriver");
		con = DriverManager.getConnection(url, id, pass);
		
		pstmt=con.prepareStatement("updateMenu");
		
		rs=pstmt.executeQuery();
		
		if(rs.next()){
			out.println("성공");
		}else{
			out.println("실패");
		}
	}catch(SQLException e){
		e.printStackTrace();
	}finally{
		try{
			if(rs != null){rs.close();}
			if(pstmt != null){pstmt.close();}
			if(con != null){con.close();}
			
		}catch(SQLException e){
			e.printStackTrace();
		}
		
	}
	
	%>

	<input type="text" value="변경값" name="change" />
	<input type="button" value="변경" name="chgBtn" />
	
</body>
</html>