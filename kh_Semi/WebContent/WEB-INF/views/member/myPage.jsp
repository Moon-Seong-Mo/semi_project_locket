<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Member memberInfo = (Member)request.getAttribute("memberInfo");
	int dCount = (int)request.getAttribute("dCount");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로컬마켓</title>
<%@ include file="/resources/globalVariable.jsp" %>

<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/base.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/content-area.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/content.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/myPage.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/ad.css">


</head>
<body>
   <div class="wrap">
      <%@ include file="/WEB-INF/views/common/header.jsp" %>
      <div id="content-area">
         <%@ include file="/WEB-INF/views/common/nav.jsp" %>
         
         <div id="content">
            
            <br>
            
            <div id="top-area">
					<label id="name-area"><%= loginMember.getNickName() %></label>
					<label id="rank-area">님의 등급은 [<%= memberInfo.getRankName() %>]입니다.</label>
			</div>           
			 <!-- 여기서부터 -->            
            <br>
            <br>   
                     
            <div id="middle-area">
               <span id="infoTitle">My info</span>         
               <button id="updateInfoBtn" onclick="location.href='<%= context %>/updateInfoForm.do'">내 정보 수정</button>      
               <br>
               <hr>
               <br>                  
                  <label id="info">아이디 : <%= loginMember.getId() %></label>
                  
                  <br>
                  
                  <label id="info">전화 : <%= memberInfo.getPhone() %></label><br>
                  <label id="info">이메일 : <%= memberInfo.getEmail() %></label><br>               
                  <br>               
                  <label id="info"><B>거래 완료 : <%= dCount %>건</B></label>                  
                  <label id="deal" class="glyphicon glyphicon-thumbs-up"></label>
                  <button id="myDealBtn" onclick="location.href='<%= context %>/applyP.do'">거래신청 조회</button>
                  <button id="shippingMnagementBtn" onclick="location.href='<%= context %>/deliveryList.do'">배송지 관리</button>
            </div>
            
            <div id="bottom-area">
               <div id="div1" onclick="location.href='<%= context %>/myStoreList.do'">
                  <label id="bottom-icon" class="glyphicon glyphicon-leaf"></label><br>
                  <span>내 상점</span>
               </div>
               <div id="div1" onclick="location.href='<%= context %>/buy_list_c.do'">
                  <label id="bottom-icon" class="glyphicon glyphicon-globe"></label><br>
                  <span>공동구매</span>
               </div>
               <div id="div1" onclick="location.href='<%= context %>/myWishlist.do'">
                  <label id="bottom-icon" class="glyphicon glyphicon-heart" style="margin-left:45px;"></label><br>
                  <span>찜목록</span> 
                  <!-- css에서 절대 안먹어서 ..영재씨 눈감아주세요 ... -->   
               </div>            
            </div>
            
         </div>
      </div>
   </div>
   
   <div class="wrap">
      <%@ include file="/WEB-INF/views/common/footer.jsp" %>
   </div>            
   <%@ include file="/WEB-INF/views/common/ad.jsp" %>
</body>
</html>