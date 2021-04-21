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
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/findPwd.css">


</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<div id="content-area">
			<%@ include file="/WEB-INF/views/common/nav.jsp" %>
			
			<div id="content">
			<div id="wrap">
				<h1  align="center">비밀번호 찾기</h1><br><br>
				<form>
					<table>
						<tr>
							<td class="item"><label>아이디  </label></td>
							<td><input type="text" name="name" id="name" required></td>
							<td><label id="nameResult"></label></td>
						</tr>
		
						
						<tr>
							<td class="item"><label>비밀번호 찾기 힌트</label></td>
							<td>
								<select>
									<option value="findsel">질문을 선택해 주세요.</option>
									<option value="treasure" id = "treasure">나의 보물 1호는?</option>
									<option value="rebirth" id = "rebirth">다시 태어나면 되고 싶은 것은?</option>
									<option value="friend" id = "friend">유년 시절 가장 생각나는 친구의 이름은?</option>
									<option value="memory" id = "memory">추억하고 싶은 날짜가 있다면?</option>
								</select>
							</td>
							<td><label id="idResult"></label></td>
						</tr>
						<tr>
							<td class="item"><label>비밀번호 찾기 답변</label></td>
							<td><input type="text" name="pwdfind" id="pwdfind" required></td>
							<td><label id="pwd1Result"></label></td>
						</tr>
						<tr>
							<td colspan='3'><input type="reset" value = "취소"> &nbsp; <input type="submit" value = "확인" id = "ok"></td>
						</tr>
					</table>
					
				</form>
			</div>
			<script>
				ok.onclick = function(){
						alert("비밀번호 : 정답을 맞추면 원래 비밀번호값 나와야함 ");
					
				}
			</script>

		</div>
	</div>
	</div>
	
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
	
	<%@ include file="/WEB-INF/views/common/ad.jsp" %>
</body>
</html>