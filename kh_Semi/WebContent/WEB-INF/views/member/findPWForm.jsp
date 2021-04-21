<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/resources/css/updatePw.css">
</head>
<body align="center">
	<h2>비밀번호 찾기</h2>

	<form method="post" action="findPW.do" id="findPW">
		<div>아 이 디*</div>
		<div>
			<input type="text" class="username_input" name="userId" id="userId"
				size="32" maxlength="20" required>
			<br>
			<br>
		</div>

		<div>비 밀 번 호 찾기 힌트*</div>
		<div>
			<select name="pwHint" id="pwHint">
				<option value="0">질문을 선택해 주세요.</option>
				<option>나의 보물 1호는?</option>
				<option>다시 태어나면 되고 싶은 것은?</option>
				<option>유년 시절 가장 생각나는 친구의 이름은 ?</option>
				<option>추억하고 싶은 날짜가 있다면?</option>
			</select>
		</div>
		<br>

		<div>비 밀 번 호 찾기 답변*</div>
		<div>
			<input size="32" name="pwAns" id="pwAns" required><br> <br>
		</div>
		
		<input class="btn" type="submit" value="찾기">
	</form>

</body>
<script>
	window.resizeTo(500, 450);
</script>
</html>