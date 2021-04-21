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
				<form action="groupWrite.do" method="post" encType="multipart/form-data" id="groupWrite">
					<button id="obj" type="button" onclick="groupWrite();">등록</button>
					<br><br>		
					<input type="text" id="title" name="title" placeholder="제목을 입력하세요.">
					<br><br>
					<div id="fileField">
						<div id="filetext">첨부파일  </div>
						<div id="setFile">
							<input type="file" id="file" name="file" onchange="changeFile(this);">
								<input type="date" name="startdate" id="startdate"> 
								~
								<input type="date" name="enddate" id="enddate">
						</div>
					</div>
					<div id="filetext">가격 :</div> &nbsp;<input type="text" name="price" id="price" placeholder="가격을 입력하세요.">
					<br><br><br>
					<textarea id="boardContent" name="content" placeholder="내용을 입력하세요."></textarea>
						
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
		var date = new Date();
		var yyyy = date.getFullYear();
		var mm = date.getMonth()+1 > 9 ? date.getMonth()+1 : '0' + date.getMonth()+1;
		var dd = date.getDate() > 9 ? date.getDate() : '0' + date.getDate();
		var sDate = $("#startdate");
		sDate.val(yyyy + "-" + mm + "-" + dd);
		sDate.attr("min", yyyy + "-" + mm + "-" + dd);
		var eDate = $("#enddate");
		eDate.val(yyyy + "-" + mm + "-" + dd);
		eDate.attr("min", yyyy + "-" + mm + "-" + dd);
		
		function groupWrite() {
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
			var form = document.getElementById('groupWrite');
			form.submit();
		}
	</script>
	
</body>
<script src="<%= context %>/resources/js/boardFile.js"></script>
</html>