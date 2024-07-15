<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="jsp:useBean 액션으로 web parameter 받기"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	
</style>
<script type="text/javascript">
	$(function(){
		
	});//ready
</script>
</head>
<body>
<div>
	<!-- 객체생성 -->
	<jsp:useBean id="memberVO" class="day0426.ParamVO" scope="page"/>
	<!-- 웹 파라미터 받아서 VO 객체에 설정 -->
	<jsp:setProperty property="*" name="memberVO"/>
 <%-- 	<%=memberVO %> --%>
 <h3>회원가입해주셔서 땡큐땡큐</h3>
 입력하신 정보는 아래 보기와 같습니다.<br>
 <ul>
 <li>아이디: <jsp:getProperty property="id" name="memberVO" />(  ${param.id})</li>
 <li>비밀번호: <jsp:getProperty property="password" name="memberVO" />(  ${param.password})</li>
 <li>이름: <jsp:getProperty property="name" name="memberVO" />(  ${param.name})</li>
 <li>전화번호: <jsp:getProperty property="tel" name="memberVO" />(  ${param.tel})</li>
 <li>휴대폰: <jsp:getProperty property="cell" name="memberVO" />(  ${param.cell})</li>
 <li>수신: <jsp:getProperty property="issms" name="memberVO" />(  ${ empty param.issms ?"수신안함":"수신함" })
 <%=memberVO.getIssms()==null?"수신안함":"수신함" %>
 </li>
 <li>생년월일: <jsp:getProperty property="birthday" name="memberVO" />(  ${param.birthday})</li>
 <li>점심식사: <jsp:getProperty property="lunch" name="memberVO" />(  ${param.lunch}, ${ paramValues.lunch[0]})
 	<br>
 	<%
 	String[] lunch=memberVO.getLunch();
 	if(lunch==null){
 	%>
 	다이어트 중?	
	<% 		
 	}else{
 		int i=0;
 		for(String temp: lunch){
 			%><%= temp %>&nbsp;
 		<%-- 	(${paramValues.lunch[<%= i %>] })  --%>
 			<% 
 		}//end for
 	}//else
 	%>
 	
 </li>
 </ul>
</div>
</body>
</html>