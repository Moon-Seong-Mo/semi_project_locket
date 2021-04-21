<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = (String) request.getAttribute("userId");
	String nickname = (String) request.getAttribute("nickname");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지 보내기</title>
<style>
	body {
	background: #fffcf5;
	}
	input{
	background: #fffcf5;
	}
	textArea{
	background: #fffcf5;
	}
	
	#btn1{
		background: orange;
		border: 1px solid orange;
		border-radius: 5px;
		font-weight: bold;
		color: white;
	}
	
	#btn2{
		background: gray;
		border: 1px solid gray;
		border-radius: 5px;
		font-weight: bold;
		color: white;
		width: 70px;
	}
	
	#searchUser{
		background: lightgray;
		border: 1px solid lightgray;
	}
</style>
</head>
<body align="center">
	<h2>쪽지 보내기</h2>
	
	<form action="<%= request.getContextPath() %>/insertMessage.do" method="post" id="sendMessage" name="sendMessage">
			<b>받는 사람 :</b>
		<input type ="hidden" id="id" name="id" <%= id == null ? "" : "value='" + id + "'" %>>
		<input type ='text' id="nickname" name="nickname" height="5" readonly="readonly" <%= nickname == null ? "" : "value='" + nickname + "'" %>>
		<input type ="button" id="searchUser" size = '20' height="3" value="찾기" onclick="">
		<br><br>
		<textArea name="content" rows='10' cols = '60' placeholder ='내용을입력해주세요'></textArea><br><br>
		<button id="btn1" type = 'submit'>전송 하기</button>
		<button id="btn2" type = 'button' onclick='self.close();'>취소</button>
	</form>
	<script>
		document.getElementById("searchUser").onclick = function() {
			openWindow();
		};
	
		var openWindow = function() {
		    var win = window.open('searchUserForm.do', 'searchUserForm', 'width=600, height=400');
		};
	</script>
</body>
</html>