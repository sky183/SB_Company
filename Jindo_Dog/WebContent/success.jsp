<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script src="https://code.jquery.com/jquery-1.10.0.js"></script>
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
/*       margin-left : 100px; */
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
   
   input[type="button"]:hover{
   cursor:pointer;
   background-color : #999;
   }
   
   #restart {
      left : 300px;
   }
   #goMain {
      left : 550px;
   }
   
      #conWrap {
      width: 1000px;
      position: relative;
      margin: 0 auto;
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
		var spyJson = ${param.spyJson} //json객체 그대로 받아옴.
		// 아래와같은 형태로 사용. spyCode=간첩코드,name=간첩이름,[]=배열번호 아래코드는 마지막 간첩 출력
		alert(spyJson[spyJson.length-1].spyCode+" : "+spyJson[spyJson.length-1].name); 
		$('#goMain').on('click', function(){
			location.href('main.jsp');
		});
		$('#restart').on('click', function(){
			location.href = 'detectGame.jsp';
		
		});
	});
</script>
</html>