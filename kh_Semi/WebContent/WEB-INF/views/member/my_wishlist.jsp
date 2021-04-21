<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.util.ArrayList, product.model.vo.*, board.model.vo.PageInfo"  %>
<%
	ArrayList<Product> wList = (ArrayList<Product>)request.getAttribute("wList");
	ArrayList<Product_File> wfList = (ArrayList<Product_File>)request.getAttribute("wfList");
	PageInfo pi = (PageInfo)request.getAttribute("pi");
	
// 	System.out.println(pi.getEndPage());
	
	int listCount = pi.getListCount();
	int currentPage = pi.getCurrentPage();
	int maxPage = pi.getMaxPage();
	int startPage = pi.getStartPage();
	int endPage = pi.getEndPage();
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
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/my_wishlist.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<div id="content-area">
			<%@ include file="/WEB-INF/views/common/nav.jsp" %>
			
			<div id ="content">
				<h1>찜 목록</h1>
				
				<br><br>
				
				<div id="item-list">
					<% if(wList.isEmpty() || wfList.isEmpty()) { %>
						<div class="none">
							<label class="glyphicon glyphicon-alert"> </label>
							<label>찜한 상품이 없습니다.</label>
							<br><br><br>
							<label id="goRegister" class="glyphicon glyphicon-hand-right"></label>
							<button id="goRegister" onclick="location.href='<%= context %>/list.pro'">상품 구경하러 가기!</button>
						</div>
					<% } else { %>
						<% for(int i = 0; i < wList.size(); i++) { %>
							<% Product p = wList.get(i); %>
							<button id="removeCheck" onclick="deleteList(this);" value="<%= p.getProductId() %>">X</button>
							<div class="item" align="center">
				               	<input type="hidden" value="<%= p.getProductId() %>" id="productNum">
				               		<% for(int j=0; j < wfList.size(); j++) { %>
				                 		 <% Product_File pf = wfList.get(j); %>
				                 		 <% if(pf.getP_num() == p.getProductId()) { %>
				                     		<img src="<%= request.getContextPath() %>/product_uploadFiles/<%= pf.getChangeName() %>">
				                 		 	
				                 		 <% } %>
				               		<% } %>
				            		<br>
								<p>								
			               			No. <%= p.getProductId() %>&nbsp;&nbsp;&nbsp;&nbsp;<%= p.getTitle() %><br>  			
			              			<%= p.getPrice() %>원&nbsp;&nbsp;&nbsp;&nbsp;조회수 : <%= p.getProductCount() %>
			            		</p>
							</div>
						<% } %>
					<% } %>
					
					<% if(!wList.isEmpty()) { %>
					<div class="paging" align="center">
						<!-- 맨 처음으로 -->
						<button onclick="location.href='<%= context %>/myWishlist.do?currentPage=1'">&lt;&lt;</button>				
						<!-- 이전 페이지로 -->
						<button onclick="location.href='<%= context %>/myWishlist.do?currentPage=<%= currentPage - 1 %>'" id="beforeBtn">&lt;</button>
						<script>
							if(<%= currentPage %> <= 1) {
								var before = $('#beforeBtn');
								before.attr('disabled', 'true'); //비활성화 시키겠다!
							}
						</script>			
						<!-- 숫자 목록 버튼 -->
						<% for(int p = startPage; p <= endPage; p++) { %>
							<% if(p == currentPage) { %>
								<button id="choosen" disabled><%= p %></button>				
							<% } else {  %>
								<button id="numBtn" onclick="location.href='<%= context %>/myWishlist.do?currentPage=<%= p %>'"><%= p %></button>
							<% }  %>
						<% } %>
						<!-- 다음 페이지로 -->
						<button onclick="location.href='<%= context %>/myWishlist.do?currentPage=<%= currentPage + 1 %>'" id="afterBtn">&gt;</button>
						<script>
							if(<%= currentPage %> >= <%= maxPage %>) {
								var after = $('#afterBtn');
								after.attr('disabled', 'true');
							}
						</script>
						<!-- 맨 끝으로 -->
						<button onclick="location.href='<%= context %>/myWishlist.do?currentPage=<%= maxPage %>'">&gt;&gt;</button>
					</div>
					<% } %>
					</div>
				</div>
			</div>
		</div>
		
		<script>
		$(function(){
			$('.item').click(function(){
				var pId = $(this).children().eq(0).val();
				
				location.href='<%= context %>/pdetail.pro?option=0&pId=' + pId;
			});
		});
		
		function deleteList(e){
			if(confirm('해당 상품을 목록에서 삭제하시겠습니까?')) {
				var pId = e.value;		
				location.href='deleteWishlist.do?pId=' + pId;
			}
		}
		</script>
	
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
	
	<%@ include file="/WEB-INF/views/common/ad.jsp" %>
</body>
</html>
			