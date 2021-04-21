<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	ArrayList<String> idList = (ArrayList<String>) request.getAttribute("idList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 결과</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/css/updatePw.css">
</head>
<body align="center">
	<h2>아이디 찾기 결과</h2>
	
	<% if(idList.size() > 0) { %>
	<table id="font">
	<% for(String id : idList) { %>
		<tr>
			<td><%= id %></td>
		</tr>
	<% } %>
	</table>
	<% } else { %>
	<div>해당하는 아이디가 없습니다.</div>
	<% } %>
	<br>
	<button class="btn" onclick="javascript:self.close();">닫기</button>
	
</body>
</html>