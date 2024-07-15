<%@page import="java.util.ArrayList"%>
<%@page import="menu.MenuVO"%>
<%@page import="java.util.List"%>
<%@page import="menu.MenuDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
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
tr, td, table {border: 1px solid #333;}
</style>
<script type="text/javascript">
	$(function() {
		$("#updBtn").click(function()){
			update();
		}
	});//ready
	
	function update(title,sub_title){
		var title=update.title.value();
		var sub_title=update.sub_title.value(); 
	
	/*	
		//유효성 체크			
		if (title =="") {
			alert("제목을 입력해주세요");
			return;
		}
		if(sub_title == ""){
			alert("서브제목을 입력해주세요");
			return;
		}
	*/	
	}
	

</script>
</head>
<body>
	<div>
	<table>
			<tr>
				<th>title</th>
				<th>sub_title</th>
			</tr>
			<!--  
			title:<input type="text" value="title" id="title" name="title"/><br>
			sub_title:<input type="text" value="sub_title" id="sub_title" name="sub_title"/><br>
						
			<input type="button" value="수정" name="updBtn" id="updBtn"/>
			-->
	
			<%
			MenuDAO menuDAO= MenuDAO.getInstance();
			MenuVO menuVO= new MenuVO();
			List<MenuVO> list= new ArrayList<MenuVO>(); 
			list=menuDAO.selectAll();
			
			pageContext.setAttribute("list", list);
			
		    int id = Integer.parseInt(request.getParameter("id"));
		    String title = request.getParameter("title");
		    String sub_title = request.getParameter("sub_title");
			%>
			<c:forEach var="menu" items="${list}">
			<tr>
			<td><c:out value="${menu.title }"/></td>
			<td><c:out value="${menu.sub_title }"/></td>
			</tr>
			</c:forEach>
			
			
			
			
			
		</table>	
	</div>
		<a href="menu.jsp">뒤로</a>
</body>
</html>