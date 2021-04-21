<%@page import="board.model.vo.PageInfo"%>
<%@page import="board.model.vo.Board"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로컬마켓</title>
<%@ include file="/resources/globalVariable.jsp" %>

<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/base.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/content-area.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/content.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/my_delivery.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<div id="content-area">
			<%@ include file="/WEB-INF/views/common/nav.jsp" %>
			
			<div id ="content">
				
				<br>
				
				<h1>나의 배송지</h1>
				<% if(loginMember != null) { %>
				<input type="submit" id="obj" value="추가하기" onclick="location.href='#';">
				<% } %>
				<div class="delivery_list_wrap">
					<table class="delivery_list">
						<thead>
							<tr>
								<th width="50px"><input type="checkbox"></th>
								<th width="100px">받는 분</th>
								<th width="200px">주소</th>
								<th width="130px">연락처</th>
								<th width="100px">배송지 명</th>
							</tr>
						</thead>
						<tbody>
<%-- 						<% if(list.isEmpty()) { %> --%>
						<tr>
							<td colspan="5">저장된 배송지가 없습니다.</td>
						</tr>
<%-- 						<% } else { %> --%>
<%-- 							<% for(Board b : list) { %> --%>
<!-- 								<tr> -->
<%-- 									<td><%= b.getBoardNum() %></td> --%>
<%-- 									<td onclick="listDetail(<%= b.getBoardNum() %>);"><%= b.getBoardTitle() %></td> --%>
<%-- 									<td><%= b.getNickName() %></td> --%>
<%-- 									<td><%= b.getCreateDate() %></td> --%>
<%-- 									<td><%= b.getBoardCount() %></td> --%>
<!-- 								</tr> -->
<%-- 							<% } %> --%>
<%-- 						<% } %> --%>
						</tbody>
					</table><br>
					
					<br>
					<br>

				</div>
				<div class="buttons">
					<input type="button" id="deleteBtn" value="삭제하기" onclick="#">
					<input type="submit" id="plusBtn" value="추가하기" onclick="#">
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