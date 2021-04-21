<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/css/updatePw.css">
</head>
<body align="center">
	<h2>아이디 찾기</h2>
	
	<div>
		<input type="radio" name="type" value="email" checked="checked" onclick="radioCheck('email');"> 이메일로 찾기
		<input type="radio" name="type" value="phone" onclick="radioCheck('phone');"> 전화번호로 찾기
	</div>
	<br><br>
	
	<form method="post" action="findID.do" id="findEmail">
		<input type="hidden" name="option" value="EMAIL">
		<div>
			<span>이메일</span>
			<input size="32" type="email" name="email" id="email" required>
		</div>
		<br><br>
		<input class="btn" type="submit" value="찾기">
	</form>
	
	<form method="post" action="findID.do" id="findPhone">
		<input type="hidden" name="option" value="PHONE">
		<div>
		<span>전화번호</span>
			<select name="phone1" id="phone1">
				<option>010</option>
				<option>011</option>
				<option>016</option>
			</select>
			-
			<input type="text" maxlength="4" size="4" name="phone2" id="phone2" required>
			-
			<input type="text" maxlength="4" size="4" name="phone3" id="phone3" required>
		</div>
		<br><br>
		<input class="btn" type="submit" value="찾기">
	</form>
	
</body>
<script>
	window.resizeTo(500, 450);
	
	var email = document.getElementById('findEmail');
	var phone = document.getElementById('findPhone');
	phone.style = "display: none;";
	
	function radioCheck(check) {
		if(check == "email") {
			phone.style = "display: none;";
			email.style = "";
		} else if(check == "phone") {
			email.style = "display: none;";
			phone.style = "";
		}
	}
	
</script>
</html>