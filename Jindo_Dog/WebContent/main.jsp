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
	/* 	margin-left : 100px; */
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
	#conTitle {
		position : absolute;
		z-index : 1;
		left : 230px;
		font-size : 30px;
		bottom : 20px;
	}
	#startImg2{
		left : 500px;
	}
	input[type="button"]{
		position : absolute;
		width : 200px;
		height : 100px;
		background-color : black;
		color : white;
		border : none;
		font-size : 40px;
		top : 200px;
	}
	#start {
		left : 400px;
	}
	
	#start:hover {
		cursor: pointer;
		background-color : #999;
	}
	
	#conWrap {
		width: 1000px;
		position: relative;
		margin: 0 auto;
	}
</style>
</head>
<body>
<jsp:include page="loginScripts.jsp"/>

<jsp:include page="navigation.jsp"></jsp:include>
<div id = "conWrap">
	<div id = "context">
		<img src = "images/start.jpg" id = "startImg1">
		<img src = "images/start2.JPG" id = "startImg2">
		<input type="button" id="start" value ="START">
		<div id = "conTitle"><h1>간첩신고는 국번없이<br> 111, 113</h1></div>	
	</div>
</div>
<jsp:include page="footer.jsp"></jsp:include>
</body>
<script>

	$(document).ready(function(){

		$('#start').on('click', function(){
			location.href = 'detectGame.jsp';
		});	
	});

</script>
</html>


