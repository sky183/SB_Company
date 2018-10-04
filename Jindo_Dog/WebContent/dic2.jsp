<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script>
var xhr = new XMLHttpRequest();
var url = 'http://openapi.korean.go.kr/openapi/service/SouthNorthWordsService/getSouthNorthWordsList'; /*URL*/
var queryParams = '?' + encodeURIComponent('serviceKey') + '='+'qQ6k20Ak4EJ6g7xsJ0nPyKG0DA0dRQ9MHup%2FeF4laDTBFSAyMg3KE%2Ba9onHXtUseTc%2B3Jh9NhX1Po7ArzIBt2Q%3D%3D'; /*Service Key*/
queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('10'); /*한 페이지 결과 수*/
queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); /*페이지 번호*/
queryParams += '&' + encodeURIComponent('title') + '=' + encodeURIComponent('연구'); /*단어*/
xhr.open('GET', url + queryParams);
xhr.onreadystatechange = function () {
    if (this.readyState == 4) {
        alert('Status: '+this.status+' Headers: '+JSON.stringify(this.getAllResponseHeaders())+' Body: '+this.responseText);
    }
};

xhr.send('');
</script>
</body>
</html>