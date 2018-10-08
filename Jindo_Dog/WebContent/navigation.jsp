<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
* {
	padding: 0px;
	margin: 0px;
}

#wrap {
	margin: 0 auto;
	margin-top: 5px;
	border-top: 2px solid black;
	width: 1000px;
}

#title {
	margin: 20px 20px 5px;
	padding-bottom: 20px;
}

#menu {
	height: 50px;
	background-color: black;
	margin-bottm: 5px;
}

#menuUl li {
	width: 150px;
	height: 35px;
	float: left;
	list-style: none;
	text-align: center;
	padding-top: 15px;
}

#menuUl li:nth-child(4) {
	width: 180px;
}

#menuUl li a {
	color: white;
	padding: 50px 20px;
	text-decoration: none;
}

#menuUl li:hover {
	background-color: #8e8e8e;
	cursor: pointer;
}

#divideLine {
	border-top: 2px solid black;
	margin-top: 10px;
}

#menuUl #login, #menuUl #logout {
	float: right;
	margin-right: 50px;
}
</style>
<jsp:include page="loginScripts.jsp" />
<script>
	$(function() {
		displayLogin();
	});
	function displayLogin() {
		if (__isLogin()) {
			$("#login").hide();
			$("#logout").show();
		} else {
			$("#login").show();
			$("#logout").hide();
		}
	}
	function logout() {
		__logout(function() {
			alert("로그아웃 성공!");
			location.href = JD_CTX + '/login.jsp';
		});
	}
</script>
</head>
<body>
	<div id="wrap">
		<h1 id="title">진돗개 project</h1>
		<div id="menu">
			<ul id="menuUl">
				<li><a href="index.jsp">메인</a></li>
				<li><a href="dictionary.jsp">우리말사전</a></li>
				<li><a href="dictionary2.jsp">남북한사전</a></li>
				<li><a href="searchSpy.jsp">간첩 위치 조회</a></li>
				<li id="login" style="display: none"><a
					href="<c:url value="login.jsp"/>">로그인</a></li>
				<li id="logout" style="display: none"><a
					href="javascript:logout()">로그아웃</a></li>
			</ul>
		</div>
		<div id="divideLine"></div>
	</div>
	
</body>
</html>