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
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/manager_report.css">

</head>
<body>
	<div class="wrap">
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div id="content-area">
			<%@ include file="/WEB-INF/views/common/nav.jsp"%>
	
	<div id="content">
				<p id="title">신고 관리</p>
				<br>
				<hr>
				<br><br>
				<div id="report-area-drop">
					<select id="report_category">
						<option value="댓글신고" class="drop">댓글 신고</option>
						<option value="댓글신고" class="drop">게시글 신고</option>
						<option value="댓글신고" class="drop">상품 신고</option>
					</select>
				</div>
				<br>
				<div id="report-area-table">
					<table border="1" style="width: 980px;" class="report-list">
						<tr id="report-head">
							<td class="report-check"><input type="checkbox" value="전체선택"></td>
							<th>회원 명</th>
							<th>회원등급</th>
							<th>회원ID</th>
							<th>신고 사유</th>
						</tr>
						<tr>
							<td class="report-check"><input type="checkbox"></td>
							<td>토마토</td>
							<td>종이비행기</td>
							<td>tomatoma</td>
							<td>못생김</td>
						</tr>
						<tr>
							<td class="report-check"><input type="checkbox"></td>
							<td>감자</td>
							<td>로켓</td>
							<td>kangwondo</td>
							<td>더 못생김</td>
						</tr>
						<tr>
							<td class="report-check"><input type="checkbox"></td>
							<td>고구마</td>
							<td>비행기</td>
							<td>daldalhae</td>
							<td>네고왕</td>
						</tr>
						<tr>
							<td class="report-check"><input type="checkbox"></td>
							<td>무우</td>
							<td>드론</td>
							<td>daikonguy</td>
							<td>그냥</td>
						</tr>
						<tr>
							<td class="report-check"><input type="checkbox"></td>
							<td>당근</td>
							<td>로켓</td>
							<td>carrot2piece</td>
							<td>그냥2</td>
						</tr>
						<tr>
							<td class="report-check"><input type="checkbox"></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td class="report-check"><input type="checkbox"></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td class="report-check"><input type="checkbox"></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td class="report-check"><input type="checkbox"></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td class="report-check"><input type="checkbox"></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td class="report-check"><input type="checkbox"></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</table>
				</div>
				
				<div class="report-btn">
					<input type="submit" value="회원 정지" onclick="suspend();">
					<script>
						function suspend(){
							var susp = confirm("해당 회원을 *정지*시키겠습니까?")
							
							if(susp){
								
							} else{
								
							}
						}
					</script>
					<input type="submit" value="회원 제명" onclick="expulsion();">
					<script>
						function expulsion(){
							var expel = confirm("해당 회원을 *제명*하시겠습니까??")
							
							if(expel){
								
							} else{
								
							}
						}
					</script>
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