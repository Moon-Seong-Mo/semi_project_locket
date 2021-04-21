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
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/group_list.css">

</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<div id="content-area">
			<%@ include file="/WEB-INF/views/common/nav.jsp" %>
			
			<div id="content">
				<div id="group">
					<h1>공동구매<input type="button" value="일정관리" class="button"></h1> 
					<br>
					<hr>
					<div class="board_list_wrap">
						<table class="board_list">
							<thead>
								<tr>
									<th>No.</th>
									<th>물품명</th>
									<th>시작일</th>
									<th>종료일</th>
									<th>게시자</th>
									<th>게시일</th>
									<th>신청자 수</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td>KF 94 마스크</td>
									<td>2020.09.16</td>
									<td>2020.09.20</td>
									<td>MaskMan</td>
									<td>2020.09.15</td>
									<td>5</td>
								</tr>
								<tr>
									<td>2</td>
									<td>추석 한우 명절 세트</td>
									<td>2020.09.13</td>
									<td>2020.09.16</td>
									<td>흑우</td>
									<td>2020.09.12</td>
									<td>14</td>
								</tr>
								<tr>
									<td>3</td>
									<td>스타벅스 텀블러</td>
									<td>2020.09.02</td>
									<td>2020.09.07</td>
									<td>스벅이조아</td>
									<td>2020.09.06</td>
									<td>4</td>
								</tr>
								<tr>
									<td>4</td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td>5</td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td>6</td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td>7</td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td>8</td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td>9</td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td>10</td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td>11</td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td>12</td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td>13</td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
							</tbody>
						</table><br>
						
						<div class="paging">
							<a href="#"><</a>
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
	</div>
	
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
	
	<%@ include file="/WEB-INF/views/common/ad.jsp" %>
</body>
</html>