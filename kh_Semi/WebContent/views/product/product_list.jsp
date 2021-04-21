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
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/product_list.css">

</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<div id="content-area">
			<%@ include file="/WEB-INF/views/common/nav.jsp" %>
			
			<div id="content">
				<span id="title">중고 물품 보기</span>
				<select name="category" id="drop">
					<option value="">카테고리 별로 보기</option>
					<option value="의류">의류</option>
					<option value="의류">가구</option>
					<option value="의류">기타</option>
				</select>			
				<select name="rank" id="drop">
					<option value="">등급 별로 보기</option>
					<option value="드론">드론</option>
					<option value="비행기">비행기</option>
					<option value="로켓">로켓</option>
				</select>
				<input type="button" value="상품 관리" id="product-manage">			
				<div id="list">
					<div id="list-top">
						<div id="product1" class="product">
							<a href=#>
								<img src="../images/ad1.jpg" width ="150px" height= "150px">
							</a>
							<p>에어 조던1 미착용 상...</p><br>
							<span id="price">119,000원</span>
							<p id="explain">
								강건강<br>
								등록 날짜  &nbsp;&nbsp; 조회 count 
							</p>
						</div>
						<div id="product2" class="product">
							<a href=#>
								<img src="../images/kh.png" width ="150px" height= "150px">
							</a>
							<p id="">kh3층 사용감 x...</p><br>
							<span id="price">9,000원</span>
							<p id="explain">
								박임대<br>
								등록 날짜  &nbsp;&nbsp; 조회 count 
							</p>
						</div>
						<div id="product3" class="product">
							<a href=#>
								<img src="../images/rocket.png" width ="150px" height= "150px">
							</a>
							<p>로켓 보이저1호 미발사...</p><br>
							<span id="price">999,000원</span>
							<p id="explain">
								마이클<br>
								등록 날짜  &nbsp;&nbsp; 조회 count 
							</p>
						</div>
						<div id="product4" class="product">
							<a href=#>
								<img src="../images/ad1.jpg" width ="150px" height= "150px">
							</a>
							<p>에어 조던1 미착용 상...</p><br>
							<span id="price">119,000원</span>
							<p id="explain">
								강건강<br>
								등록 날짜  &nbsp;&nbsp; 조회 count 
							</p>
						</div>
						<div id="product5" class="product">
							<a href=#>
								<img src="../images/ad1.jpg" width ="150px" height= "150px">
							</a>
							<p>에어 조던1 미착용 상...</p><br>
							<span id="price">119,000원</span>
							<p id="explain">
								강건강<br>
								등록 날짜  &nbsp;&nbsp; 조회 count 
							</p>
						</div>
						<div id="product6" class="product">
							<a href=#>
								<img src="../images/ad1.jpg" width ="150px" height= "150px">
							</a>
							<p>에어 조던1 미착용 상...</p><br>
							<span id="price">119,000원</span>
							<p id="explain">
								강건강<br>
								등록 날짜  &nbsp;&nbsp; 조회 count 
							</p>
						</div>
						<div id="product7" class="product">
							<a href=#>
								<img src="../images/ad1.jpg" width ="150px" height= "150px">
							</a>
							<p>에어 조던1 미착용 상...</p><br>
							<span id="price">119,000원</span>
							<p id="explain">
								강건강<br>
								등록 날짜  &nbsp;&nbsp; 조회 count 
							</p>
						</div>
						<div id="product8" class="product">
							<a href=#>
								<img src="../images/ad1.jpg" width ="150px" height= "150px">
							</a>
							<p>에어 조던1 미착용 상...</p><br>
							<span id="price">119,000원</span>
							<p id="explain">
								강건강<br>
								등록 날짜  &nbsp;&nbsp; 조회 count 
							</p>
						</div>
					</div>
				
					<br>
					<div>
						<select name="date" id="drop">
						<option value="">전체 기간</option>
						<option value="1일">1일</option>
						<option value="1주일">1주일</option>
						<option value="1개월">1개월</option>
						<option value="6개월">6개월</option>
						<option value="1년">1년</option>
						</select>
						<select name="sort" id="drop">
						<option value="">제목+내용</option>
						<option value="제목">제목</option>
						<option value="작성자">작성자</option>
						<option value="댓글내용">댓글내용</option>
						<option value="댓글작성자">댓글 작성자</option>
						</select>
						<input type="text" id="search-text">
						<button id="searching">검색</button>
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