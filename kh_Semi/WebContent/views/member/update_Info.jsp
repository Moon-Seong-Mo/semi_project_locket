<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로컬마켓</title>
<%@ include file="/resources/globalVariable.jsp" %>

<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/base.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/content-area.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/content.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/update_info.css">

</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<div id="content-area">
			<%@ include file="/WEB-INF/views/common/nav.jsp" %>
			
			<div id="content">
			<h1><b>회원 정보 수정</b></h1>
			<br><hr>
			<form>
			<table border="1" id="change">
			<tr>
				<th colspan="2" class="name">아이디</th>
				<td colspan="4" id="td">기존아이디</td>
			
			</tr>
			<tr>
				<th colspan="2" class="name">비밀번호</th>
				<td><input type="button" id="Pwd"value="비밀번호 변경">
			</tr>
			<tr>
				<th colspan="2" class="name">이메일</th>
				<td colspan="4"><input type="email" class="text" placeholder="기존 이메일"></td>
			</tr>
			<tr>
				<th colspan="2" class="name">닉네임</th>
				<td><input type="text" class="text" placeholder="기존 닉네임"><button id="Check">중복확인</button></td>
			</tr>
			<tr>
				<th colspan="2" class="name">계좌 연결</th>
				<td colspan="4"><select>
						<option>은행 선택</option>
						<option>카카오 뱅크</option>
						<option>국민 은행</option>
						<option>신한 은행</option>
						<option>하나 은행</option>
						<option>농협</option>
						<option>선택안함</option>
					</select>
					<input type="text" class="text" placeholder="계좌번호 입력 칸">
				</td>
			</tr>
			<tr>
				<th colspan="2" class="name">간편 비밀번호</th>
				<td colspan="4"><input type="password" class="text" placeholder="숫자 7자리 입력">
			</tr>
			</table>
			<br><br>
			<input type="submit" id ="submit" value="정보 수정">
			
			</form>
			</div>
		</div>
	</div>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
	
	<%@ include file="/WEB-INF/views/common/ad.jsp" %>
</body>
</html>