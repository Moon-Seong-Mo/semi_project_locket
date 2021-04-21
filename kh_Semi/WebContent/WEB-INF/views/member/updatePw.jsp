<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/css/updatePw.css">
</head>
<body>
	<h2 align="center">비밀번호 수정하기</h2>
		
	<form action="<%= request.getContextPath() %>/updatePw.do" method="post" id="updatePwForm" name="updatePwForm" onsubmit="return send();">
		<table>
			<tr>
				<td><label>현재 비밀번호</label></td>
				<td><input type="password" name="userPw" id="userPw"></td>
			</tr>
			<tr>
				<td><label>변경 비밀번호</label></td>
				<td><input type="password" name="newPw"></td>
			</tr>
			<tr>
				<td><label>변경 비밀번호 확인</label></td>
				<td><input type="password" name="newPw2"></td>
			</tr>
		</table>
		
		<br><br>
		
		<div class="btns" align="center">
         <input id="updatePwBtn" type="submit" value="변경하기">
         <input type="button" id="cancelBtn" onclick="self.close();" value="취소하기">
      </div>
	</form>
</body>
<script src="<%= request.getContextPath() %>/resources/js/updatePw.js"></script>
</html>