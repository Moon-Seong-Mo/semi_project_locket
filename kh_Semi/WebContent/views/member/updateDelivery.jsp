<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/updateDelivery.css">
<script type="text/JavaScript" src="<%= request.getContextPath() %>/resources/js/jquery-3.5.1.min.js"></script>
<script type="text/JavaScript" src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
		function openDaumZipAddress() {
			new daum.Postcode({
				oncomplete:function(data) {
					jQuery("#postcode1").val(data.postcode1);
					jQuery("#postcode2").val(data.postcode2);
					jQuery("#zonecode").val(data.zonecode);
					jQuery("#address").val(data.address);
					jQuery("#address_etc").focus();
					console.log(data);
				}
			}).open();
		}

</script>
</head>
<body>
	<h2 align="center">배송지 추가하기</h2>
		
	<form id="updateAddress">
		<table>
			<tr>
				<th><label>받는 분</label></th>
				<td><input type="text" name="delivery-receiver" id="receiver"></td>
			</tr>
			<tr>
				<th><label>주소</label></th>
				<td>
					<div>
						<input id="zonecode" type="text" value="" style="width:50px;" readonly/>&nbsp;
						<input type="button" id="findBtn" onClick="openDaumZipAddress();" value = "주소 찾기" />
						<br/>
						<input type="text" name="address1" id="address" value="" style="width:240px;" readonly/>
					</div>
				</td>
			</tr>
			<tr>
				<th>나머지 주소</th>
				<td><input type="text" name="address2" id="address_etc" value="" style="width:200px;"/></td>
			</tr>
			<tr>
				<th><label>연락처</label></th>
				<td><input type="text" name="delivery-phone"></td>
			</tr>
			<tr>
				<th><label>배송지 명</label></th>
				<td><input type="text" name="delivery-name"></td>
			</tr>
		</table>
		
		<br><br>
		
		<div class="btns" align="center">
			<input id="updatePwBtn" type="submit" value="등록하기">
			<input type="button" id="cancelBtn" onclick="self.close();" value="취소하기">
		</div>
	</form>
</body>
</html>