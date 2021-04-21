<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>nav</title>
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/nav.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
</head>
<body>
   <div id="nav">
   
            <br>
            <br>
            
            <!-- ------------------------------------------------------------------------------------- -->
            <div id="menu-area">
               <ul class="out-menu">
                  <label class="glyphicon glyphicon-camera"><div>중고물품</div></label>
                  <li><button onclick="location.href='<%= context %>/list.pro'">중고 물품보기</button></li>
                  <% if(loginMember != null) { %>
                     <li><button onclick="location.href='<%= context %>/registerForm.pro'">중고 물품등록</button></li>
                    <% } %>
               </ul>
               <ul class="out-menu">
                  <label class="glyphicon glyphicon-tag"><div>공동구매</div></label>
                  <li><button onclick="location.href='<%= context %>/groupList.do'">공동구매 목록조회</button></li>
                  <% if(loginMember != null && loginMember.getRankCode() == 99) { %>
                  <li><button onclick="location.href='<%= context %>/groupWriteForm.do'">공동구매 물품등록</button></li> 

                  <% } %>
               </ul>
               <ul class="out-menu menuBtn" onclick="location.href='<%= context %>/boardList.do'">
                  <label class="glyphicon glyphicon-list" class="menuBtn"><div class="menuBtn">자유게시판</div></label>
               </ul>
               <% if(loginMember != null && loginMember.getRankCode() == 99) { %>
               <ul class="out-menu">
                  <label class="glyphicon glyphicon-lock"><div>관리자</div></label>
                  <li><button onclick="location.href='<%= context %>/managerInfo.do'">회원 정보 관리</li>
                  <li><button onclick="location.href='<%= context %>/managerreport.do'">신고 목록 관리</li>
               </ul>
               <% } %>
            </div>
            <hr>
            <!-- ------------------------------------------------------------------------------------- -->
            <%@ include file="tom.jsp" %>
            <!-- ------------------------------------------------------------------------------------- -->
         </div>
         
         <script>
            $('.out-menu').click(function(){
               $(this).children().next().slideToggle();
            });
         </script>
         
</body>
</html>