<%@page import="board.model.vo.PageInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/resources/globalVariable.jsp" %>
<%@ page import="java.util.ArrayList, product.model.vo.*" %>
<%
	ArrayList<Deal> RdealList = (ArrayList<Deal>) request.getAttribute("RdealList");
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
							
				<h1>거래 조회</h1>
				
				<br><br>
				
				<div id="mm">
					<form action="<%= context %>/RDealOkay.do" method="post" onsubmit="return okayDeal(this);">
						<input type ="submit" id ="okay" value ="승낙">
					</form>	
						
					<form action="<%= context %>/RDealDelete.do" method="post" onsubmit="return refuseDeal(this);">
						<input type ="submit" id ="refuse" value ="거절">
					</form>
				</div>
				
				<br><br><br>
				
				<form>
					<table id = "dealTable" border = 1>
						<tr>
							<th width = 5%><!-- <input type="checkbox" name="selectAll" id="all"> --></th>
							<th width = 15%>보낸사람</th>
							<th width = 50%>상품제목</th>
							<th width = 20%>날짜</th>
						</tr>
						<% if(RdealList.isEmpty()){ %>
						<tr>
							<td colspan="5">받은 거래요청이 없습니다.</td>
						</tr>
						<% } else { %>
							<% for(Deal m : RdealList) { %>
						<tr>
							<td>
								<input type="checkbox" name="selDeal" onclick="selectOne(this);" value='<%= m.getProductId() %>/<%= m.getReceiver() %>'>
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
					<button onclick="location.href='<%= request.getContextPath() %>/receiveP.do?currentPage=1'" align="center"> &lt;&lt;</button>
					
					<!-- 이전 페이지로 -->
					<button onclick="location.href='<%= request.getContextPath() %>/receiveP.do?currentPage=<%= currentPage - 1 %>'"
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
							<button id="numBtn" onclick="location.href='<%= request.getContextPath() %>/receiveP.do?currentPage=<%= p %>'"><%= p %></button>
						<% } %>
					<% } %>
					
					<!-- 다음 페이지로 -->
					<button onclick="location.href='<%= request.getContextPath() %>/receiveP.do?currentPage=<%= currentPage + 1 %>'"
							id="afterBtn">&gt;</button>
					<script>
						if(<%= currentPage %> >= <%= maxPage %>){
							var after = $('#afterBtn');
							after.attr('disabled', 'true');
						}
					</script>
					<!-- 맨 끝으로 -->
					<button onclick="location.href='<%= request.getContextPath() %>/receiveP.do?currentPage=<%= maxPage %>'">&gt;&gt;</button>
				</div>

	   			<script>
			    	function send(){
			    		window.open('okayRDealForm.do', 'okayRDeal', 'width=450, height=400'); 
			      	}

					var all = document.getElementById("all");
					var selDeal = document.getElementsByName("selDeal");	
					
					function selectOne(e){
						var value = e.value.split('/');
						for(var i = 0; i < selDeal.length; i++){
							if(selDeal[i].value.split('/')[0] == value[0] && selDeal[i].value.split('/')[1] != value[1] && selDeal[i].checked) {
								selDeal[i].checked = false;
							}
						}
					}
					
			      	$(function(){
			      		$('#dealTable td[name=td]').click(function(){
			      			var num = $(this).parent().first().find('input').val().split('/')[0];
							location.href='<%= request.getContextPath() %>/pdetail.pro?option=0&pId=' + num;
			      		});
			      	});
			      	
			      	
			      	// 거절 기능
			      	function refuseDeal(form){
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
							alert('거절할 상품을 선택해주세요.');
						} else {
						    if(confirm("정말 거절하시겠습니까?")){
			 					for(var i = 0; i < arr.length; i++) {
			 						var dataArr = arr[i].split('/');
			 						var data = document.createElement('input');
			 						data.setAttribute("type", "hidden");
			 						data.setAttribute("value", dataArr[0]);
			 						data.setAttribute("name", "selDeal");
			 						var id = document.createElement('input');
			 						id.setAttribute("type", "hidden");
			 						id.setAttribute("value", dataArr[1]);
			 						id.setAttribute("name", "dealId");
			 						form.appendChild(data);
			 						form.appendChild(id);
			 					}
			 					return true;
						     }
						}
						return false;
					}
			      	
			      	
			     	//승낙 기능
			      	function okayDeal(form) {
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
							alert('승낙할 상품을 선택해주세요.');
						} else {
						    if(confirm("정말 승낙하시겠습니까? 해당 상품은 숨김 상태로 변경됩니다.")) {
			 					for(var i = 0; i < arr.length; i++) {
			 						var dataArr = arr[i].split('/');
			 						var data = document.createElement('input');
			 						data.setAttribute("type", "hidden");
			 						data.setAttribute("value", dataArr[0]);
			 						data.setAttribute("name", "selDeal");
			 						var id = document.createElement('input');
			 						id.setAttribute("type", "hidden");
			 						id.setAttribute("value", dataArr[1]);
			 						id.setAttribute("name", "dealId");
			 						form.appendChild(data);
			 						form.appendChild(id);
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