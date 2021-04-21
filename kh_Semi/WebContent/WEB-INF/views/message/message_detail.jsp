<%@page import="message.model.vo.Message"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/resources/globalVariable.jsp" %>
<%
	Message m = (Message) request.getAttribute("message");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로컬 마켓</title>

<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/base.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/content-area.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/content.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/message_detail.css">

</head>
<body>
	<div class="wrap">
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div id="content-area">
			<%@ include file="/WEB-INF/views/common/nav.jsp"%>
			<div class="outer">
		<br>
		<div class="tableArea">
			<h2 id="msg_d_title">받은 쪽지</h2>
				<form id="detailForm" name="detailForm" method="post">
					<table id="msg_content">
						<tr>
							<th>보낸 사람</th>
							<td>
								<%= m.getNickname()  %>
							</td>
							<th>작성일</th>
							<td><%= m.getSendDate() %></td>
						</tr>
						<tr>
							<th>내용</th>
						</tr>
						<tr>
							<td colspan="4">
								<textarea name="content" cols="60" rows="15" style="resize:none;" readonly><%= m.getMContent()%></textarea>
							</td>
						</tr>
					</table>
				<br>
				
				<div align="center">
					<input type="button" onclick="location.href='javascript:history.go(-1);'" id="cancelBtn" value="취소">
				</div>
			</form>
		</div>
	</div>
			
			
			
				
				
	
			</div>
	</div>

	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
	
	<%@ include file="/WEB-INF/views/common/ad.jsp" %>

</body>
</html>