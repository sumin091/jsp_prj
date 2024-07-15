<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="day0510.RestaurantVO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="day0510.RestaurantDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
    info="식당조회"%>
<%
RestaurantDAO rDAO= RestaurantDAO.getInstance();
JSONObject jsonObj= new JSONObject();

try{
	SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss EEEE");
	
	List<RestaurantVO> list= rDAO.selectAllRestaurant();
	
	jsonObj.put("resultFlag",true);
	jsonObj.put("dataSize",list.size());
	jsonObj.put("pubDate", sdf.format(new Date()));
	
	JSONArray jsonArr= new JSONArray();
	JSONObject jsonTemp=null;
	
	SimpleDateFormat sdf2= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	for(RestaurantVO rVO : list){
		//조회값이 존재하면 JSONObject 생성하여 값을 넣고
		jsonTemp=new JSONObject();	//{} jsonObject 생성
		jsonTemp.put("name",rVO.getName()); //{name: ㅇㅅㅁ } 
		jsonTemp.put("menu",rVO.getMenu());
		jsonTemp.put("lat",rVO.getLat());
		jsonTemp.put("lng",rVO.getLng());
		jsonTemp.put("input_date",sdf2.format(rVO.getInput_date()));
		//json형태로 날짜를 가져올때 sdf를 사용하지 않으면 숫자로 인식
		
		//값을 가진 JSONObject를 JSONArray 추가
		jsonArr.add(jsonTemp);
	}//end for
	
	//모든 값을 가진 jsonArr를 JSONObject 추가
	jsonObj.put("data",jsonArr);
	
}catch(SQLException se){
	jsonObj.put("resultFlag",false);
	se.printStackTrace();
}
%>    
<%=jsonObj.toJSONString()%>