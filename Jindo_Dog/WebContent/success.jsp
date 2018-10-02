<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	* {
		margin : 0px;
		padding : 0px;
	}
	#context{
		margin-left : 100px;
		width : 1000px;
		height : 500px;
		position : relative;
		text-align : center;
	}
	img {
		width : 500px;
		height : 500px;
		opacity : 0.5!important;
		float : left;
	}
	#score {
		position : absolute;
		z-index : 1;
		left : 250px;
		font-size : 30px;
		top : 50px;
	}
	#su2{
		left : 500px;
	}
	input[type="button"]{
		position : absolute;
		width : 150px;
		height : 80px;
		background-color : black;
		color : white;
		border : none;
		font-size : 25px;
		top : 300px;
	}
	#restart {
		left : 300px;
	}
	#goMain {
		left : 550px;
	}
</style>
</head>
<body>
<jsp:include page="navigation.jsp"></jsp:include>
<div id = "conWrap">
	<div id = "context">
		<div id = "score"><h1>MISSION CELAR <br>${param.score}점입니다.</h1></div>	
		<img src = "images/success.jpg" id = "su1">
		<img src = "images/success2.jpg" id = "su2">
		<input type = "button" id = "restart" value = "다시하기">
		<input type = "button" id = "goMain" value = "메인으로">
	</div>
</div>
<jsp:include page="footer.jsp"></jsp:include>
</body>
<script>
	$(document).ready(function(){
		$('#goMain').on('click', function(){
			location.href('main.jsp');
		});
		$('#restart').on('click', function(){
			location.href = 'detectGame.jsp';
		});
	});
</script>
</html>