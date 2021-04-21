<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정지기간 설정</title>
</head>
<body>
	<h2 align="center">정지기간 설정</h2>
		
	<form action="<%= request.getContextPath() %>/updatePw.do" method="post" id="updatePwForm" name="updatePwForm" onsubmit="return send();">
		<table>
			<tr>
				<td><label>기간(일)</label></td>
				<td><input type="number" name="term" id="term" min="1"></td>
			</tr>
		</table>
		
		<br><br>
		
		<div class="btns" align="center">
			<input type="button" id="cancelBtn" onclick="closeAction();" value="확인">
		</div>
	</form>
</body>
<script>
	function closeAction() {
		opener.document.getElementById("term").value = document.getElementById('term').value;
		
		self.close();
	}
</script>
</html>