<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<style>
	*{
		margin: 0px;
		padding: 0px;
	}

	#login{
		position : absolute;
		z-index : 1;
		bottom : 150px;
		left : 110px;
		border : 1px solid black;
	}
	
	#login:hover{
	 opacity: 0.5;
	}
	
	#kkoWrap{
		position : relative;
		width: 600px;
		margin: 0 auto;
	}
	
	#kakao{
		width: 500px;
	}
	
</style>
</head>
<body>
<div id = "kkoWrap">
	<a id="custom-login-btn" href="javascript:loginWithKakao()"> 
		<img src="//mud-kage.kakao.com/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg" width="300" id="login"/>
	</a>
	
	<img src="images/kakao.jpg" id = "kakao">

<!-- <a id="kakao-login-btn"></a>
<a href="http://developers.kakao.com/logout"></a>
<img src="images/kakao.jpg" id = "kakao"> -->

</div>

<script type='text/javascript'>
	var JD_CTX = '${pageContext.request.contextPath}';
	
	//사용할 앱의 JavaScript 키를 설정해 주세요.
	Kakao.init('1ea997909a92b901e801433aa9b49158');
	
	function loginWithKakao() {
		// 로그인 창을 띄웁니다.
		Kakao.Auth.login({
			success : function(data) {
				alert("로그인 성공!");
		    	location.href = JD_CTX + '/index.jsp';
			},
			fail : function(err) {
				alert(JSON.stringify(err));
			}
		});
	};
    
    //로그인 성공 판단
	function isLogin(){
		var result = false;
		if(Kakao.Auth.getAccessToken()){
			result = true;
		}
		return result;
	}

	//이미 로그인이 되어있다면 다시 네비게이션 페이지로 이동
	if(isLogin()){
		location.href = JD_CTX + '/index.jsp';
	}
</script>

</body>
</html>