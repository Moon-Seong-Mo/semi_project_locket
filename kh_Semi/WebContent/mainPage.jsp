<%@page import="common.model.vo.ProductMain"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.util.ArrayList, product.model.vo.*, java.util.*" %>
<%
	ArrayList<ProductMain> list = (ArrayList<ProductMain>) request.getAttribute("pList");
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
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/mainpage.css">
<style>
</style>
</head>
<body>
   <div class="wrap">
      <%@ include file="/WEB-INF/views/common/header.jsp" %>
      <div id="content-area">
         <%@ include file="/WEB-INF/views/common/nav.jsp" %>
         
         <div id="content">
            <div id="welcome">
            <img src="resources/images/q2q2.jpg">
            </div>
            <br>
            <br>
            <br>
            
            <hr>
            
            <div id="mainpage1">         
               <span id="Monthitle">이번달 인기 상품</span>
               <div id="item-list">
					<% for(ProductMain p : list) { %>
		               <div class="item">
		               		<a href="javascript:void(0);" onclick="productLink('<%= context %>/pdetail.pro?option=0&pId=<%= p.getProductNum() %>');"> 
		               		<img alt="상품" src="<%= context %>/product_uploadFiles/<%= p.getProductImage() %>"> 
								<span><%= p.getProductTitle() %></span> <span><%= p.getProductPrice() %>원</span>
							</a>
		               </div>
		            <% } %>
			   </div>
              
            </div>
                
         </div>
      </div>
   </div>
   <div class="wrap">
      <%@ include file="/WEB-INF/views/common/footer.jsp" %>
   </div>
   <%@ include file="/WEB-INF/views/common/ad.jsp" %>
   
   <script>
   		function productLink(path) {
			<% if(loginMember != null) { %>
				location.href = path;
			<% } else { %>
				alert('로그인 후 조회가능합니다.');
			<% } %>
		}
   </script>
</body>
</html>