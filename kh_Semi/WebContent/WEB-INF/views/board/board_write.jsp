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
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/board_write.css">

</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<div id="content-area">
			<%@ include file="/WEB-INF/views/common/nav.jsp" %>
			
			<div id="content">
				<form action="boardWrite.do" method="post" encType="multipart/form-data" id="boardWrite">
					<font style="font-weight: bold; font-size: 33px; margin-left: 35px; float:left;">게시판 글쓰기</font>
					
					<br>
					<br>
					<hr style="margin-left: 35px; width: 900px;">
					<% if(loginMember.getRankCode() == 99) { %>
					<div id="notice">
						<input type="checkbox" name="notice" value="true">공지사항
					</div>
					<% } %>
					<br>
					<br>
					
					<input type="text" id="title" name="title" placeholder="제목을 입력하세요">
					<br><br>
					<div id="fileField">
						<div id="filetext">첨부파일</div>
						<div id="setFile">
							<input type="file" id="file" name="file" onchange="changeFile(this);">
						</div>
					</div>
					<br><br>
					<textarea id="boardContent" name="content" placeholder="내용을 입력하세요."></textarea>
					
					<br><br>
					
					
					<div class="btnArea">			
						<input type="button" id="list" value ="목록으로" onclick="location.href='<%= context %>/boardList.do'">
						<button id="write" type="button" onclick="boardSubmit();">게시글 등록</button>
					</div>
				</form>	
			</div>
		</div>
	</div>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
	
	<%@ include file="/WEB-INF/views/common/ad.jsp" %>
	<script>
		function boardSubmit() {
			var title = document.getElementById("title").value.replace(/ /g,"");
			var content = document.getElementById("boardContent").value.replace(/ /g,"");
			
			if(title == "") {
				alert("제목을 입력하세요");
				return;
			} else if(content == "") {
				alert("내용을 입력하세요");
				return;
			}
			
			document.getElementById('boardWrite').submit();
			
		}
	</script>
</body>
<script src="<%= context %>/resources/js/jquery-3.5.1.min.js"></script>
<script src="<%= context %>/resources/js/boardFile.js"></script>
</html>