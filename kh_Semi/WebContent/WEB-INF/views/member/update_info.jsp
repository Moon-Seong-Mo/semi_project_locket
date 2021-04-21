<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	Member memberInfo = (Member)request.getAttribute("memberInfo");
	String phone[] = memberInfo.getPhone().split("-");
	String phone1 = phone[0];
	String phone2 = phone[1];
	String phone3 = phone[2];
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로컬마켓</title>
<%@ include file="/resources/globalVariable.jsp"%>

<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/base.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/content-area.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/content.css">

<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/update_info.css">

</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div id="content-area">
			<%@ include file="/WEB-INF/views/common/nav.jsp"%>

			<div id="content">
				<h1>
					<b>회원 정보 수정</b>
				</h1>
				<br>
				<br>
				<form id="editForm" method="post" action="<%= context %>/updateInfo.do">
					<table id="editTable">
						<tr>
							<th>아이디</th>
							<td>
								<div id="userId"><%= loginMember.getId() %></div>
								<input type="hidden" name="userId" value="<%= loginMember.getId() %>">
							</td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td>
								<div>
									<button type="button" id="updatePw">비밀번호 변경</button>
								</div>
							</td>
						</tr>
						<tr>
							<th>비밀번호 힌트</th>
							<td>
								<div>비밀번호 찾기 힌트</div>
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
								<script>
									var pwHint = document.getElementById("pwHint");
									for(var i = 0; i < pwHint.children.length; i++) {
										if(pwHint.children[i].value === '<%= memberInfo.getPwHint() %>') {
											pwHint.children[i].setAttribute('selected', '');
										}
									}
								</script>
								<div>비밀번호 찾기 답변</div>
								<div>
									<input size="32" name="pwAns" id="pwAns" required value="<%= memberInfo.getPwAns() %>"><br> <br>
								</div>
							</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td>
								<div>
									<input type="email" name="email" id="email" required value="<%= memberInfo.getEmail() %>">
								</div>
							</td>
						</tr>
						<tr>
							<th>닉네임</th>
							<td>
								<div>
									<input type="text" name="nickname" id="nickname" required value="<%= memberInfo.getNickName() %>"> 
									<input type="button" id="checkNickname" value="중복확인">
								</div>
							</td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td>
								<div>
									<select name="phone1" id="phone1">
										<option>010</option>
										<option>011</option>
										<option>016</option>
									</select> 
									- 
									<input type="text" maxlength="4" size="4" name="phone2" id="phone2" required value="<%= phone2 %>"> 
									- 
									<input type="text" maxlength="4" size="4" name="phone3" id="phone3" required value="<%= phone3 %>">
								</div>
								
								<script>
									var phone1 = document.getElementById("phone1");
									for(var i = 0; i < phone1.children.length; i++) {
										if(phone1.children[i].value === '<%= phone1 %>') {
											phone1.children[i].setAttribute('selected', '');
										}
									}
								</script>
							</td>

						</tr>
						
					</table>
					<input type="submit" value="정보 수정">
				</form>
			</div>
		</div>
	</div>

	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	</div>

	<%@ include file="/WEB-INF/views/common/ad.jsp"%>
</body>
<script src="<%= context %>/resources/js/jquery-3.5.1.min.js"></script>
<script src="<%= context %>/resources/js/update_info.js"></script>
</html>