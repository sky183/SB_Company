<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-1.10.0.js"></script>
<script>
    $(document).ready(function () {
    	$.ajax({
			url:'http://openapi.seoul.go.kr:8088/6b69797765676b7337385874585779/xml/SebcBicycleRetalKor/1/5/',
			error: alert('arrer'),
			success : function(data) {
				$(data).find('ADD_KOR').each(function(){
					$(body).append($(this).text());
                });
                
			}
        });
    });
</script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>