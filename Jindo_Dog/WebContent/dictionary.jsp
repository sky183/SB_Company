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
   width: 500px;
   margin: auto auto;
   }
</style>
<body>
   <div class="main">
   <h1>우리말 사전 검색 서비스</h1>
   <input type="text" id="search">
   <button type="button" id="submit2">검색</button>
   <br>
   <br>
   <br>
   <div style="font-style: italic; font-size: 25px;">검색 내용</div>
   <div id="val" style="width:500px"></div>
   </div>
   <script>
   var sun = function() {
	      $.ajax({
		         url : 'https://opendict.korean.go.kr/api/search?key=CB17CA4D03226E324BDC90EB7B2D890F&q=' + $('#search').val(),
		         success : function(data) {
		        	  $('#val').html('');
		              $(data).find('definition').each(function(index){
		               var definition = (index + 1) + ' - ' + $(this).text();
		               $('<p></p>').text(definition).appendTo('#val');
		            }); 
		         }
		      });
		   };
		   
   $('#submit2').on('click', sun);
   
   $("#search").keyup(function(e){if(e.keyCode == 13) sun() });   

   
   
</script>
</body>
</html>