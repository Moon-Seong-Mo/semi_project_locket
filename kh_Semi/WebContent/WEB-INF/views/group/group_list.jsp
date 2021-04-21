<%@page import="group.model.vo.PageInfo"%>
<%@page import="group.model.vo.Group"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ArrayList<Group> list = (ArrayList<Group>) request.getAttribute("list");
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
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/board_list.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<div id="content-area">
			<%@ include file="/WEB-INF/views/common/nav.jsp" %>
			
			<div id="content">
			<br>
			<h1>공동구매 목록조회</h1>
			<% if(loginMember != null && loginMember.getRankCode() == 99) { %>	
			<input type="submit" id="obj" value="물품 등록" onclick="location.href='groupWriteForm.do';">
			<% } %>
					<div class="board_list_wrap">
						<table class="board_list">
							<thead>
								<tr>
									<th>번호</th>
									<th>물품명</th>
									<th>시작일</th>
									<th>종료일</th>
									<th>작성자</th>
									<th>작성일</th>
								</tr>
							</thead>
							<tbody>
							<% if(list.isEmpty()){ %>
							<tr>
								<td colspan="6">등록된 물품이 없습니다.</td>
							</tr>
				  			<% } else {%>	
				  			<%		for(Group g : list) { %>
								<tr>
									<td><%= g.getGroupNum() %></td>

									<td onclick="listDetail(<%= g.getGroupNum() %>);"><%= g.getGroupTitle() %></td>
									
									<td><%= g.getStartDate() %></td>
									<td><%= g.getEndDate() %></td>
									<td><%= g.getNickName() %></td>
									<td><%= g.getgDate() %></td>
								</tr>
								<%    } %>
								<% } %>
							</tbody>
						</table><br>
						
						<form action="groupSearch.do" method="get" class="boardForm">  
						
						<br>
						
						<select name="searchOption">
							<option value="TITLE">제목</option>
							<option value="EXPLAIN">내용</option>
							<option value="MEMBERNAME">작성자</option>
						</select>
						<input type="text" name="word" size="20" placeholder="검색어를 입력해주세요">
						<button id="search" type="submit">검색</button> 
						
					</form>
					
					<script>
						var context = document.location.href.split("?");
						if(typeof context[1] == "undefined") {
							context[1] = "";
						} else {
							context[1] = "&" + context[1].replace(/currentPage=\d{0,}/g, "").replace(/&{0,}/, "");
							console.log(context[1].replace(/currentPage=\d{0,}/g, "").replace(/&{0,}/, ""));
						}
					</script>
					<br><br>
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
	
	<script>
	function listDetail(num) {
		<% if(loginMember != null) { %>
		location.href = "<%= context %>/groupDetail.do?bnum=" + num;
		<% } else { %>
			alert('죄송합니다. 회원만 상세보기가 가능합니다!');
		<% } %>
	}
	
	
	</script>
</body>
</html>