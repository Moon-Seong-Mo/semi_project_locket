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
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/my_store.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<div id="content-area">
			<%@ include file="/WEB-INF/views/common/nav.jsp" %>
			
			<div id ="content">
				<h1>내 상점</h1>
				
				<br><br>
				
				<div id="item-list">
					<div class="item">
						<a href="#"> <img alt="상품" src="<%= context %>/resources/images/rocket.png"> 
							<span>내가등록한거1</span> <span>32000원</span>
						</a>
					</div>
					<div class="item">
						<a href="#"> <img alt="상품" src="<%= context %>/resources/images/rocket.png"> 
							<span>1.마스크</span> <span>abcd님의 상품</span>
						</a>
					</div>
					<div class="item">
						<a href="#"> <img alt="상품" src="<%= context %>/resources/images/rocket.png"> 
							<span>1.마스크</span> <span>abcd님의 상품</span>
						</a>
					</div>
					<div class="item">
						<a href="#"> <img alt="상품" src="<%= context %>/resources/images/rocket.png"> 
							<span>1.마스크</span> <span>abcd님의 상품</span>
						</a>
					</div>
					<div class="item">
						<a href="#"> <img alt="상품" src="<%= context %>/resources/images/rocket.png"> 
							<span>1.마스크</span> <span>abcd님의 상품</span>
						</a>
					</div>
					<div class="item">
						<a href="#"> <img alt="상품" src="<%= context %>/resources/images/rocket.png"> 
							<span>1.마스크</span> <span>abcd님의 상품</span>
						</a>
					</div>
					
					<!--  7번쨰부터는 뒷페이지에 나오도록 하기 -->
<!-- 					<div class="item"> -->
<!-- 						<a href="#"> <img alt="상품" src="../resources/images/rocket.png">  -->
<!-- 							<span>1.마스크</span> <span>abcd님의 상품</span> -->
<!-- 						</a> -->
<!-- 					</div> -->
				</div>
			</div>
		</div>
	</div>
	<!-- 페이징 처리 하기 -->
	
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
	
	<%@ include file="/WEB-INF/views/common/ad.jsp" %>
</body>
</html>
			