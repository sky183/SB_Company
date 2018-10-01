<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	* {
		padding : 0px;
		margin : 0px;
	}
	
	#title {
		margin : 20px 20px 5px;
		padding-bottom : 20px;
	}
	#menu{
		height : 50px;
		background-color : black;
	}
	ul li {
		width : 100px;
		height : 40px;
		float : left;
		list-style: none;
		text-align : center;
		margin-top: 10px;
	}
	ul li a {
		color : white;
		margin : 10px 20px;
		text-decoration : none;
	}
	#login,#logout{
		float : right;
		margin-right : 50px;
	}
</style>
<jsp:include page="loginScripts.jsp"/>
<%-- <jsp:include page="loginScripts.jsp"/>	 --%>
<%-- 	<jsp:param name="checkYn" value="Y" /> 로그인 체크가 필요한경우 추가 --%>
<%-- </jsp:include> --%>
<script>
$(function(){
	displayLogin();
});
function displayLogin(){
	if(__isLogin()){
		$("#login").hide();
		$("#logout").show();
	}else{
		$("#login").show();
		$("#logout").hide();
	}
}
function logout(){
	__logout(function(){
		alert("로그아웃 성공!");
		location.href = JD_CTX + 'login.jsp';		
	});
}
</script>
</head>
<body>
<div id = "wrap">
	<h1 id = "title">진돗개 project</h1>
	<div id = "menu">
		<ul>
			<li><a href = "">메인</a></li>
			<li><a href = "">메인</a></li>
			<li><a href = "">메인</a></li>
			<li><a href = "">메인</a></li>
			<li id ="login" style="display:none;"><a href="<c:url value="login.jsp"/>">로그인</a></li>
			<li id ="logout" style="display:none;"><a href="javascript:logout()">로그아웃</a></li>
		</ul>
	</div>
</div>
</body>
</html>