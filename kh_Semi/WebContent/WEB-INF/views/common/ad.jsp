<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>advertise</title>
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/ad.css">
<script src="<%= context %>/resources/js/jquery-3.5.1.min.js"></script>
</head>
<body>
   
   <aside id="advertise">
      <a href="#header" id="topbt">맨 위로▲</a>
      <h2>광고 배너</h2>
      <a href="http://iei.or.kr" target="_blank">
         <img id="adImg" src="<%= context %>/resources/images/kh.png">
         <br>
         <b>kh정보교육원</b> 
         <br>
      </a>
      <br>
      
      
      <a href="http://www.q-net.or.kr/man001.do?gSite=Q" target="_blank">
         <img id="adImg" src="<%= context %>/resources/images/QNET.JPG">
         <br>
         <b>자격증 접수</b>
      </a>
      <br>
      
      <br><br>
   
      <a href="https://www.dataq.or.kr/www/main.do" target="_blank">
         <img id="adImg" src="<%= context %>/resources/images/KDATA.JPG">
         <br>
         <b>데이터 자격 시험</b>
      </a>
      <br>
   </aside>
   
   <script>
      $(function() {
         adReset();
      });
      
      window.onresize = function() {
        adReset();     
      };
      
      window.onfocus = function() {
         adReset();
      }
      
      function adReset() {
         var width = window.outerWidth;
         var ad = document.getElementById("advertise");
         if(width < 1591) {
             ad.style.position = "relative";
             ad.style.top = "-80%";
             ad.style.right = "-15%";
           } else {
             ad.style.position = "fixed";
             ad.style.top = "30%";
             ad.style.right = "1%";
           }        
      }
   </script>
   
</body>
</html>