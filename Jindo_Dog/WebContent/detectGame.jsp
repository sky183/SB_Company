<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-1.10.0.js"></script>
<script>
            $(document).ready(function() {
            	var ranNum = []; //마커랜덤번호
            	var map; 
            	var cnt=0; //마커수
            	var markers=[]; //마커배열
            	var clickCnt=0; //클릭가능횟수
            	var score=0; //점수
            	var spyNum=0; // 간첩수
            	var handler=[]; //각 마커마다 주어지는 이벤트핸들러 배열
            	
            	$('#scoreBoard').html('<h1>로딩중...</h1>');
            	$('body').append('남은 간첩보다 잡은간첩이 많으면 승리!');
                map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다   
                $.ajax({
                    url: 'http://openapi.seoul.go.kr:8088/6b69797765676b7337385874585779/xml/SebcBicycleRetalKor/1/200', //서울시 자전거보관소 api
                    success: function(data) {
                        $(data).find('SebcBicycleRetalKor').find('row').each(function() {
                        	var Lati = $(this).find('LATITUDE').text();
							var Longi = $(this).find('LONGITUDE').text();                       	
                            if ($(this).find('ADD_KOR').text() != ""){
                                // 주소-좌표 변환 객체를 생성합니다
                            	cnt++;
                            	var imageSrc = 'images/spyMarker.png', // 마커이미지의 주소입니다    
                  		   			imageSize = new daum.maps.Size(40, 40), // 마커이미지의 크기입니다
                  		    		imageOption = {offset: new daum.maps.Point(20, 40)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
                            	var marker = new daum.maps.Marker({
                            		map: map,
                            		position: new daum.maps.LatLng(Lati, Longi),
                            		image: new daum.maps.MarkerImage(imageSrc, imageSize, imageOption),
                            		clickable: true
                            	});
                            	markers.push(marker); //마커배열에 생성한마커 추가
                            }//and if
                        });//end each
                    }//end success
                });//end ajax()
                function winOrLose(marker){ //승패확인,클릭카운트확인
                	var board = '<h1>'+'잡은간첩:'+score+'<br>'+ 
					'잔여탐색횟수:'+clickCnt+'<br>'+
					'생존한간첩:'+spyNum+'</h1>'+'<br>';
					$('#scoreBoard').html(board); //스코어보드 갱신
                	daum.maps.event.removeListener(marker, 'click', handler[marker.getTitle()]); //이벤트 핸들러 제거
                	if(clickCnt<=0){
                		if(score!=0&&score>=spyNum){ //남은간첩보다 점수가 높거나 같으면 승리
                			win();
                		}else{
                			lose();
                		}
                	}
                }
                
                function pageMove(sc,page){
                    var f=document.paging; //폼 name
                    f.score.value = sc;
                    f.action=page;//이동할 페이지
                    f.method="post";//POST방식
                    f.submit();
                }
                
                function win(){ //승리시
                	alert('youWin!');
                	pageMove(score,"success.jsp");
                }
                
                function lose(){ //패배시
                	alert('youLose');
                	location.href = "fail.jsp";
                }
                
                
                
                setTimeout(function() { //로딩대기시간
                	ranNum = randomNum(cnt-1);
                	spyNum=20;
                	clickCnt=spyNum*3;
                	var board = '<h1>'+'잡은간첩:'+score+'<br>'+
								'잔여탐색횟수:'+clickCnt+'<br>'+
								'생존한간첩:'+spyNum+'</h1>'+'<br>';
					$('#scoreBoard').html(board);
                	for(var i=0;i<spyNum;i++){//간첩있는곳 마커옵션
                		markers[ranNum[i]].setTitle(ranNum[i]); //마커타이틀에 식별번호 저장
                		handler[ranNum[i]] = function(event){//이벤트핸들러 생성
                			score++;
                  			if(spyNum>0){
                  			spyNum--;
                  			}
                  			if(clickCnt>0){
                  			clickCnt--;
                  			}
                  			var imageSrc = 'images/arrestMarker.png', // 마커이미지의 주소입니다    
                  		   		imageSize = new daum.maps.Size(40, 40), // 마커이미지의 크기입니다
                  		    	imageOption = {offset: new daum.maps.Point(20, 40)}, // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
                  		    	markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption);
                  			this.setImage(markerImage); //해당마커의 마커이미지 변경
							alert(this.getTitle()+"번 간첩을 잡았습니다!");
                        	winOrLose(this);
                		}
                  		daum.maps.event.addListener(markers[ranNum[i]], 'click', handler[ranNum[i]]);
                	}
                	
                	for(var j=spyNum;j<cnt;j++){//간첩없는곳 마커옵션
                		markers[ranNum[j]].setTitle(ranNum[j]); //마커타이틀에 식별번호저장
                		handler[ranNum[j]] = function(event){//이벤트핸들러 생성
                			if(clickCnt>0){
                      			clickCnt--;
                      			}
                			alert('이곳에 간첩은 없었습니다..');
                			this.setMap(null);
                			winOrLose(this);
                		}
                		daum.maps.event.addListener(markers[ranNum[j]], 'click', handler[ranNum[j]]);
                	}
                	
                }, 300); //end timer
            
                
                
            }); //end onload
            
            function randomNum(n){ //중복되지 않는 난수
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
			<form name="paging">
				<input type="hidden" name="score"/>
			</form>
            <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=067a6bf449e7fc2d40b537d4fbbb485d&libraries=services"></script>
            <script>
                var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                    mapOption = {
                        center: new daum.maps.LatLng(37.55878012, 126.99500883), // 지도의 중심좌표
                        level: 7 // 지도의 확대 레벨
                    };

            </script>
        </body>

        </html>
