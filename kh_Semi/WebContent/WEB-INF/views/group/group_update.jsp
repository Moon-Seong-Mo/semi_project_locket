<%@page import="group.model.vo.Attachment"%>
<%@page import="java.util.ArrayList"%>
<%@page import="group.model.vo.Group"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Group g = (Group) request.getAttribute("group");
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
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/group_write.css">

</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<div id="content-area">
			<%@ include file="/WEB-INF/views/common/nav.jsp" %>
			
			<div id="content">
			<br>
			<h1>공동구매 물품등록</h1>	
				<form id="form1" action="groupUpdate.do" method="post" encType="multipart/form-data">
					<button id="obj" type="button" onclick="groupUpdate();">등록</button>
					<br><br>
					<input type="hidden" name="bnum" value="<%= g.getGroupNum() %>">	
					<input type="text" id="title" name="title" placeholder="제목을 입력하세요." value="<%= g.getGroupTitle() %>">
					<br><br>
					<div id="fileField">
						<div id="filetext" style="height: <%= 28 + flist.size() * 26 %>px;">첨부파일</div>
						<% for(int i = 0; i < flist.size(); i++) { %>
						<div id="setFile-<%= i %>" style="display: flex;">
							<input class="exfile" name="setFile_<%= i %>" type="hidden" value="<%= flist.get(i).getFileId() %>">
							<a href="<%= context %>/group_uploadFiles/<%= flist.get(i).getChangeName() %>" style="display: contents;">
								<input type="text" style="display: inline-block; float: left;" onchange="changeFile(this);" readonly value="<%= flist.get(i).getOriginName() %>">
							</a>
							<input name="fileDel" type="button" value="삭제" style="display: inline-block; float: left;" onclick="delFile('setFile-<%= i %>');">	
						</div>
						<% } %>
							<div id="setFile">
								<input type="file" id="file" name="file" onchange="changeFile(this);">
								<input type="date" name="startdate" id="startdate" value="<%= g.getStartDate() %>"> 
								~
								<input type="date" name="enddate" id="enddate" value="<%= g.getEndDate() %>">
							</div>
						</div>
					<div id="filetext">가격 :</div> &nbsp;<input type="text" name="price" id="price" placeholder="가격을 입력하세요." value="<%= g.getPrice() %>">
					<br><br><br>
					<textarea name="content" id="boardContent" placeholder="내용을 입력하세요."><%= g.getExplain() %></textarea>
						
					<br><br>
					<button type="button" id="list" onclick="location.href='<%= context %>/groupList.do'">목록</button>
				</form>
				</div>
			</div>
		</div>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
	
	<%@ include file="/WEB-INF/views/common/ad.jsp" %>
	<script>
		function groupUpdate() {
			var title = document.getElementById("title").value.replace(/ /g,"");
			var content = document.getElementById("boardContent").value.replace(/ /g,"");
			var price = document.getElementById('price').value;
			var regexp = /^[0-9]*$/
	             
			if(title == "") {
				alert("제목을 입력하세요");
				return;
			} else if(content == "") {
				alert("내용을 입력하세요");
				return;
			} else if(price == "") {
				alert("가격을 입력하세요");
				return;
			}
				
			if(!regexp.test(price)) {
	        	alert("가격은 숫자만 입력하세요");
	            $('#price').val(price.replace(regexp,''));
	            return;
	        }
			var form = document.getElementById('form1');
			if(boardUpdate(form)) {
				form.submit();
			}
		}
	</script>
</body>
<script src="<%= context %>/resources/js/jquery-3.5.1.min.js"></script>
<script src="<%= context %>/resources/js/boardFile.js"></script>
</html>