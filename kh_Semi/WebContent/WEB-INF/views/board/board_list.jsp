<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.model.vo.PageInfo"%>
<%@page import="board.model.vo.Board"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ArrayList<Board> nlist = (ArrayList<Board>) request.getAttribute("nlist");
	ArrayList<Board> list = (ArrayList<Board>) request.getAttribute("list");
	PageInfo pi = (PageInfo) request.getAttribute("pi");
	
	int listCount = pi.getListCount();
	int currentPage = pi.getCurrentPage();
	int maxPage = pi.getMaxPage();
	int startPage = pi.getStartPage();
	int endPage = pi.getEndPage();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
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

</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<div id="content-area">
			<%@ include file="/WEB-INF/views/common/nav.jsp" %>
			
			<div id ="content">
				
				<br>
				
				<h1>자유게시판</h1>
				<% if(loginMember != null) { %>
				<input type="submit" id="obj" value="글쓰기" onclick="location.href='boardWriteForm.do';">
				<% } %>
				<div class="board_list_wrap">
					<table class="board_list">
						<thead>
							<tr>
								<th width="50px">번호</th>
								<th width="200px">제목</th>
								<th width="50px">작성자</th>
								<th width="100px">작성일</th>
								<th width="50px">조회수</th>
							</tr>
						</thead>
						<tbody>
						<% if(list.isEmpty() && (nlist == null || nlist.isEmpty())) { %>
						<tr>
							<td colspan="5">작성된 게시글이 없습니다.</td>
						</tr>
						<% } else { %>
							<% if(nlist != null) { %>
								<% for(Board b : nlist) { %>
									<tr class="notice">
										<td><%= b.getBoardNum() %></td>
										<td onclick="listDetail(<%= b.getBoardNum() %>);">[공지]<%= b.getBoardTitle() %></td></b>
										<td><%= b.getNickName() %></td>
										<td><%= sdf.format(b.getCreateDate()) %></td>
										<td><%= b.getBoardCount() %></td>
									</tr>
								<% } %>
							<% } %>
							<% for(Board b : list) { %>
								<tr>
									<td><%= b.getBoardNum() %></td>
									<td onclick="listDetail(<%= b.getBoardNum() %>);"><%= b.getBoardTitle() %></td>
									<td><%= b.getNickName() %></td>
									<td><%= sdf.format(b.getCreateDate()) %></td>
									<td><%= b.getBoardCount() %></td>
								</tr>
							<% } %>
						<% } %>
						</tbody>
					</table><br>
					<form action="boardSearch.do" method="get" class="boardForm">
						
						<br>
						
						<select name="searchOption">
							<option value="TITLE">제목</option>
							<option value="BOARD_C">내용</option>
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
					
					<br>
					<br>

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
			location.href = "<%= context %>/boardDetail.do?bnum=" + num;
		}
	</script>
</body>
</html>