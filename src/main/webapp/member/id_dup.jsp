<%@page import="java.sql.SQLException"%>
<%@page import="kr.co.sist.user.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 중복검사</title>
<!--bootstrap 시작-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!--bootstrap 끝-->

<!--sist스타일시트  -->
<link rel="stylesheet" href="https://www.sist.co.kr/css/main.css" type="text/css" media="all" />
<link rel="stylesheet" href="https://www.sist.co.kr/css/board.css" type="text/css" media="all" />

<style type="text/css">
#idWrap{width: 468px; height: 330px; margin: 0px auto}
#background{ width: 464px; height: 326px; background: #ffffff url(images/id_background.png) no-repeat; position: relative;}
#inputWrap{position:absolute; top:186px; left:103px;}
#dupResult{position:absolute; top:230px; left:103px;}
</style>
<script type="text/javascript">
window.onload=function(){
	document.getElementById("btn").addEventListener("click",idNullChk);//버튼클릭
	document.getElementById("id").addEventListener("keydown",isEnter);//버튼클릭
}

function isEnter(evt){
	if(evt.which == 13){
		idNullChk();
	}//end if
}//isEnter

function idNullChk(){
	var obj=document.subFrm;
	var id=obj.id.value;
	
	if(id.replace(/ /g,"") == ""){
		alert("중복 확인할 아이디를 입력해주세요");
		obj.id.value();
		obj.id.focus();
		return;
	}//end if
	obj.submit();
}//idNullChk

function sendId(id){
	//2.현재창에 입력된 id를 얻어와서 부모창(opener)에 전달
	//opener.window.document.frm.id.value=document.subFrm.id.value;
	opener.window.document.getElementById("id").value=id;
	//3.자식창을 닫기
	self.close();
}
</script>
</head>
<body id="idWrap">
<%
//웹 파라미터 받기
String id=request.getParameter("id");
boolean flag=false;
if(id != null /* && !"".equals(id) */){//parameter가 존재하면
	//DB에서 id를 검색한다.
	MemberDAO mDAO= MemberDAO.getInstance();

try{
	String returnId=mDAO.selectId(id);
	flag=!"".equals(returnId);//아이디가 존재하면 true 그렇지않으면 false
	pageContext.setAttribute("flag", flag);
//	log("--------------------id is--------------------"+flag);
	//System.out.println("0---------"+flag);
}catch(SQLException se){
		se.printStackTrace();
}//end if
}
%>
<div id="idWrap">
	<div id="background">
	<div id="inputWrap">
	<form name="subFrm">
	<!-- web browser에서 키입력이 가능한 HTML Form Control이 하나인 경우
	엔털를 치면 자동으로 submit 된다. (자바스크립트에서 유효정검증 실패시라도 submit이 된다.
	이것을 막기위해 키입력이 가능한 HTML Form Control을 하나더 정의하고 숨기면 웹브라우저에서는 
	키 입력이 가능한 폼컨트롤이 두개라고 판단해 enter키가 눌려도 submit하지 않음) -->
		<input type="text" name="id" id="id" value="${param.id}" class="inputTxt inputIdtype" />
		<input type="text" style="display: none"/>
		<input type="button" value="중복검사" id="btn" class="btn btn-success btn-sm" />
	</form>
	</div>
	
	<div id="dupResult">
	<c:if test="${not empty param.id }">
		입력하신[<strong style="font-size:22px"><c:out value="${param.id }"/></strong>] 는
		<c:choose>
		<c:when test="${pageScope.flag }">
		사용 <strong style="color:#E53E30"> 불가능</strong> 합니다.
		</c:when>
		<c:otherwise>
		사용 <strong style="color:#2B7BED">가능</strong>합니다. <a href="#void" onclick="sendId('${param.id}')" >사용</a>
		</c:otherwise>
		</c:choose>
		
	</c:if>
	
	</div>
	<div id="dupResult">
	<%
	
	%>
	</div>
	</div>
</div>	
</body>
</html>