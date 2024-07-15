<%@page import="java.sql.Statement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%!//선언: 드라이버로딩과 쿼리생성객체얻기를 선언부 안에서
Connection con=null;
PreparedStatement pstmt=null;
ResultSet rs=null;

String url="jdbc:oracle:thin:@localhost:1521:orcl";
String id="scott";
String pass="tiger";
String selectMenu = " select * from title_bar ";
%>
<meta http-equiv="Content-Type" content="text/html; charset-UTF-8">
<title>웹페이지 테스트</title>
<link rel="icon" href="http://192.168.10.225/jsp_prj/common/favicon.ico"/>
<!--bootstrap 시작-->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!--bootstrap 끝-->
<link rel="stylesheet" href="http://192.168.10.225/jsp_prj/common/css/main.css" type="text/css" media="all" />
<link rel="stylesheet" href="http://192.168.10.225/jsp_prj/common/css/board.css" type="text/css" media="all" />

<!--jQuery CDN 시작-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!--jQuery CDN 끝-->

<style type="text/css">
	tr,td,table{border: 1px solid #333;}
</style>
<script type="text/javascript">
	$(function(){
		/* $("#show").click(){
			$("#output").html();
		} */
		
		
	});//ready
	
	
</script>
</head>
<body>

	<h3>테이블 조회</h3>
	<form method="post" action="menu.jsp">
		  
		<!--   
		<label for="title">제목</label>
		<input type="text" id="title" name="title"/>
		<br>
		<label for="sub_title">서브제목</label>
		<input type="text" id="sub_title" name="sub_title"/>
		<br>
		<!--  <input type="submit" value="menu"/>
		-->
	
		
		<!--  <input type="button" value="확인" id="show"/>  -->
		
		 	<table>  
				<tr>
					<th>title</th>
					<th>sub_title</th>
				</tr>
			
				<%
					try{
						Class.forName("oracle.jdbc.OracleDriver");
						con=DriverManager.getConnection(url,id,pass);
						pstmt=con.prepareStatement(selectMenu);
						
						rs=pstmt.executeQuery();
						
						while(rs.next()){
							out.println("<tr>");
							out.println("<td>"+ rs.getString("title") +"</td>");
							out.println("<td>"+ rs.getString("sub_title") +"</td>");
							out.println("</tr>");
							out.println("<td></td>");
							out.println("</tr>");
						}
						
					}catch(SQLException e){
						e.printStackTrace();
					}finally{
						try{
							if(rs!= null){rs.close();}
							if(pstmt != null){pstmt.close();}
							if(con != null){con.close();}
						}catch(SQLException e){
							e.printStackTrace();
						}
					}
				
				%>
				
			</table>
			<a href="MenuUpdate.jsp">수정</a> 
			<!--  
			<input type="button" value="수정" id="update" name="update"/>
			<input type="button" value="삭제" id="delete" name="delete"/>
			-->
	</form>
		
	
</body>
</html>