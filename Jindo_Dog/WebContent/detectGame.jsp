<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-1.10.0.js"></script>
<script>
	var coords = [];
	var ranNum = []
	var map;
	var geocoder;
	var cnt=0;
	var markers=[];
            $(document).ready(function() {
                // 지도를 생성합니다    
                map = new daum.maps.Map(mapContainer, mapOption);
                $.ajax({
                    url: 'http://openapi.seoul.go.kr:8088/6b69797765676b7337385874585779/xml/SebcBicycleRetalKor/1/200',

                    success: function(data) {
                    	geocoder = new daum.maps.services.Geocoder();
                       
                        $(data).find('SebcBicycleRetalKor').find('row').find('ADD_KOR').each(function() {
                            if ($(this).text() != "") {
                                $('body').append('<h1>' + cnt + '</h1>');
                                $('body').append($(this).text());

                                // 주소-좌표 변환 객체를 생성합니다
                                
                                geocoder.addressSearch($(this).text(), function(result, status) {
                                    // 정상적으로 검색이 완료됐으면 
                                    if (status === daum.maps.services.Status.OK) {
                                    	cnt++;
                                        coords[cnt] = new daum.maps.LatLng(result[0].y, result[0].x);
                                        // 결과값으로 받은 위치를 마커로 표시합니다
                                        var marker = new daum.maps.Marker({
                                            map: map,
                                            position: coords[cnt],
                                            clickable: true
                                        });
                                        markers.push(marker);
                                    }
                                    
                                }); //end geocoder()
                                
                                
                                   
                            }
                        });//end each
                        
                        
                    }//end success
                });//end ajax()
                
                setTimeout(function() { //로딩대기시간
                	
                	function delMarker(i) {
            	        markers[i].setMap(null);
            		}
                	
                	ranNum = randomNum(cnt-1);
                	
                	for(i=0;i<130;i++){
                	console.log(i+','+ranNum[i]+','+'///');
                		markers[ranNum[i]].setTitle(ranNum[i]);
                	
                  		daum.maps.event.addListener(markers[ranNum[i]], 'click', function() {
                  			var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png', // 마커이미지의 주소입니다    
                  		   		imageSize = new daum.maps.Size(64, 69), // 마커이미지의 크기입니다
                  		    	imageOption = {offset: new daum.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
                  			//this.setMap(null);
                  		    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption)
                  			this.setImage(markerImage);
                    		var iwContent = '번호:'+this.getTitle();
							alert(this.getTitle());
                    		// 인포윈도우를 생성합니다
                    		var infowindow = new daum.maps.InfoWindow({
                        		position : coords[this.getTitle()], 
                        		content : iwContent
                    		});
                      
                    	// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
                        	infowindow.open(map,this); 
                        	infowindow.close();
                    	});
                	}
                	
                }, 3000); //end timer
            
                
                
            }); //end onload
            
            function randomNum(n){
                var ar = new Array();
                var temp;
                var rnum;
               
                //전달받은 매개변수 n만큼 배열 생성 ( 1~n )
                for(var i=1; i<=n; i++){
                    ar.push(i);
                }
         
                //값을 서로 섞기
                for(var i=0; i< ar.length ; i++)
                {
                    rnum = Math.floor(Math.random() *n); //난수발생
                    temp = ar[i];
                    ar[i] = ar[rnum];
                    ar[rnum] = temp;
                }
         
                return ar;
        	}

        </script>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="utf-8">
            <title>jindo-game</title>
        </head>

        <body>
            <div id="map" style="width:100%;height:800px;"></div>

            <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=067a6bf449e7fc2d40b537d4fbbb485d&libraries=services"></script>
            <script>
                var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                    mapOption = {
                        center: new daum.maps.LatLng(37.55878012, 126.99500883), // 지도의 중심좌표
                        level: 8 // 지도의 확대 레벨
                    };

            </script>
        </body>

        </html>
