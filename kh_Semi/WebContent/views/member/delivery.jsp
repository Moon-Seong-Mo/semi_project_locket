<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로컬마켓</title>
<%@ include file="/resources/globalVariable.jsp"%>

<link rel="stylesheet" type="text/css" href="<%=context%>/resources/css/base.css">
<link rel="stylesheet" type="text/css" href="<%=context%>/resources/css/content-area.css">
<link rel="stylesheet" type="text/css" href="<%=context%>/resources/css/content.css">
<link rel="stylesheet" type="text/css" href="<%=context%>/resources/css/delivery.css">
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div id="content-area">
			<%@ include file="/WEB-INF/views/common/nav.jsp"%>


			<div>
				<h1>배송지 관리</h1>
			</div>
			<br>
			<br>
			<hr>
			<div id="content">
				<div>
					<table id="delivery-table">
						<tr id="delivery-table-top">
							<th>받는분</th>
							<th>주소</th>
							<th>연락처</th>
							<th>배송지 명</th>
						</tr>
						<tr>
							<td><input type="checkbox" id="checkbox"> 박마켓</td>
							<td>서울시 강남구 역삼동</td>
							<td>02-666-7777</td>
							<td>집</td>
						</tr>
						<tr>
							<td><input type="checkbox" id="checkbox"> 박마켓2</td>
							<td>서울시 구로구 고척동</td>
							<td>010-1111-2222</td>
							<td>회사</td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</table>
				</div>

				<button id="btn2">삭제하기</button>
				<button id="btn1" onclick="add();">추가하기</button>
				<script>
					function add() {
						prompt("여기에 기능을 어떻게하지", "어떻게 해야할까")
					}
				</script>
				<br> <br> <br> <br> <br> <br> <br>
				<br> <br> <br> <br> <br> <br>
			</div>
		</div>
	</div>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>

	<%@ include file="/WEB-INF/views/common/ad.jsp"%>
</body>
</html>