<%@page import="apply.model.vo.PageInfo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="apply.model.vo.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%
	ArrayList<Apply> cList = (ArrayList<Apply>) request.getAttribute("cList");
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
<title>로컬마켓</title>
<%@ include file="/resources/globalVariable.jsp" %>

<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/base.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/content-area.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/content.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/buy_list.css">
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<div id="content-area">
			<%@ include file="/WEB-INF/views/common/nav.jsp" %>
			
			<div id="content">
			<br>
			<h1>구매 목록 조회 </h1>
				<div class="board_list_wrap">
					<table class="board_list">
						<thead>
							<tr>
								<th>상품 번호</th>
								<th>상품 명</th>
								<th>수량</th>
								<th>가격</th>
								<th>배송지</th>
								<th>신청일</th>
								<th>거래 번호</th>
							</tr>
						</thead>
						<tbody>
						<% if(cList.isEmpty()) { %>
							<tr>
								<td colspan="7">신청 인원이 없습니다.</td>
							</tr>
							<% }else { %>
							<% 		for(Apply a : cList) {%>
								<tr>
									<td><%= a.getgNum() %></td>
									<td id="group_title" onclick='location.href = "<%= context %>/groupDetail.do?bnum=" + <%=a.getgNum() %>;'><%= a.getTitle() %></td>
									<td><%= a.getAmountNum() %></td>
									<td><%= a.getAmount() %></td>
									<td><%= a.getAddress() %></td>
									<td><%= a.getApply_date() %></td>
									<td><%= a.getMerchant_uid() %></td>
								</tr>
								<%	 } %>
								<% } %>
						</tbody>
					</table><br>
					<!-- <form action="applySearch.do" method="get" class="boardForm">
						<br>
						<select name="searchOption">
							<option value="group_num">상품 번호</option>
							<option value="MERCHANT_UID">결제 번호</option>
							<option value="MEMBER_ID">구매자</option>
						</select>
						<input type="text" name="word" size="20" placeholder="검색어를 입력해주세요">
						<button id="search" type="submit">검색</button> 
						
					</form> -->
					<script>
						var context = document.location.href.split("?");
						if(typeof context[1] == "undefined") {
							context[1] = "";
						} else {
							context[1] = "&" + context[1].replace(/currentPage=\d{0,}/g, "").replace(/&{0,}/, "");
							console.log(context[1].replace(/currentPage=\d{0,}/g, "").replace(/&{0,}/, ""));
						}
					</script>
					
					<div class="paging" align="center">

						<button onclick="location.href=context[0] + '?currentPage=1' + context[1]">&lt;&lt;</button>
						
						<button onclick="location.href=context[0] + '?currentPage=<%= currentPage - 1 %>' + context[1]" id="beforeBtn">&lt;</button>
						<script>
							if(<%= currentPage %> <= 1) {
								var before = document.getElementById("beforeBtn");
								before.setAttribute('disabled', 'true');
							}
						</script>
						
						<% for(int p = startPage; p <= endPage; p++) { %>
							<% if(p == currentPage) { %>
								<button id="choosen" disabled><%= p %></button>
							<% } else { %>
								<button id="numBtn" onclick="location.href=context[0] + '?currentPage=<%= p %>' + context[1]"><%= p %></button>
							<% } %>
						<% } %>
						
						<button onclick="location.href=context[0] + '?currentPage=<%= currentPage + 1 %>' + context[1]" id="afterBtn">&gt;</button>
						<script>
							if(<%= currentPage %> >= <%= maxPage %>) {
								var after = document.getElementById("afterBtn");
								after.setAttribute('disabled', 'true');
							}
						</script>
						
						<button onclick="location.href=context[0] + '?currentPage=<%= maxPage %>' + context[1]">&gt;&gt;</button>
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