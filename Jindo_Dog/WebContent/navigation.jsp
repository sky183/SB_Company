<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	#login{
		float : right;
		margin-right : 50px;
	}
</style>
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
			<li id = "login"><a href = "">로그인</a></li>
		</ul>
	</div>
</div>
</body>
</html>