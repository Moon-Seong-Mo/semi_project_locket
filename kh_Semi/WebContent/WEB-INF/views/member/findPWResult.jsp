<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String findId = (String) request.getAttribute("userId");
	String result = (String) request.getAttribute("result");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기 결과</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/css/updatePw.css">

<style>
	span {
		color: white;
	}
	span:hover {
		color:black;
	}
</style>
</head>
<body align="center">
	<h3>비밀번호 찾기 결과</h3>
	
	<% if(result != null) { %>
		<div><%= findId %>님의 비밀번호는 <span><%= result %></span> 입니다.</div>
	<% } else { %>
		<div>결과가 없습니다.</div>
	<% } %>
	<br><br>
	<button class="btn" onclick="javascript:self.close();">닫기</button>
</body>
</html>