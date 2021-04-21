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
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/manager_info.css">

</head>
<body>
	<div class="wrap">
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div id="content-area">
			<%@ include file="/WEB-INF/views/common/nav.jsp"%>
			
			
			
			
			<div id="content">
				<div id="inform">
				<h1>회원 정보 관리</h1>
				<br>
				<hr><br>

				<table border="1">

					<thead id="thead">
						<tr>
							<th style="width: 30px;"><input type="checkbox" id="chk_all"
								name="chk_all" /></th>
							<th style="width: 230px;">회원 명</th>
							<th style="width: 230px;">회원등급</th>
							<th style="width: 230px;">회원ID</th>
							<th style="width: 230px;">계좌번호</th>
							<th style="width: 230px;">은행</th>
							<th style="width: 230px;">거래 완료 수</th>
							<th style="width: 230px;">상태</th>
						</tr>
					</thead>

					<tbody>
						<tr>
							<th style="width: 30px;"><input type="checkbox"
								id="chk_list" name="chk_list" value="list1" /></th>
							<td style="width: 230px;">도대담</td>
							<td style="width: 230px;">종이비행기</td>
							<td style="width: 230px;">Do12</td>
							<td style="width: 230px;">33-22-4506-11</td>
							<td style="width: 230px;">하나은행</td>
							<td style="width: 230px;">10</td>
							<td style="width: 230px;">정지</td>
						</tr>
						<tr>
							<th style="width: 30px;"><input type="checkbox"
								id="chk_list" name="chk_list" value="list2" /></th>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
						</tr>
						<tr>
							<th style="width: 30px;"><input type="checkbox"
								id="chk_list" name="chk_list" value="list3" /></th>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
						</tr>
						<tr>
							<th style="width: 30px;"><input type="checkbox"
								id="chk_list" name="chk_list" value="list4" /></th>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
						</tr>
						<tr>
							<th style="width: 30px;"><input type="checkbox"
								id="chk_list" name="chk_list" value="list5" /></th>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
						</tr>
						<tr>
							<th style="width: 30px;"><input type="checkbox"
								id="chk_list" name="chk_list" value="list6" /></th>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
						</tr>
						<tr>
							<th style="width: 30px;"><input type="checkbox"
								id="chk_list" name="chk_list" value="list7" /></th>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
						</tr>
						<tr>
							<th style="width: 30px;"><input type="checkbox"
								id="chk_list" name="chk_list" value="list8" /></th>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
						</tr>
						<tr>
							<th style="width: 30px;"><input type="checkbox"
								id="chk_list" name="chk_list" value="list9" /></th>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
						</tr>
						<tr>
							<th style="width: 30px;"><input type="checkbox"
								id="chk_list" name="chk_list" value="list10" /></th>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
						</tr>
						<tr>
							<th style="width: 30px;"><input type="checkbox"
								id="chk_list" name="chk_list" value="list11" /></th>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
						</tr>
						<tr>
							<th style="width: 30px;"><input type="checkbox"
								id="chk_list" name="chk_list" value="list12" /></th>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
						</tr>
						<tr>
							<th style="width: 30px;"><input type="checkbox"
								id="chk_list" name="chk_list" value="list13" /></th>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
						</tr>
						<tr>
							<th style="width: 30px;"><input type="checkbox"
								id="chk_list" name="chk_list" value="list14" /></th>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
						</tr>
						<tr>
							<th style="width: 30px;"><input type="checkbox"
								id="chk_list" name="chk_list" value="list15" /></th>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
						</tr>
						<tr>
							<th style="width: 30px;"><input type="checkbox"
								id="chk_list" name="chk_list" value="list16" /></th>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
							<td style="width: 230px;"></td>
						</tr>
					</tbody>
				</table><br><br>
				<input type="button" id="btn1" value="회원 제명">
				<input type="button" id="btn2" value="회원 정지"> 
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