<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
</head>
<body>
<a id="kakao-login-btn"></a>
<a href="http://developers.kakao.com/logout"></a>
<script type='text/javascript'>
  //<![CDATA[
	//사용할 앱의 JavaScript 키를 설정해 주세요.
	Kakao.init('e1e4e3679a2a2a6dcab728b3a143332f');
    // 카카오 로그인 버튼을 생성합니다.
    Kakao.Auth.createLoginButton({
      container: '#kakao-login-btn',
      success: function(authObj) {
    	alert("로그인 성공!");
    	location.href='navigation.jsp';
    	//성공했을때 현재는 네비게이션 페이지로 이동.
      },
      fail: function(err) {
         alert(JSON.stringify(err));
      }
    });
    
    //로그인 성공 판단
	function isLogin(){
		var result = false;
		if(Kakao.Auth.getAccessToken()){
			result = true;
		}
		return result;
	}
    
	//로그아웃
	function logout(){
		Kakao.Auth.logout();
	}
	
	//이미 로그인이 되어있다면 다시 네비게이션 페이지로 이동
	if(isLogin()){
		location.href='navigation.jsp';
	}
  //]]>
</script>
</body>
</html>