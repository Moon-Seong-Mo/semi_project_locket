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
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/board.css">
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<div id="content-area">
			<%@ include file="/WEB-INF/views/common/nav.jsp" %>
			
			<div id="content">
				<div class="b_detail">
					<br>
					<font style="font-weight: bold; font-size: 15px; color: rgb(0, 211, 0); padding-left: 10px;">자유 게시판 >></font>
					<br><br>
					<font style="font-size: 30px; padding-left:10px;">멋쟁이 토마토 요즘 파나요?</font><br>
					<img src="../images/user.png" style="padding-left: 10px; witdh: 45px; height: 45px">
					<font style="font-weight: bold; font-size: 17px;">브롤 꿈나무</font>
					<font style="font-size: 15px; padding-left: 5px; color: gray;">비행기 회원</font>
					<button id="note">쪽지보내기</button>
					
					<br><br>
					<hr style="margin-left:15px; margin-right:10px;"><br>
					
					<div id="b_contents">안녕하세요 여기는 내용입니다</div>
					<div id="b_comments">
					<br>
					<br><hr><br>
					<h3>댓글</h3>
					<br>
					<div id="b_read_comments"> <!-- 여기에 댓글 입력될떄마다 추가 되야함 -->
						<img src="../images/user.png" style="padding-left: 10px; witdh: 45px; height: 45px">
						<font>다른유저1</font>
						<br>
						<font style="padding-left: 60px;">댓글 내용입니다 댓글내용입니다. 댓글댓글</font>
						<br>
						<font style="color: gray; font-size: 10px; padding-right: 20px; padding-left: 60px;">2019.09.09 16:08</font>
						<a href="#" id="report">댓글 제지</a>
					</div>
					
					<!-- 여긴 댓글 쓰는 공간 -->
					<div id="b_write_comment" style="width: 850px; height: 200px;">
						<br>
						<font style="font-weight: bold; font-size: 17px; color: red;">관리자</font>
						<textarea style="width: 850px; height: 110px; resize: none; margin-left: 5px;"></textarea>
						<button id="button1" style="background: gray;">글 목록</button>					
						<button id="button1" style="background: rgb(223,72,0);">글 제지</button>
						<button id="button1" style="margin-left: 620px;">등록</button>				
					</div>			
				</div>
			</div>
			</div>
		</div>
	</div>
	
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
</body>
</html>