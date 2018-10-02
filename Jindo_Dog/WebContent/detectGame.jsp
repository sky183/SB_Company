<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-1.10.0.js"></script>
<script>
	var ranNum = []; //마커랜덤번호
	var map; 
	var geocoder;
	var cnt=0; //마커수
	var markers=[]; //마커배열
	var clickCnt=0; //클릭가능횟수
	var score=0; //점수
	var spyNum=0; // 간첩마리수
	var handler=[];
	var board;
            $(document).ready(function() {
            	$('#scoreBoard').html('<h1>로딩중...</h1>');
            	$('body').append('남은 간첩보다 잡은간첩이 많으면 승리!');
                // 지도를 생성합니다    
                map = new daum.maps.Map(mapContainer, mapOption);
                $.ajax({
                    url: 'http://openapi.seoul.go.kr:8088/6b69797765676b7337385874585779/xml/SebcBicycleRetalKor/1/200',

                    success: function(data) {
                    	geocoder = new daum.maps.services.Geocoder();
                       
                        $(data).find('SebcBicycleRetalKor').find('row').find('ADD_KOR').each(function() {
                            if ($(this).text() != "") {
                                // 주소-좌표 변환 객체를 생성합니다
                                
                                geocoder.addressSearch($(this).text(), function(result, status) {
                                    // 정상적으로 검색이 완료됐으면 
                                    if (status === daum.maps.services.Status.OK) {
                                    	cnt++;
                                        coords = new daum.maps.LatLng(result[0].y, result[0].x); 
                                        // 결과값으로 받은 위치를 마커로 표시합니다
                                        var marker = new daum.maps.Marker({
                                            map: map,
                                            position: coords,
                                            clickable: true
                                        });
                                        markers.push(marker); //마커배열에 생성한마커 추가
                                    }
                                    
                                }); //end geocoder()
                                
                                
                                   
                            }
                        });//end each
                        
                        
                    }//end success
                });//end ajax()
                function winOrLose(marker){ //승패확인,클릭카운트확인
                	daum.maps.event.removeListener(marker, 'click', handler[marker.getTitle()]);
                	if(clickCnt<=0){
                		if(score!=0&&score>=spyNum){
                			win();
                		}else{
                			lose();
                		}
                	}
                }
                
                function win(){ //승리시
                	alert('youWin!');
                	//페이지이동
                }
                
                function lose(){ //패배시
                	alert('youLose');
                	//페이지이동
                }
                
                setTimeout(function() { //로딩대기시간
                	
                	function delMarker(i) {
            	        markers[i].setMap(null);
            		}
                	
                	ranNum = randomNum(cnt-1);
                	spyNum=20;
                	clickCnt=spyNum*2;
                	board = '<h1>'+'잡은간첩:'+score+'<br>'+
					'잔여탐색횟수:'+clickCnt+'<br>'+
					'생존한간첩:'+spyNum+'</h1>'+'<br>'
					$('#scoreBoard').html(board);
                	for(i=0;i<spyNum;i++){//간첩있는곳 마커옵션
                		markers[ranNum[i]].setTitle(ranNum[i]);
                		handler[ranNum[i]] = function(event){
                			score++;
                  			if(spyNum>0){
                  			spyNum--;
                  			}
                  			if(clickCnt>0){
                  			clickCnt--;
                  			}
                  			var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png', // 마커이미지의 주소입니다    
                  		   		imageSize = new daum.maps.Size(64, 69), // 마커이미지의 크기입니다
                  		    	imageOption = {offset: new daum.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
                  		    var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption)
                  			this.setImage(markerImage);
							alert(this.getTitle()+"번 간첩을 잡았습니다!");
							
							board = '<h1>'+'잡은간첩:'+score+'<br>'+
										'잔여탐색횟수:'+clickCnt+'<br>'+
										'생존한간첩:'+spyNum+'</h1>'+'<br>'
							$('#scoreBoard').html(board);
                        	winOrLose(this);
                        	
                		}
                  		daum.maps.event.addListener(markers[ranNum[i]], 'click', handler[ranNum[i]]);
                	}
                	
                	for(j=spyNum;j<cnt;j++){//간첩없는곳 마커옵션
                		markers[ranNum[j]].setTitle(ranNum[j]);
                		handler[ranNum[j]] = function(event){
                			if(clickCnt>0){
                      			clickCnt--;
                      			}
                			alert('이곳에 간첩은 없었습니다..');
                			this.setMap(null);
                			var board = '<h1>'+'잡은간첩:'+score+'<br>'+
							'잔여탐색횟수:'+clickCnt+'<br>'+
							'생존한간첩:'+spyNum+'</h1>'+'<br>'
							$('#scoreBoard').html(board);
                			winOrLose(this);
                		}
                		daum.maps.event.addListener(markers[ranNum[j]], 'click', handler[ranNum[j]]);
                	}
                	
                }, 3000); //end timer
            
                
                
            }); //end onload
            
            function randomNum(n){
                var ar = new Array();
                var temp;
                var rnum;
               
                //전달받은 매개변수 n만큼 배열 생성 ( 1~n )
                for(var i=0; i<=n; i++){
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
            <style>
            	#scoreBoard{
            		position: absolute;
            		display: block;
            		z-index:99999;
            		top:0px;
            		padding:0px 10px;
            	}
            </style>
        </head>

        <body>
            <div id="map" style="width:100%;height:850px;"></div>
			<div id="scoreBoard"></div>
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
