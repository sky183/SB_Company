<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
</head>
<body>

   <input type="text" id="search">
   <button type="button" id="submit2">검색</button>

   <script>
   $('#submit2').on('click', function() {
      $.ajax({
         url : 'https://opendict.korean.go.kr/api/search?key=CB17CA4D03226E324BDC90EB7B2D890F&q=' + $('#search').val(),
         dataType : 'xml',
         success : function(data) {
              $(data).find('definition').each(function(){
               var definition = $(this).text();         
               $('<p></p>').text(definition).appendTo('body');
            }); 
         }
      });
   });
</script>
</body>
</html>