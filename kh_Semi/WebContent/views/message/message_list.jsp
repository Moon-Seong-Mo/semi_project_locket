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
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/message_list.css">

</head>
<body>
	<div class="wrap">
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
		<div id="content-area">
			<%@ include file="/WEB-INF/views/common/nav.jsp"%>
			
			
			
			<div id = "wrap"></div>
				
				
				<h1>쪽지함</h1><hr><br>
				
				<input type ="button" id ="delete" value ="삭제">
				<input type ="button" id ="sendmessage" value ="쪽지 보내기" onclick = "send();">
				<br>
				
				
			<form>
				<table id = "messagetable" border = 1>
					<tr>
						<th ><input type="checkbox" name="selmessage" value="전체선택" id="all" onclick="selectAll();"></th>
						<th width = 15%>보낸사람</th>
						<th width = 70%>내용</th>
						<th width = 20%>날짜</th>
					</tr>
					
					<tr>
						<td ><input type="checkbox" name="selmessage" value="1" id="sel1" onclick="selectOne();"></td>
						<td>HAHAHAHA</td>
						<td>휴대폰 사여ㅕㅕㅕ.</td>
						<td>2020.09.09 17:01</td>
					</tr>
					
					<tr>
						<td ><input type="checkbox" name="selmessage" value="2" id="sel2" onclick="selectOne();"></td>
						<td>KH Teacher</td>
						<td>마우스 상품글 보고 쪽지 드립니다.</td>
						<td>2020.09.09 17:01</td>
					</tr>
					
					<tr>
						<td ><input type="checkbox" name="selmessage" value="3" id="sel3" onclick="selectOne();"></td>
						<td>BTS ZZANG</td>
						<td>방탄앨범산다구요오</td>
						<td>2020.08.31 13:22</td>
					</tr>
					
					<tr>
						<td ><input type="checkbox" name="selmessage" value="4" id="sel4" onclick="selectOne();"></td>
						<td>신발수집가</td>
						<td>신발 다산다</td>
						<td>2020.07.22 15:22</td>
					</tr>
					
					<tr>
						<td><input type="checkbox" name="selmessage" value="5" id="sel5" onclick="selectOne();"></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					
					<tr>
						<td><input type="checkbox" name="selmessage" value="6" id="sel6" onclick="selectOne();"></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					
					<tr>
						<td><input type="checkbox" name="selmessage" value="7" id="sel7" onclick="selectOne();"></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
					
					<tr>
						<td><input type="checkbox" name="selmessage" value="8" id="sel8" onclick="selectOne();"></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</table>
			</form>
				
				<script>
			      function send(){
			    	  var sendwindow = window.open("","","width=500, height=300");
			    	  
			    	   
			    	  
			    	  sendwindow.document.write("<html><head></head><body><h2>쪽지 보내기</h2>");
			    	  sendwindow.document.write("<b>보낸사람&nbsp</b>");
			    	  sendwindow.document.write("<input type ='text' size = '20' placeholder = '아이디를 입력하세요.'><br><br>");
			    	  sendwindow.document.write("<textArea rows='10' cols = '60' placeholder ='내용을입력해주세요'></textArea><br><br>");
			    	  sendwindow.document.write("<button type = 'button' onclick='cancel();'>취소</button>");
			    	  sendwindow.document.write("<button type = 'button'>전송 하기</button>");
			    	  
			    	  
			    	  
			    	  
			    	  sendwindow.document.write("</body></html>");
			      }
			      
			      
			      
					var all = document.getElementById("all");
					var selmessage = document.getElementsByName("selmessage");

					function selectAll(){
						if(all.checked){
							for(var i = 0; i < selmessage.length; i++){
								selmessage[i].checked = true;
							}
						} else{
							for(var i = 0; i < selmessage.length; i++){
								selmessage[i].checked = false;
							}
						} 
					}
					
					
					function selectOne(){
						var count = 0;
						
						for(var i = 0; i < selmessage.length; i++){
							if(selmessage[i].checked){
								count++;
							} 
						}
						
						if(count != 9){
							all.checked = false;
						} else{
							all.checked = true;
						}
					}
			      
			      
   				</script>		
			</div>
	</div>

	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
	
	<%@ include file="/WEB-INF/views/common/ad.jsp" %>

</body>
</html>