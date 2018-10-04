<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type='text/javascript'>
	
	var JD_CTX = '${pageContext.request.contextPath}';
	
  	//사용할 앱의 JavaScript 키를 설정해 주세요.
	Kakao.init('1ea997909a92b901e801433aa9b49158');
	function __isLogin(){
		var result = false;
		if(Kakao.Auth.getAccessToken()){
			result = true;
		}
		return result;
	}
	function __logout(callback){
		Kakao.Auth.logout(callback);
	}
	
	if('${param.checkYn}' == 'Y' || !__isLogin()){
		alert('로그인 정보가 없습니다.');
		location.href = JD_CTX + '/login.jsp';
	}
</script>