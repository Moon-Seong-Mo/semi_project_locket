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
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/board_list.css">

</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<div id="content-area">
			<%@ include file="/WEB-INF/views/common/nav.jsp" %>
			
			<div id ="content"><h1>자유게시판</h1></div><br><br><hr>
			<div id="board2">
				<div class="board_list_wrap">
					<table class="board_list">
						<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>조회</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><button class="button">공지</button></td>
								<td><a href="#" style="color:red"><b>회원님들은 모두 이 공지사항을 필독 해주시길 바랍니다.</b></a></td>
								<td>관리자</td>
								<td>2019-11-20</td>
								<td>5555</td>
							</tr>
							<tr>
								<td><button class="button">공지</button></td>
								<td><a href="#" style="color:red"><b>[안내] 이곳은 거래 게시판이 아닙니다. 소통만 해주세요</b></a></td>
								<td>관리자</td>
								<td>2019-11-20</td>
								<td>5555</td>
							</tr>
							<tr>
								<td>1353434</td>
								<td><a href="#" style="color:black">안녕하세요 ~ 세미프로젝트 하기가 너무 빡세네요 ㅠㅠ</a></td>
								<td>강건강</td>
								<td>2019-11-20</td>
								<td>5555</td>
							</tr>
							<tr>
								<td>1353434</td>
								<td><a href="#" style="color:black">안녕하세요 ~ 세미프로젝트 하기가 너무 빡세네요 ㅠㅠ</a></td>
								<td>강건강</td>
								<td>2019-11-20</td>
								<td>5555</td>
							</tr>
							<tr>
								<td>1353434</td>
								<td><a href="#" style="color:black">안녕하세요 ~ 세미프로젝트 하기가 너무 빡세네요 ㅠㅠ </a></td>
								<td>강건강</td>
								<td>2019-11-20</td>
								<td>5555</td>
							</tr>
							<tr>
								<td>1353434</td>
								<td><a href="#" style="color:black">안녕하세요 ~ 세미프로젝트 하기가 너무 빡세네요 ㅠㅠ </a></td>
								<td>강건강</td>
								<td>2019-11-20</td>
								<td>5555</td>
							</tr>
							<tr>
								<td>1353434</td>
								<td><a href="#" style="color:black">안녕하세요 ~ 세미프로젝트 하기가 너무 빡세네요 ㅠㅠ </a></td>
								<td>강건강</td>
								<td>2019-11-20</td>
								<td>5555</td>
							</tr>
							<tr>
								<td>1353434</td>
								<td><a href="#" style="color:black">안녕하세요 ~ 세미프로젝트 하기가 너무 빡세네요 ㅠㅠ </a></td>
								<td>강건강</td>
								<td>2019-11-20</td>
								<td>5555</td>
							</tr>
							<tr>
								<td>1353434</td>
								<td><a href="#" style="color:black">안녕하세요 ~ 세미프로젝트 하기가 너무 빡세네요 ㅠㅠ </a></td>
								<td>강건강</td>
								<td>2019-11-20</td>
								<td>5555</td>
							</tr>
							<tr>
								<td>1353434</td>
								<td><a href="#" style="color:black">안녕하세요 ~ 세미프로젝트 하기가 너무 빡세네요 ㅠㅠ </a></td>
								<td>강건강</td>
								<td>2019-11-20</td>
								<td>5555</td>
							</tr>
							<tr>
								<td>1353434</td>
								<td><a href="#" style="color:black">안녕하세요 ~ 세미프로젝트 하기가 너무 빡세네요 ㅠㅠ </a></td>
								<td>강건강</td>
								<td>2019-11-20</td>
								<td>5555</td>
							</tr>
							<tr>
								<td>1353434</td>
								<td><a href="#" style="color:black">안녕하세요 ~ 세미프로젝트 하기가 너무 빡세네요 ㅠㅠ </a></td>
								<td>강건강</td>
								<td>2019-11-20</td>
								<td>5555</td>
							</tr>
							<tr>
								<td>1353434</td>
								<td><a href="#" style="color:black">안녕하세요 ~ 세미프로젝트 하기가 너무 빡세네요 ㅠㅠ </a></td>
								<td>강건강</td>
								<td>2019-11-20</td>
								<td>5555</td>
							</tr>
						</tbody>
					</table><br>
					<input type="text" size="20" placeholder="검색어를 입력해주세요">
					<button id="search">검색</button> 
					<input type="button" id="obj" value="공지 쓰기"> <br><br><br>
						
					<div class="paging">
						<a href="#">&lt;</a>
						<a href="#">1</a>
						<a href="#">2</a>
						<a href="#">3</a>
						<a href="#">4</a>
						<a href="#">></a>
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