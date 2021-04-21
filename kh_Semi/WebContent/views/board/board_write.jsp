<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
				<form>
					<font style="font-weight: bold; font-size: 33px; margin-left: 35px;">게시판 글쓰기</font>
					<button id="write">등록</button>
					<br>
					<br>
					<hr style="margin-left: 35px; width: 900px;">
					<br><br>
					
					<input type="text" style="height:40px;" placeholder="제목을 입력하세요">
					<br><br>
	
					<font style="font-weight: bold; font-size: 20px; margin-left: 35px; margin-right: 35px; color: gray;">첨부파일</font>
					<input type="file" id="file" name="file" multiple>	
					<br><br>
					<textarea placeholder="내용을 입력하세요."></textarea>
						
					<br><br>
					<button id="list">목록</button>
				</form>	
			</div>
		</div>
	</div>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
	
	<%@ include file="/WEB-INF/views/common/ad.jsp" %>
</body>
</html>