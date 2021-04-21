<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/resources/globalVariable.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로컬 마켓</title>

<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/base.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/content-area.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/content.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/group_register.css">

</head>
<body>
	<div class="wrap">
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div id="content-area">
			<%@ include file="/WEB-INF/views/common/nav.jsp"%>
						<div id="content" >
				<br><br>
				<h1>&nbsp;&nbsp;공동구매 물품명</h1><br>
				<hr>
				
				<form>
					<br>
					<input type =text placeholder = "공동구매 물품명을 입력하세요." id = productname>
					
					<table id = groupbuy >
					
					<tr>	
						<td width = 500px><b> 게시자 : MaskMan </b></td>
						<td>
							<b> 일정 : </b>
							<input type =text placeholder = "시작일">
							~
							<input type =text placeholder = "종료일">
						</td>
					</tr>
					
					<tr>
						<td colspan = 3><br><hr></td>
					</tr>
					
					
					<tr>
						<td colspan = 3><img id="mask" src = "../resources/images/mask.jpg"></td>
					</tr>
					
					<tr>
						<td colspan = 3 align = center><h3>국산 KF94 일회용 황사 마스크</h3></td>
					</tr>
					
					<tr>
						<td colspan = 3 align = center><h3>식약처의약외품 방역 미세먼지 차단</h3></td>
					</tr>
					
					
					<tr>
						<td colspan = 3 align = center ><h3>3중 개별포장 대형 50매</h3><br><hr><br></td>
					</tr>
					
					

					
					</table>
					
						<input type ="button" id = register  value= "등록">
						<input type ="button" id = cancel value = "취소">
				</form>
				<br><br>
				<input type ="button" id = "back" value = "목록으로 돌아가기">
			</div>
			

			
		</div>
	</div>
			
			
			
			
			<div class="wrap">
	<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</div>
<%@ include file="/WEB-INF/views/common/ad.jsp" %>

</body>
</html>