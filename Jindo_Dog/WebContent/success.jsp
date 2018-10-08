<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.10.0.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<style>
* {
	margin: 0px;
	padding: 0px;
}

#context {
	/*       margin-left : 100px; */
	width: 1000px;
	height: 500px;
	position: relative;
	text-align: center;
}

#su1, #su2 {
	width: 500px;
	height: 500px;
	opacity: 0.5 !important;
	float: left;
}

#score {
	position: absolute;
	z-index: 1;
	left: 250px;
	font-size: 30px;
	top: 50px;
}

#su2 {
	left: 500px;
}

input[type="button"] {
	position: absolute;
	width: 150px;
	height: 80px;
	background-color: black;
	color: white;
	border: none;
	font-size: 25px;
	top: 250px;
}

input[type="button"]:hover {
	cursor: pointer;
	background-color: #999;
}

#restart {
	left: 300px;
}

#goMain {
	left: 550px;
}

#conWrap {
	width: 1000px;
	position: relative;
	margin: 0 auto;
}

#linkWrap {
	position: absolute;
	top: 360px;
	left: 380px;
}
</style>
</head>
<body>
	<jsp:include page="navigation.jsp"></jsp:include>
	<div id="conWrap">
		<div id="context">
			<div id="score">
				<h1>
					MISSION CELAR <br>${param.score}점입니다.</h1>
			</div>
			<img src="images/success.jpg" id="su1"> <img
				src="images/success2.jpg" id="su2"> <input type="button"
				id="restart" value="다시하기"> <input type="button" id="goMain"
				value="메인으로">
				
			<div id="linkWrap">
				<h2 style="color: red">간첩 리스트 전송하기</h2>
				<a id="kakao-link-btn" href="javascript:sendLink()"> <img
					src="//developers.kakao.com/assets/img/about/logos/kakaolink/kakaolink_btn_medium.png" />
				</a>
			</div>
			
			<form name="paging">
				<input type="hidden" name="spyJson">
			</form>

		</div>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
<script>
	var spyJson = ${param.spyJson} //json객체 배열 그대로 받아옴.
	var spyList = []; // 스파이 이름을 저장할 배열
	
	$(document).ready(function(){
		
		console.log(spyJson);
		// 아래와같은 형태로 사용. spyCode=간첩코드,name=간첩이름,[]=배열번호 아래코드는 마지막 간첩 출력
		// alert(spyJson[spyJson.length-1].spyCode+" : "+spyJson[spyJson.length-1].name); 
		
		for(var i=0; i<spyJson.length; i++){
			spyList.push(spyJson[i].name);
		}
		
		$('#goMain').on('click', function(){
			location.href = 'index.jsp';
		});
		$('#restart').on('click', function(){
			location.href = 'detectGame.jsp';
		});
	});
	
	function searchSpy(){
		jsonSubmit();
	}
	
	function jsonSubmit(){
        var f=document.paging; //폼 name
        f.spyJson.value = JSON.stringify(spyJson);//spyArr배열을 json으로 변경하여 저장
        f.action = 'searchSpy.jsp';//이동할 페이지
        f.method = 'post';//POST방식
        f.submit();
    }
	
	//// 리스트 전송 코드
	// 사용할 앱의 JavaScript 키를 설정해 주세요.
	Kakao.init('1ea997909a92b901e801433aa9b49158');
	
	function sendLink() {
		var url = 'http://www.nis.go.kr/main.do';
	
		Kakao.Link.sendDefault({
			objectType : 'text',
			text : '▶ 간첩 리스트 ◀\n\n'+ spyList.toString(), // 간첩리스트 작성
			
			link : {
				mobileWebUrl : url,
				webUrl : url
				},
			buttons : [
			{
				title : '신고하고 포상금 받기',
				link : {
					mobileWebUrl : url,
					webUrl : url
				}
			}
		]
	});
}
</script>
</html>