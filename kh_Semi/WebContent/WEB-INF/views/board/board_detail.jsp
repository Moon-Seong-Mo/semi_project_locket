<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.model.vo.Comment"%>
<%@page import="oracle.net.aso.f"%>
<%@page import="board.model.vo.Attachment"%>
<%@page import="java.util.ArrayList"%>
<%@page import="board.model.vo.Board"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	Board b = (Board) request.getAttribute("board");
	String contentText = b.getBoardContent();
	contentText = contentText.replaceAll("\r\n", "<br>");
	ArrayList<Attachment> flist = (ArrayList<Attachment>) request.getAttribute("fileList");
	ArrayList<Comment> clist = (ArrayList<Comment>) request.getAttribute("commentList");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
	
	String wfImageName = null;
	if(b.getpImage() != null) {
		File wf = new File(b.getpImage());
		wfImageName = wf.getName();
	}
	
	String cNum = (String) request.getAttribute("cNum");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로컬마켓</title>
<%@ include file="/resources/globalVariable.jsp"%>

<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/base.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/content-area.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/content.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/board.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/board_detail.css">

</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div id="content-area">
			<%@ include file="/WEB-INF/views/common/nav.jsp"%>

			<div id="content">
				<div class="b_detail">
					<br>
					<div id="menuname">
						자유게시판 >>
					</div>
					<div id="boardTitle">
						<%= b.getBoardLevel() == 0 ? "" : "[공지]" %><%= b.getBoardTitle() %>
					</div>
					<div id="infoBar">
						<div id="profile">
						<% if(wfImageName == null) { %>
							<label id="memberIcon" class="glyphicon glyphicon-user" style="top:15px; right: 30px;"></label>
						<% } else { %>
							<img src="<%= context %>/userProfile_uploadFiles/<%= wfImageName %>">
						<% } %>
						</div>
						<div id="profile_area">
							<div id="nickName"><%= b.getNickName() %></div>
							<div><%= b.getRankName() %></div>
						<% if(loginMember != null && !loginMember.getNickName().equals(b.getNickName())) { %>
                    	 <form name="sendmsg">
	                        <input type="hidden" name="userId" value="<%= b.getBoardWriter() %>">
	                        <input type="hidden" name="nickname" value="<%= b.getNickName() %>">
	                        <input type="button" id="sendmsg" value="쪽지 보내기" onclick="sendMessage();">
                   		 </form>
               		    <% } %>
							<br>
							<div id="createDate"><%= sdf.format(b.getCreateDate()) %></div>
							<div id="boardCount">조회수 <%= b.getBoardCount() %></div>
						</div>
					</div>
					
					<hr>
					
					<div id="boardContent">
					<%= contentText %>
					</div>
					<% if(loginMember != null) { %>
					<div class="btnArea">
						<% if(!loginMember.getId().equals(b.getBoardWriter())) { %>
               			<form method="post" name="reportVla"id="reportVla">
                  		 	<input type="hidden" name="pId" value="<%= b.getBoardNum()%>">
                 		 	<input type="hidden" name="writer" value="<%= b.getNickName() %>">
                 		 	<input type="hidden" name="writerId" value="<%= b.getBoardWriter()  %>">
                  			<a href="javascript:void(0);" onclick="reportSendForm('reportVla', '게시글 신고');"class="reportBtn">신고</a>
               			</form>       
           		 	<% } %> 
					</div>
					<% } %>
					<br><br><br><br>
					
					<% if(loginMember != null) { %>
					
					<% if(flist.size() > 0) { %>
					<h4>첨부파일</h4>
					
					<% for(int i = 0; i < flist.size(); i++) { %>
						<% Attachment at = flist.get(i); %>
						<a href="javascript:void(0);" onclick="fileDown(this, <%= at.getFileId() %>, '<%= at.getOriginName() %>', '<%= context %>/board_uploadFiles/<%= at.getChangeName() %>');"><%= at.getOriginName() %></a>
					<% } %>
					<% } %>
					<% } %>
					<% if(!clist.isEmpty()) { %>
					<br>
					
					<h3>댓글</h3>
					<br>
					<% for(Comment c : clist) { %>
					<div class="comment_area" <%= cNum == null ? "" : Integer.parseInt(cNum) == c.getCommentNum() ? "style='color: red;'" : "" %>>
						<div id="profile">
						<% if(c.getpImage() == null) { %>
							<label id="memberIcon" class="glyphicon glyphicon-user" style="top:15px; right: 30px;"></label>
						<% } else { %>
							<img src="<%= context %>/userProfile_uploadFiles/<% out.print(new File(c.getpImage()).getName()); %>">
						<% } %>
						</div>
						<div class="comment_box">
							<div class="comment_nickName"><%= c.getMemberName() %></div>
							<div class="comment_text"><%= c.getComment() %></div>
							<div class="comment_date"><%= sdf.format(c.getWrDate()) %></div>
						</div>
						<% if(loginMember != null && c.getMemberId().equals(loginMember.getId())) { %>
						<form action="<%= context %>/commentDelete.do" method="post" style="float: right;" onsubmit="return commentDelete();">
							<input type="hidden" name="bnum" value="<%= b.getBoardNum() %>">
							<input type="hidden" name="cNum" value="<%= c.getCommentNum() %>">
							<input type="submit" value="삭제">
						</form>
						<% } else if(loginMember != null && !loginMember.getId().equals(c.getMemberId())) { %>
							<form method="post" name="reportComment<%= c.getCommentNum() %>" id="reportComment<%= c.getCommentNum() %>">
                  				<input type="hidden" name="writer" value="<%= c.getMemberName() %>">
                 				<input type="hidden" name="writerId" value="<%= c.getMemberId() %>">
                 				<input type="hidden" name="cNum" value="<%= c.getCommentNum() %>">
								<a href="javascript:void(0);" onclick="reportSendForm('reportComment<%= c.getCommentNum() %>', '댓글 신고');" class="reportComment" style="width: 30px; right: 3px; top: 20px;">신고</a>
							</form>
						<% } %>
						
					</div>
					<% } %>
					<% } %>
					
					<% if(loginMember != null) { %>
					<div class="commentWrite">
						<div id="commentInfo">
							<div id="coco"><%= loginMember.getNickName() %></div>
						</div>
						<form action="commentWrite.do" method="post">
							<input name="bNum" type="hidden" value="<%= b.getBoardNum() %>">
							<textarea name="comment"></textarea>
							<input id="cSubmit" type="submit" value="등록">
						</form>
					</div> <br>
					<% } %>
					<% if(loginMember != null && loginMember.getId().equals(b.getBoardWriter())) { %>
					<div style="padding-top: 20px;">
						<form action="<%= context %>/updateBoardForm.do" method="post" id="writerForm">
							<input type="hidden" name="bnum" value="<%= b.getBoardNum() %>">
							<button class="button1" type="submit" id="Mbtn">수정</button>
							<button class="button1" type="button" id="Dbtn" style="background: rgb(223,72,0);" onclick="deleteBoard();">삭제</button>
						</form>
						<% } %>
						<% if(loginMember != null && loginMember.getRankCode() == 99) { %>
                  			<% if(b.getBoardLevel() == 0 ) { %>
                    		 	<button id="removeCheck" onclick="deleteList(this);" value="<%= b.getBoardNum() %>">게시물 삭제</button>
                 			<% } %>
              			<% } %><br>
              			<button id="toList" onclick="location.href='<%= context %>/boardList.do'" class="glyphicon glyphicon-arrow-left"> 목록으로</button>
					</div>
					
				</div>
			</div>
		</div>
	</div>

	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>
	<script src="<%= context %>/resources/js/jquery-3.5.1.min.js"></script>
	<script>
		function deleteBoard() {
			if(confirm("정말 삭제하시겠습니까?")) {
				var form = document.getElementById("writerForm");
				form.setAttribute("action", "<%= context %>/deleteBoard.do");
				form.submit();
			}
		}
		
		function fileDown(a, num, name, path) {
			$.ajax({
				url: "boardFile.do",
				type: "POST",
				data: {fileNum:num},
				success: function(data) {
					if(data.result) {
						a.href = path;
						a.download = name;
						a.onclick = null;
						a.click();
						a.href = "javascript:void(0);";
						a.removeAttribute("download");
						a.onclick = function() {
							fileDown(a, num, name, path);
						};
					} else {
						alert("파일 다운 실패");
					}
				},
				error: function(data) {
					alert("error");
				}
			});
			return false;
		}
		
		function commentDelete() {
			if(confirm("정말 삭제하시겠습니까?")) {
				return true;
			} else {
				return false;
			}
		}
		
		function deleteList(e) {
	         if(confirm('관리자 권한으로 삭제하시겠습니까?')) {
	            var bnum = e.value;      
	            location.href='superBDelete.do?bnum=' + bnum;
	         }
	     }
		

		function reportSendForm(fname, r){
	    	  var re = window.open('', 'reportSend', 'width=450, height=450');
	    	  var form = document.getElementById(fname);
	    	  var input = document.createElement('input');
	    	  input.setAttribute('type', 'hidden');
	    	  input.setAttribute('name', 'path');
	    	  input.setAttribute('value', window.location.pathname + window.location.search);
	    	  form.appendChild(input);
	    	  
	    	  var cate = document.createElement('input');
	    	  cate.setAttribute('type', 'hidden');
	    	  cate.setAttribute('name', 'cate');
	    	  cate.setAttribute('value', r);
	    	  form.appendChild(cate);
	    	  
	    	  form.action = '<%= context %>/reportSendForm.do';
	    	  form.target = "reportSend";
	    	  form.submit();
		}
		
	</script>
</body>
<script src="<%= context %>/resources/js/sendMessage.js"></script>
</html>