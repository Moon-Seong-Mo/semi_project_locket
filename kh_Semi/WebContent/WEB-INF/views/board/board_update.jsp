<%@page import="board.model.vo.Attachment"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.model.vo.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Board b = (Board) request.getAttribute("board");
	ArrayList<Attachment> flist = (ArrayList<Attachment>) request.getAttribute("fileList");
%>
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
				<form action="boardUpdate.do" method="post" encType="multipart/form-data" id="boardUpdate" onsubmit="return boardUpdate(this);">
					<font style="font-weight: bold; font-size: 33px; margin-left: 35px; float: left;">게시글 수정</font>
					
					<br>
					<br>
					<hr style="margin-left: 35px; width: 900px;">
					<br><br>
					<input type="hidden" name="bnum" value="<%= b.getBoardNum() %>">
					<input type="text" id="title" name="title" placeholder="제목을 입력하세요" value="<%= b.getBoardTitle() %>">
					<br><br>
					<div id="fileField">
						<div id="filetext" style="height: <%= 28 + flist.size() * 26 %>px;">첨부파일</div>
						<% for(int i = 0; i < flist.size(); i++) { %>
						<div id="setFile-<%= i %>" style="display: flex;">
							<input class="exfile" name="setFile_<%= i %>" type="hidden" value="<%= flist.get(i).getFileId() %>">
							<a href="<%= context %>/board_uploadFiles/<%= flist.get(i).getChangeName() %>" download="<%= flist.get(i).getOriginName() %>" style="display: contents;">
								<input type="text" style="display: inline-block; float: left;" onchange="changeFile(this);" readonly value="<%= flist.get(i).getOriginName() %>">
							</a>
							<input name="fileDel" type="button" value="삭제" style="display: inline-block; float: left;" onclick="delFile('setFile-<%= i %>');">
						</div>
						<% } %>
						<div id="setFile">
							<input type="file" id="file" name="file" onchange="changeFile(this);">
						</div>
					</div>
					<br><br>
					<textarea id="boardContent" name="content" placeholder="내용을 입력하세요." <%= b.getBoardContent() %>><%= b.getBoardContent() %></textarea>
						
					<br><br>
					<button type="button" id="list" onclick="location.href='<%= context %>/boardList.do'">목록</button>
					<button id="write" type="submit">등록</button>
				</form>	
			</div>
		</div>
	</div>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
	
	<%@ include file="/WEB-INF/views/common/ad.jsp" %>
	
	
</body>
<script src="<%= context %>/resources/js/boardFile.js"></script>
</html>