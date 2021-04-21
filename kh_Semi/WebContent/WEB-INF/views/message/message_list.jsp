<%@page import="message.model.vo.PageInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/resources/globalVariable.jsp" %>
<%@ page import="java.util.ArrayList, message.model.vo.Message" %>
<%
	ArrayList<Message> messageList = (ArrayList<Message>) request.getAttribute("messageList");
	PageInfo pi = (PageInfo)request.getAttribute("pi");

	int listCount = pi.getListCount();
	int currentPage = pi.getCurrentPage();
	int maxPage = pi.getMaxPage();
	int startPage = pi.getStarPage();
	int endPage = pi.getEndPage();
%>
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
			
			
			
			<div id="content">
				
				<h1>쪽지함</h1>
			<div class="board_list_wrap">
					<input type ="button" id ="sendmessage" value ="쪽지 보내기" onclick = "send();">
					<form action="<%= context %>/deleteMessage.do" method="post" onsubmit="return deleteDeli(this);">
						<input type ="submit" id ="delete" value ="삭제">
					</form>
				<table class = "board_list">
					<thead>
						<tr>
							<th><input type="checkbox" name="selectAll" id="all"></th>
							<th>보낸사람</th>
							<th>내용</th>
							<th>날짜</th>
						</tr>
					</thead>
					<tbody>	
					<% if(messageList.isEmpty()){ %>
					<tr>
						<td colspan="4">받은 메세지가 없습니다.</td>
					</tr>
					<% } else { %>
						<% for(Message m : messageList) { %>
					<tr>
						<td>
							<input type="checkbox" name="selmessage" onclick="selectOne();" value='<%= m.getMessage_Num() %>'>
						</td>
						<td><%= m.getSendId() %></td>
						<td name="td"><%= m.getMContent() %></td>
						<td><%= m.getSendDate() %></td>
					</tr>
						<% } %>
					<% } %>
					</tbody>
				</table>
			</div>
				 
   			<div class="pagingArea" align="center">
		
			<!-- 맨 처음으로 -->
			<button onclick="location.href='<%= request.getContextPath() %>/message.do?currentPage=1'" align="center"> &lt;&lt;</button>
			
			<!-- 이전 페이지로 -->
			<button onclick="location.href='<%= request.getContextPath() %>/message.do?currentPage=<%= currentPage - 1 %>'"
				 id="beforeBtn">&lt;</button>
			<script>
				if(<%= currentPage %> <= 1){
					var before = $('#beforeBtn');
					before.attr('disabled', 'true');
				}
			</script>
			
			<!-- 숫자 목록 버튼 -->
			<% for(int p = startPage; p <= endPage; p++) { %>
				<% if(p == currentPage) { %>
					<button id="choosen" disabled><%= p %></button>
				<% } else { %>
					<button id="numBtn" onclick="location.href='<%= request.getContextPath() %>/message.do?currentPage=<%= p %>'"><%= p %></button>
				<% } %>
			<% } %>
			
			<!-- 다음 페이지로 -->
			<button onclick="location.href='<%= request.getContextPath() %>/message.do?currentPage=<%= currentPage + 1 %>'"
					id="afterBtn">&gt;</button>
			<script>
				if(<%= currentPage %> >= <%= maxPage %>){
					var after = $('#afterBtn');
					after.attr('disabled', 'true');
				}
			</script>
			<!-- 맨 끝으로 -->
			<button onclick="location.href='<%= request.getContextPath() %>/message.do?currentPage=<%= maxPage %>'">&gt;&gt;</button>
		</div>
		
		<div class="buttonArea" align="right">
		</div>
   		<script>
			      function send(){
			    	  window.open('messageSendForm.do', 'messageSend' , 'width=600, height=400'); 
			      }
			      
			      
			      
			      
					var all = document.getElementById("all");
					var selmessage = document.getElementsByName("selmessage");
					
					all.onclick = function() {
						selectAll();
					};
					
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
						
						if(count != selmessage.length){
							all.checked = false;
						} else{
							all.checked = true;
						}
					}
			      	$(function(){
			      		$('.board_list td[name=td]').click(function(){
			      			var num = $(this).parent().first().find('input').val();
							location.href='<%= request.getContextPath() %>/messageDetail.do?num=' + num;
			      		});
			      	});
			      	// 메세지 삭제
			      	function deleteDeli(form){
						var checking = document.getElementsByName("selmessage");
						
						var count = 0;
						var arr = new Array();
						for(var i = 0; i < checking.length; i++) {
							if(checking[i].checked) {
								count++;
								arr.push(checking[i].value);
							}
						}
						
						if(count == 0) {
							alert('삭제할 주소를 선택해주세요.');
						} else {
						    if(confirm("정말 삭제하시겠습니까?")){
			 					for(var i = 0; i < arr.length; i++) {
			 						console.log(arr);
			 						var data = document.createElement('input');
			 						data.setAttribute("type", "hidden");
			 						data.setAttribute("value", arr[i]);
			 						data.setAttribute("name", "selmessage");
			 						form.appendChild(data);
			 					}
			 					return true;
						     }
						}
						return false;
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