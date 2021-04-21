<%@page import="board.model.vo.PageInfo"%>
<%@page import="board.model.vo.Board"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, shipping_address.model.vo.Shipping_address" %>
<%
	ArrayList<Shipping_address> list = (ArrayList<Shipping_address>)request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로컬마켓</title>
<%@ include file="/resources/globalVariable.jsp" %>
<script type="text/JavaScript" src="<%= context %>/resources/js/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/base.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/content-area.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/content.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/my_delivery.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
</head>
<body>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
		<div id="content-area">
			<%@ include file="/WEB-INF/views/common/nav.jsp" %>
			
			<div id ="content">			
				<br>			
				<h1>나의 배송지</h1>
				<% if(loginMember != null) { %>
				<input type="submit" id="obj" value="추가하기">
				<% } %>
				<div class="delivery_list_wrap">
					<table class="delivery_list" id="dTable">
						<thead>
							<tr>
								<th width="50px"><input type="checkbox" id="allCheck" onclick="allChk(this);"/></th>
								<th width="100px">받는 분</th>
								<th width="200px">주소</th>
								<th width="130px">연락처</th>
								<th width="100px">배송지 명</th>
							</tr>
						</thead>
						<tbody>
						<% if(list.isEmpty()) { %>
						<tr>
							<td colspan="5">저장된 배송지가 없습니다.</td>
						</tr>
						<% } else { %>
							<% for(Shipping_address s : list) { %>
								<tr>
									<td>
										<input type="checkbox" name="RowCheck" id="rcheck" value="<%= s.getAddress_num() %>">
									</td>
									<td><%= s.getReceiver() %></td>
									<td><%= s.getAdderss() %></td>
									<td><%= s.getPhone() %></td>
									<td><%= s.getAddress_name() %></td>
								</tr>
							<% } %>
						<% } %>
						</tbody>
					</table><br>			
				</div>
				<% if(!list.isEmpty()) { %>
					<form action="<%= context %>/deleteSA.do" method="post" onsubmit="return deleteDeli(this);">
						<input type="submit" id="deleteBtn" value="삭제하기">		
					</form>
				<% } %>
			</div>		
		</div>
	</div>
	<div class="wrap">
		<%@ include file="/WEB-INF/views/common/footer.jsp" %>
	</div>
	
	<%@ include file="/WEB-INF/views/common/ad.jsp" %>
	
	<script>
		document.getElementById("obj").onclick = function() {
			openWindow(function(win) {
				location.href = "<%= context %>/deliveryList.do";
			});
		};

		var openWindow = function(closeCallback) {
		    var win = window.open('updateDeliveryForm.do', 'updateDeliveryForm', 'width=500, height=450');
		    var interval = window.setInterval(function() {
		        try {
		            if (win == null || win.closed) {
		                window.clearInterval(interval);
		                closeCallback(win);
		            }
		        }
		        catch (e) {
		        }
		    }, 1000);
		    return win;
		};

		
		//전체 체크 기능
		function allChk(obj){
		     var chkObj = document.getElementsByName("RowCheck");
		     var rowCnt = chkObj.length - 1;
		     var check = obj.checked;
		     if (check) {﻿
		         for (var i=0; i<=rowCnt; i++){
		          if(chkObj[i].type == "checkbox")
		              chkObj[i].checked = true;
		         }
		     } else {
		    	 for (var i=0; i<=rowCnt; i++) {
		           if(chkObj[i].type == "checkbox"){
		              chkObj[i].checked = false;
		          }
		        }
		      }
		} 

		//삭제
		function deleteDeli(form){
			var checking = document.getElementsByName("RowCheck");
			
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
 						var data = document.createElement('input');
 						data.setAttribute("type", "hidden");
 						data.setAttribute("value", arr[i]);
 						data.setAttribute("name", "RowCheck");
 						form.appendChild(data);
 					}
 					return true;
			     }
			}
			return false;
		}

	</script>
</body>
</html>