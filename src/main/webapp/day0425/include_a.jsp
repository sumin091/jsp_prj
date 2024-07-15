<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="외부 JSP"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<jsp:include page="common_external.jsp"/>


<style type="text/css">
	
</style>
<script type="text/javascript">
	$(function(){
		
	});//ready
</script>
</head>
<body>
<div>
	외부JSP
	<div>
	<!-- 액션태그 (표준액션) -->
	<jsp:include page="include_b.jsp"/>
	<%-- 액션태그를 사용하면 변수, method의 공유가 불가하다. <%= msg %> --%>
	</div>
	외부JSP
	<div>
	
	</div>
</div>