<%@page import="member.model.vo.Member"%>
<%@page import="manager.model.vo.Report"%>
<%@page import="product.model.vo.Product_File"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	String writerId = (String)request.getAttribute("wId");
	String nickname = (String) request.getAttribute("nickname");
	String path = (String) request.getAttribute("path");
	String cate = (String) request.getAttribute("cate");
	String cNum = (String) request.getAttribute("cNum");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>신고하기</title>
<link rel="stylesheet" type="text/css"
	href="<%= request.getContextPath()%>/resources/css/reportSendForm.css">
</head>
<body>
	<h2 align="center"><%= cate %></h2>
	
	
	<form action="<%= request.getContextPath() %>/insertReport.do" method="post" id="sendReport" name="sendReport">
		<input type="hidden" name="opt" value="<%= cate %>">
		<input type="hidden" name="path" value="<%= cNum == null ? path : path + "#" + cNum %>">
			<b>작성자 :</b>
			<input type ="hidden" id="id1" name="id1" value='<%= loginMember.getId()  %>'>
			<input type ="text" value='<%= loginMember.getNickName()  %>' readonly><br><br>
			<b>신고자 :</b>
		<input type = "hidden" id="id2" name="id2" value='<%= writerId %>' readonly>	
		<input type = "text" value='<%= nickname %>' readonly>
		<br><br>
			<b>신고사유:</b><br><br>
		<textArea name="reportReason" rows='10' cols = '55' placeholder ='신고사유를 입력해주세요' aligin="center"></textArea><br><br>
		<div id="btn" align="center">
		<button type = 'submit' id="send">전송 하기</button>
		<button type = 'button' onclick='self.close();' id="cancel">취소</button>
		</div>
	</form>

</body>
</html>