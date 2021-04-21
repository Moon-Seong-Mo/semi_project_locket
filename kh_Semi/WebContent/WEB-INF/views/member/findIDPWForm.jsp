<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ID/PW 찾기</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/css/updatePw.css">
<style>
	div {
		display: inline-block;
		width: 45%;
		height: 100%;
	}
</style>
</head>
<body align="center">
	<h3>ID/PW 찾기</h3>
	
	<div>
		<button class="btn" onclick="location.href='<%= request.getContextPath() %>/findIDForm.do'">아이디 찾기</button>
	</div>
	
	<div>
		<button class="btn" onclick="location.href='<%= request.getContextPath() %>/findPWForm.do'">비밀번호 찾기</button>
	</div>
	
</body>
</html>