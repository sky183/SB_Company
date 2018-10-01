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
    	Kakao.Auth.setAccessToken(authObj.access_token);
    	location.href='navigation.jsp';
      },
      fail: function(err) {
         alert(JSON.stringify(err));
      }
    });
	function isLogin(){
		var result = false;
		if(Kakao.Auth.getAccessToken()){
			result = true;
		}
		return result;
	}
	function logout(){
		Kakao.Auth.logout();
	}
	if(isLogin()){
		location.href='navigation.jsp';
	}
  //]]>
</script>
</body>
</html>