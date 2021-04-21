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
<link rel="stylesheet" type="text/css" href="<%=context%>/resources/css/product_detail.css">


</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div id="content-area">
			<%@ include file="/WEB-INF/views/common/nav.jsp"%>

			<div id="content">
				<span id="title"><b>중고 물품 보기</b></span>
				<div id="product-box">
					<div id="product-header">
						<br>
						<p id="category">기타</p>
						<span id="main-inform"><b>나이키 신발 팔아요</b></span> <br>
						<p id="explain">
							게시자 : <span>도대담</span><br> 등급 - <span>드론</span>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							게시일 : <span>2020.09.23</span>
						</p>
						<hr>
					</div>
					<div>
						<div id="product-body1">
							<img src="../images/ad1.jpg" width="300px" height="200px">
							<div id="product-inform">
								<h2>판매</h2>
								<p>
									이거 파는물건 이에요. @@@@@@@<br> <span id="dd">가격 :</span>
									&nbsp;&nbsp;&nbsp;&nbsp; 119, 000원<br> <span id="dd">판매자
										정보</span> &nbsp;&nbsp;&nbsp;&nbsp; 카톡 : domado123 <br> <span
										id="dd">배송 방법</span> &nbsp;&nbsp;&nbsp;&nbsp; 직거래 <br> <span
										id="dd">상품 상태</span> &nbsp;&nbsp;&nbsp;&nbsp; 거의 새 것 <br>
								</p>
							</div>
						</div>
					</div>
					<hr>
					<div id="product-body2">
						<img src="../images/ad1.jpg" width="300px" height="220px">
					</div>
					<br>
					<p>
						직거래는 어디든 가능하고 흥정 가능해요. 연락 주세요~ <span id="bookmark">상품
							찜하기&nbsp; <input type="checkbox">
						</span>
					</p>
					<br>

					<hr>
					<br>
					<div id="product-footer">
						<div id="condition-area">
							<p id="explain">댓글</p>
							<button class="btn" id="sell">판매 중</button>
							<button class="btn" id="btn-finish">거래 완료</button>
							<div id="comment">댓글영역</div>
						</div>

						<br>
						<textarea id="comment" cols="90" rows="8"
							placeholder="글을 입력해 주세요."></textarea>
						<button onclick="enroll();" id="enroll">등록</button>
						<script>
							function enroll() {
								var enroll = confirm("등록하시겠습니까?")

								if (enroll) {

								} else {

								}
							}
						</script>
					</div>
				</div>

				<div>
					<input type="button" class="my-btn" value="삭제" onclick="remove();">
					<script>
						function remove() {
							var del = confirm("진짜?")

							if (del) {

							} else {

							}
						}
					</script>
					<input type="button" class="my-btn" value="수정" onclick="change();">
					<script>
						function change() {
							alert("수정페이지로 가는 기능넣기")
						}
					</script>
				</div>
			</div>
		</div>
	</div>

	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>

	<%@ include file="/WEB-INF/views/common/ad.jsp"%>
</body>
</html>