<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="member.model.vo.Member"%>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	int pId = (int)request.getAttribute("pId");
	String writer = (String)request.getAttribute("www");
	int price = (int)request.getAttribute("price");
	
	String writerId = (String)request.getAttribute("wId");
	String pTitle = (String)request.getAttribute("pTitle");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>거래 신청하기</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/buyingProduct.css">
<script type="text/JavaScript" src="<%= request.getContextPath() %>/resources/js/jquery-3.5.1.min.js"></script>

</head>
<body>
	<h2 align="center">거래 신청하기</h2>
	
	<br>
	
	<form action="<%= request.getContextPath() %>/buyingP.do" method="post" id="buyingProduct" name="buyingProductForm" onsubmit="return send();">		
		<input type="hidden" name="pId" value="<%= pId %>">
		<input type="hidden" name="writerId" value="<%= writerId %>">
		<input type="hidden" name="userId" value="<%= loginMember.getId() %>">
						
		신청인 : <input type="text" name="user" value="<%= loginMember.getNickName() %>" readonly> <br><br>
		상품명 : <input type="text" name="pTitle" value="<%= pTitle %>"><br><br>
		가격  : <input type="text" value="<%= price %>원" readonly> <br><br>
		판매자 : <input type="text" name="receiver" value="<%= writer %>" readonly> <br><br>
		
		<br>
		
		<input type="checkbox" id="allow"> 가격과 상품 상태를 모두 확인했으며, <br>
								&nbsp;&nbsp;&nbsp;&nbsp;게시자에게 거래를 신청합니다.    
		<br><br>
		
		<div class="btns">
			<input id="okayBtn" type="button" onclick="checkfield();" value="신청하기">
			<input type="button" id="cancelBtn" onclick="self.close();" value="취소하기">
		</div>
	</form>
	
	<script>
		function checkfield(){
	        var no = 0;
	        for(var i=0; i< buyingProductForm.elements.length; i++) {
	           var check = buyingProductForm.elements[i];
	           if(check.checked == true) {
	              no++;
	           }
	        }
	        
	        if(no == 0){
	           alert('확인 체크를 해주세요.');
	           return;
	        }
	        buyingProductForm.submit();
        }
		
	</script>
</body>
</html>