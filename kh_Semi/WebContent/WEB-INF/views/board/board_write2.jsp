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
<script src="<%= context %>/resources/js/jquery-3.5.1.min.js"></script>
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<div id="content-area">
			<%@ include file="/WEB-INF/views/common/nav.jsp" %>
			
			<div id="content">
				<form action="boardWrite.do" method="post" encType="multipart/form-data" id="boardWrite">
					<font style="font-weight: bold; font-size: 33px; margin-left: 35px;">게시판 글쓰기</font>
					<button id="write" type="button">등록</button>
					<br>
					<br>
					<hr style="margin-left: 35px; width: 900px;">
					<br><br>
					
					<input type="text" name="title" placeholder="제목을 입력하세요">
					<br><br>
					<div id="setFile">
						<div id="filetext">첨부파일</div>
						<input type="file" id="file" name="file" multiple>
					</div>
					<br><br>
					<textarea name="content" placeholder="내용을 입력하세요."></textarea>
						
					<br><br>
					<button type="button" id="list" onclick="location.href='<%= context %>/boardList.do'">목록</button>
				</form>	
			</div>
		</div>
	</div>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
	
	<%@ include file="/WEB-INF/views/common/ad.jsp" %>
	
	<script>
 		var submitBtn = document.getElementById('write');
		submitBtn.onclick = function() {
			var form = document.getElementById('boardWrite');
			var formData = new FormData(form);
			formData.delete('file');
			
			var files = document.getElementById('file').files;
			
			var count = files.length;
			for(var i = 0; i < count; i++) {
				formData.append("file" + i, files[i]);
			}
			
			form.setFormData(formData);
			
			var xhr = new XMLHttpRequest();

			xhr.onreadystatechange = function() {
			    if (this.readyState == 4 && this.status == 200) {
			    	if(eval(this.responseText)) {
			    		alert("게시글이 작성되었습니다.");
			    		location.href = "boardList.do";
			    	} else {
			    		alert("게시글 작성에 실패하였습니다. 다시 시도하세요");
			    	}
			    }
			};
		 	xhr.open("POST", "boardWrite.do", false);
			xhr.send(formData);

		};
		

	</script>
</body>
</html>