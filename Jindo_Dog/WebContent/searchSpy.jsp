<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("utf-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1ea997909a92b901e801433aa9b49158&libraries=services,clusterer,drawing"></script>
<script type="text/javascript"
	src="https://sgisapi.kostat.go.kr/OpenAPI3/auth/javascriptAuth?consumer_key=e8a7478b5d31421ea3af"></script>

<style>
* {
	margin: 0px;
	padding: 0px;
}

#searchWrap {
	margin: 0px auto;
	width: 500px;
	height: 480px;
}

#searchWrap>h1 {
	margin-top: 20px;
	margin-bottom: 10px;
}

#map {
	margin-top: 10px;
	z-index: -1;
}

#stNameTx {
	position: absolute;
	background-color: white;
	top: 270px;
	margin-left: 10px;
	z-index: 1;
}
</style>

</head>
<body>
	<jsp:include page="navigation.jsp"></jsp:include>
	<div id="searchWrap">
		<h1>지하철역 근처 간첩 찾기</h1>

		<label for="code">역 이름</label> <input type="text" id="name" /> <input
			type="button" value="조회" id="search" />
		<h3 id="stNameTx"></h3>
		<div id="map" style="width: 450px; height: 380px;"></div>

	</div>
	<jsp:include page="footer.jsp"></jsp:include>

	<script src="https://code.jquery.com/jquery-1.10.0.js"></script>

	<script>
		// 엔터 키 조회 처리 
		$('#name').keydown(function(e) {
			if (e.keyCode == 13) {
				$('#search').click(); // 클릭 이벤트 강제 발생
			}
		});
	
		var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
		var options = { //지도를 생성할 때 필요한 기본 옵션
			center : new daum.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
			level : 5 //지도의 레벨(확대, 축소 정도)
		};
	
		var map = new daum.maps.Map(container, options); // 지도 표시.
	
		$('#search').on('click', function() { // 전송 버튼 클릭 시
			var code = '';
			var name = $('#name').val(); // 입력한 역 이름
	
			$('#stNameTx').html('<span style="color:red">검색 중입니다...</span>');
	
			$.getJSON('json/station.json', function(data) {
				for (var i = 0; i < data.DATA.length; i++) {
	
					// 입력한 역 이름과 JSON 객체에 저장된 역 이름을 비교하여 일치할 경우 역 코드 리턴
					if (data.DATA[i].station_nm == name) {
						code = data.DATA[i].station_cd;
					}
				}
			});
	
			// 많은 양의 JSON 객체를 불러올 때 지연되는 시간으로 인해 다음 코드에서 사용할 code 변수에 값이 저장되지 않는다.
			// 이를 해결하기 위해 처리 시간을 위한 타이머를 두고 그 이후 아래 코드를 실행한다.
			setTimeout(function() {
				ajaxCode(code);
			}, 1000)
	
		});
	
		function ajaxCode(code) {
			$.ajax({
				url : 'http://openAPI.seoul.go.kr:8088/486a7359726d6b6d313135497051644c/xml/SearchLocationOfSTNByIDService/1/5/' + code,
				success : function(data) {
					$(data).find('row').each(function() {
						var stationName = $(this).find('STATION_NM').text();
						var xPoint = $(this).find('XPOINT_WGS').text();
						var yPoint = $(this).find('YPOINT_WGS').text();
						console.log(xPoint + ", " + yPoint);
	
						$('#stNameTx').html('입력하신 지하철역은 <span style="color:red">' + stationName + '역 </span>입니다.');
	
						options = { //지도를 생성할 때 필요한 기본 옵션 변경
							center : new daum.maps.LatLng(xPoint, yPoint), //지도의 중심좌표 변경
							level : 4 //지도의 레벨(확대, 축소 정도)
						};
						
						$.ajax({
		                    url: 'http://openapi.seoul.go.kr:8088/6b69797765676b7337385874585779/xml/SebcBicycleRetalKor/1/200', //서울시 자전거보관소 api
		                    success: function(data) {
		                        $(data).find('SebcBicycleRetalKor').find('row').each(function() {
		                        	var Lati = $(this).find('LATITUDE').text();
									var Longi = $(this).find('LONGITUDE').text();                       	
		                            if ($(this).find('ADD_KOR').text() != ""){
		                            	var imageSrc = 'images/spyMarker.png', // 마커이미지의 주소입니다    
		                  		   			imageSize = new daum.maps.Size(40, 40), // 마커이미지의 크기입니다
		                  		    		imageOption = {offset: new daum.maps.Point(20, 40)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
		                            	var marker = new daum.maps.Marker({
		                            		map: map,
		                            		position: new daum.maps.LatLng(Lati, Longi),
		                            		image: new daum.maps.MarkerImage(imageSrc, imageSize, imageOption),
		                            		clickable: true
		                            	});
		                            }//and if
		                        });//end each
		                    }//end success
		                });//end ajax()
						
						map = new daum.maps.Map(container, options); // 지도 표시.
	
						// 마커가 표시될 위치입니다 
						var markerPosition = new daum.maps.LatLng(xPoint, yPoint);
	
						// 마커를 생성합니다
						var marker = new daum.maps.Marker({
							position : markerPosition
						});
	
						// 마커가 지도 위에 표시되도록 설정합니다
						marker.setMap(map);
	
					});
				},
	
				error : $('#stNameTx').html('입력하신 지하철역은 존재하지 않습니다.')
			}); // end ajax 
		}
	</script>
</body>
</html>