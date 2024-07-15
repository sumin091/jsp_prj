<%@page import="org.json.simple.JSONObject"%>
<%@page import="kr.co.sist.util.cipher.DataDecrypt"%>
<%@page import="kr.co.sist.user.member.WebMemberVO"%>
<%@page import="kr.co.sist.user.member.MemberDAO"%>
<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@ page language="java" contentType="application/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
    info="AJAX에서 보내오는 parameter 받기"%>
    <jsp:useBean id="lVO" class="kr.co.sist.user.member.LoginVO" scope="page"/>
    <jsp:setProperty name="lVO" property="*"/>
    
    <%
    lVO.setPass(DataEncrypt.messageDigest("MD5", lVO.getPass()));
	
    //JSONObject 생성
    JSONObject jsonObj= new JSONObject();

    jsonObj.put("result", false);

    MemberDAO mDAO = MemberDAO.getInstance();

    try {
    	WebMemberVO wmVO = mDAO.selectLogin(lVO);

    	//복호화 할 것인가?
    	if (wmVO != null) {//로그인 성공
    		//복호화
    		String key = "gdyb21LQTcIANtvYMT7QVQ==";
    		DataDecrypt dd = new DataDecrypt(key);

    		wmVO.setName(dd.decryption(wmVO.getName()));
    		wmVO.setEmail(dd.decryption(wmVO.getEmail()));
    		wmVO.setCell(dd.decryption(wmVO.getCell()));

    		//세션에 값 설정
    		session.setAttribute("loginData", wmVO);
			
    		jsonObj.put("result",true);
    		jsonObj.put("name",wmVO.getName());
    		jsonObj.put("email",wmVO.getEmail());
    	}
    } catch (Exception e) {

    	e.printStackTrace();
    }//end catch
    %>
    <%=jsonObj.toJSONString() %>
    
    
