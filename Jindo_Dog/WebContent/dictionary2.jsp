<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
</head>
<style>
  body {
   position: relative;
  }
  .main {
   width: 600px;
   height: 440px;
   margin: auto auto;
   overflow-y: auto;
   padding: 30px 20px 0 20px;
   }
   
   .view {
   width: 600px;
   height: 480px;
   margin: auto auto;
   overflow: hidden;
   padding-bottom: 20px;
   }
</style>
<body>
<jsp:include page="navigation.jsp"></jsp:include>
<div class="view">
   <div class="main">
   <h1>남북한말 사전 검색 서비스</h1>
   <input type="text" id="search">
   <button type="button" id="submit2">검색</button>
   <br>
   <br>
   <div style="font-style: italic; font-size: 25px;">검색 내용</div>
   <br>
   <div id="val" style="width:500px"></div>
   </div>
   </div>
   <jsp:include page="footer.jsp"></jsp:include>
   <script>
   var sun = function() {
	      $.ajax({
		         url : 'http://openapi.korean.go.kr/openapi/service/SouthNorthWordsService/getSouthNorthWordsList?serviceKey=qQ6k20Ak4EJ6g7xsJ0nPyKG0DA0dRQ9MHup%2FeF4laDTBFSAyMg3KE%2Ba9onHXtUseTc%2B3Jh9NhX1Po7ArzIBt2Q%3D%3D&title=' + $('#search').val(),
		         success : function(data) {
		        	  $('#val').html('');
		              $(data).find('dsemantic').each(function(index){
		               var dsemantic = (index + 1) + ' - ' + $(this).text();
		               $('<p></p>').text(dsemantic).appendTo('#val');
		            }); 
		         }
		      });
		   };
		   
   $('#submit2').on('click', sun);
   
   $("#search").keyup(function(e){if(e.keyCode == 13) sun() });   

   
   
</script>
</body>
</html>