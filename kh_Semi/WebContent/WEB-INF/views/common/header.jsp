<%@page import="java.io.File"%>
<%@page import="member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	String pImageName = null;
	if(loginMember != null && loginMember.getpImage() != null) {
		File f = new File(loginMember.getpImage());
		pImageName = f.getName();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/header.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
</head>
<body>
	<div id='header'>
			<a href="<%= context %>/"> 
				<img id='logo-img' alt="로컬마켓" src="<%= context %>/resources/images/rocket.png"></a>
			<a href="<%= context %>/"><span id="logo-text">로켓</span></a>
			
		 <form action="allSearch.all" method="get" class="AllSearchForm">
       	 	<div id="header-search">
            <input type="text" name="word" placeholder="검색어를 입력하세요!"> 
            <button class="glyphicon glyphicon-search" id="AllSearchBtn"></button>
         	</div>
         </form>
			
		
			<% if(loginMember == null) { %>
				<div id="account">
					<form action="<%= context %>/login.do" method="post">
						<div>
							<div id="id-area">
								<input type="text" class="form-control" name="idInput">
								<button type="submit" id="login" value="로그인">로그인</button>
							</div>
							<br>
							<div id="pw-area">
								<input type="password" class="form-control" name="pwInput">
								<button type="button" id="signup" value="회원가입" onclick="location.href='<%= context %>/joinForm.do'">회원가입</button><br>
								<input type="button" id="find" value="ID/PW찾기" onclick="findIDPW();" style="float: right; width: 80px; font-weight:bold; border:none;">	
							</div>
							
						</div>
					</form>
				</div>
			<% } else { %>
				<div id="account_info">
				<div id="profileArea">
				<% if(loginMember.getpImage() == null) { %>
					<label id="memberIcon" class="glyphicon glyphicon-user" style="top:15px; right: 30px;"></label>
				<% } else { %>
					<img id="memberImg" src="<%= context %>/userProfile_uploadFiles/<%= pImageName %>">
				<% } %>
				</div>
					<div id="membername"><%= loginMember.getNickName() %></div>
					
					<div id="memberbtn">
                  <button id='logoutBtn' onclick="location.href='<%= context %>/logout.do'">로그아웃</button>
                  <br>
                  <button id="myPageBtn" onclick="location.href='<%= context %>/myPage.do'">마이페이지</button>
                  <br>
                  <button id="messageBtn" onclick="location.href='<%= context %>/message.do'">쪽지함</button>
               </div>
               <div id="alarm">
                  <button class="glyphicon glyphicon-bell" onclick="location.href='<%= context %>/receiveP.do'"></button>
               </div>
				</div>
			<% } %>
		</div>
		<script>
		<% if(loginMember != null) { %>
			var openProfile = function(closeCallback) {
			    var win = window.open('setProfileImgForm.do', 'setProfileImgForm', 'width=500, height=450');
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
			
			document.getElementById("profileArea").onclick = function() {
				openProfile(function(win) {
					location.reload(true);
				});
			};
		<% } else { %>
      	function findIDPW() {
      		window.open('findIDPWForm.do', 'findIDPWForm', 'width=500, height=135');
		}
      
      <% } %>
		</script>
</body>
</html>