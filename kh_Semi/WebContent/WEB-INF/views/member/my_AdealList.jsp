<%@page import="board.model.vo.PageInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/resources/globalVariable.jsp" %>
<%@ page import="java.util.ArrayList, product.model.vo.*" %>
<%
	ArrayList<Deal> AdealList = (ArrayList<Deal>) request.getAttribute("AdealList");
	PageInfo pi = (PageInfo) request.getAttribute("pi");

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
<title>로컬 마켓</title>

<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/base.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/content-area.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/content.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/my_dealList.css">
</head>
<body>
	<div class="wrap">
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div id="content-area">
			<%@ include file="/WEB-INF/views/common/nav.jsp"%>		
			
			<div id="content">
							
				<h1>나의 거래신청 조회</h1>
				
				<br><br>
				
				<div id="mm">
					<form action="<%= context %>/ADealCancel.do" method="post" onsubmit="return cancelDeal(this);">
						<input type ="submit" id ="cancel" value ="취소하기">
					</form>
				</div>
				
				<br><br><br>
				
				<form>
					<table id ="dealTable" border = 1>
						<tr>
							<th width = 5%><input type="checkbox" name="selectAll" id="all"></th>
							<th width = 15%>받는이</th>
							<th width = 50%>상품제목</th>
							<th width = 20%>날짜</th>
						</tr>
						<% if(AdealList.isEmpty()){ %>
						<tr>
							<td colspan="5">신청한 거래요청이 없습니다.</td>
						</tr>
						<% } else { %>
							<% for(Deal m : AdealList) { %>
						<tr>
							<td>
								<input type="checkbox" name="selDeal" onclick="selectOne();" value='<%= m.getProductId() %>'>
							</td>
							<td><%= m.getMember() %></td>
							<td name="td" class="title"><%= m.getProductTitle() %></td>
							<td><%= m.getSend_date() %></td>
						</tr>
							<% } %>
						<% } %>
						
					</table>
				</form>
				
				<br><br>
			
				<div class="pagingArea" align="center">		
					<!-- 맨 처음으로 -->
					<button onclick="location.href='<%= request.getContextPath() %>/applyP.do?currentPage=1'" align="center"> &lt;&lt;</button>
					
					<!-- 이전 페이지로 -->
					<button onclick="location.href='<%= request.getContextPath() %>/applyP.do?currentPage=<%= currentPage - 1 %>'"
						 id="beforeBtn">&lt;</button>
					<script>
						if(<%= currentPage %> <= 1){
							var before = $('#beforeBtn');
							before.attr('disabled', 'true');
						}
					</script>
				
					<!-- 숫자 목록 버튼 -->
					<% for(int p = startPage; p <= endPage; p++) { %>
						<% if(p == currentPage) { %>
							<button id="choosen" disabled><%= p %></button>
						<% } else { %>
							<button id="numBtn" onclick="location.href='<%= request.getContextPath() %>/applyP.do?currentPage=<%= p %>'"><%= p %></button>
						<% } %>
					<% } %>
					
					<!-- 다음 페이지로 -->
					<button onclick="location.href='<%= request.getContextPath() %>/applyP.do?currentPage=<%= currentPage + 1 %>'"
							id="afterBtn">&gt;</button>
					<script>
						if(<%= currentPage %> >= <%= maxPage %>){
							var after = $('#afterBtn');
							after.attr('disabled', 'true');
						}
					</script>
					<!-- 맨 끝으로 -->
					<button onclick="location.href='<%= request.getContextPath() %>/applyP.do?currentPage=<%= maxPage %>'">&gt;&gt;</button>
				</div>

   				<script>
					var all = document.getElementById("all");
					var selDeal = document.getElementsByName("selDeal");
					
					all.onclick = function() {
						selectAll();
					};
					
					function selectAll(){
						if(all.checked){
							for(var i = 0; i < selDeal.length; i++){
								selDeal[i].checked = true;
							}
						} else{
							for(var i = 0; i < selDeal.length; i++){
								selDeal[i].checked = false;
							}
						} 
					}				
					
					function selectOne(){
						var count = 0;
						
						for(var i = 0; i < selDeal.length; i++){
							if(selDeal[i].checked){
								count++;
							} 
						}
						
						if(count != selDeal.length){
							all.checked = false;
						} else{
							all.checked = true;
						}
					}
					
			      	$(function(){
			      		$('#dealTable td[name=td]').mouseenter(function(){
							$(this).parent().css({'background':'darkgray', 'cursor':'pointer'});
						}).mouseout(function(){
							$(this).parent().css('background','#fffcf5');
						}).click(function(){
			      			var num = $(this).parent().first().find('input').val();
							location.href='<%= request.getContextPath() %>/pdetail.pro?option=0&pId=' + num;
			      		});
			      	});	      	
			      	
			      	// 거절 기능
			      	function cancelDeal(form){
						var checking = document.getElementsByName("selDeal");
						
						var count = 0;
						var arr = new Array();
						for(var i = 0; i < checking.length; i++) {
							if(checking[i].checked) {
								count++;
								arr.push(checking[i].value);
							}
						}
						
						if(count == 0) {
							alert('신청을 취소할 상품을 선택해 주세요.');
						} else {
						    if(confirm("정말 취소하시겠습니까?")){
			 					for(var i = 0; i < arr.length; i++) {
			 						console.log(arr);
			 						var data = document.createElement('input');
			 						data.setAttribute("type", "hidden");
			 						data.setAttribute("value", arr[i]);
			 						data.setAttribute("name", "selDeal");
			 						form.appendChild(data);
			 					}
			 					return true;
						     }
						}
						return false;
					}
   				</script>				
   			</div>	
		</div>
	</div>
	
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
	
	<%@ include file="/WEB-INF/views/common/ad.jsp" %>

</body>
</html>