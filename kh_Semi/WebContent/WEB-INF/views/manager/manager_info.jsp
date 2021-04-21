<%@page import="message.model.vo.PageInfo"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/resources/globalVariable.jsp" %>
<%
   ArrayList<Member> memberList = (ArrayList<Member>) request.getAttribute("memberList");
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
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/tom.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/manager_info.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/ad.css">

</head>
<body>
   <div class="wrap">
   <%@ include file="/WEB-INF/views/common/header.jsp"%>
      <div id="content-area">
         <%@ include file="/WEB-INF/views/common/nav.jsp"%>
         
         <div id="content">
         <br>
         <h1>회원 정보 관리</h1>
            <div>
            <br>
            <form id="formbo" method="post" action="<%= context %>/searchMember.do" onsubmit="return searchMember();">
               <input id="start_date" name="sDate" type="date">
               <input type="text" id="ic" value="~">
               <input id="last_date" name="eDate" type="date">
               <button id="search" type="submit">가입일로 검색</button>
            </form>
            <br><br>
            </div>
            <div class="Info_list_wrap">
            <table class="Info_list" >
               <thead>
                  <tr>
                     <th><input type="checkbox" id="allCheck"
                        name="chk_all" onclick = "allChk(this);" /></th>
                     <th>회원ID</th>
                     <th>닉네임</th>
                     <th>회원등급</th>
                     <th>가입일</th>
                     <th>상태</th>
                  </tr>
               </thead>
               <tbody>   
                  <% for(Member m : memberList) { %>
                     <tr>
                     <td><input type="checkbox" id="chk_list" name="chk_id" value="<%= m.getId() %>"  /></td>
                     <td><%= m.getId() %></td>
                     <td><%= m.getNickName() %></td>
                     <td><%= m.getRankName() %></td>
                     <td><%= m.getJoinDate() %></td>
                     <td><%= m.getInCheck().equals("Y") ? m.getsCheck().equals("Y") ? "정지" : "가입" : "탈퇴(제명)" %></td>
                  </tr>
                  <% } %>
               </tbody>
            </table><br><br>
            <button id="btn1" onclick="member_delete();">회원 제명</button>
            <button id="btn2" onclick="member_suspended();">회원 정지</button>
            <input type="hidden" id="term">
            </div>
            
            <script>
						var context = document.location.href.split("?");
						if(typeof context[1] == "undefined") {
							context[1] = "";
						} else {
							context[1] = "&" + context[1].replace(/currentPage=\d{0,}/g, "").replace(/&{0,}/, "");
							console.log(context[1].replace(/currentPage=\d{0,}/g, "").replace(/&{0,}/, ""));
						}
					</script>
					
					<br>
					<br>

					<div class="pagingArea" align="center">

						<button onclick="location.href=context[0] + '?currentPage=1' + context[1]">&lt;&lt;</button>
						
						<button onclick="location.href=context[0] + '?currentPage=<%= currentPage - 1 %>' + context[1]" id="beforeBtn">&lt;</button>
						<script>
							if(<%= currentPage %> <= 1) {
								var before = document.getElementById("beforeBtn");
								before.setAttribute('disabled', 'true');
							}
						</script>
						
						<% for(int p = startPage; p <= endPage; p++) { %>
							<% if(p == currentPage) { %>
								<button id="choosen" disabled><%= p %></button>
							<% } else { %>
								<button id="numBtn" onclick="location.href=context[0] + '?currentPage=<%= p %>' + context[1]"><%= p %></button>
							<% } %>
						<% } %>
						
						<button onclick="location.href=context[0] + '?currentPage=<%= currentPage + 1 %>' + context[1]" id="afterBtn">&gt;</button>
						<script>
							if(<%= currentPage %> >= <%= maxPage %>) {
								var after = document.getElementById("afterBtn");
								after.setAttribute('disabled', 'true');
							}
						</script>
						
						<button onclick="location.href=context[0] + '?currentPage=<%= maxPage %>' + context[1]">&gt;&gt;</button>
					
					</div>

         </div>
      </div>
   </div>
   
   <div class="wrap">
      <%@ include file="/WEB-INF/views/common/footer.jsp" %>
   </div>
   <%@ include file="/WEB-INF/views/common/ad.jsp" %>
   <script>
   
      function searchMember() {
         
         var sDate = document.getElementById("start_date").value;
         var eDate = document.getElementById("last_date").value;
         
         if(sDate == "" || eDate == "") {
            alert("날짜를 입력해주세요");
            return false;
         }
         
         return true;
      }
   
      function member_delete(){
         var checkId = document.getElementsByName('chk_id');
         
         var arr = new Array();
         for(var i = 0; i < checkId.length; i++) {
            if(checkId[i].checked) {
               arr.push(checkId[i].value);
            }
         }
         
         if(arr.length == 0) {
            alert('제명할 회원을 선택하세요');
            return;
         }
         if(confirm("정말 회원을 제명시키시겠습니까?")){
            var form = document.createElement("form");
            form.setAttribute('method', 'post');
            form.setAttribute('action', '<%= context %>/deleteMember.do');
            
            for(var i = 0; i < arr.length; i++) {
               var input = document.createElement('input');
               input.setAttribute('type', 'hidden');
               input.setAttribute('name', 'checkId');
               input.setAttribute('value', arr[i]);
               form.appendChild(input);
            }
            document.body.appendChild(form);
            form.submit();
               
         }
      }
      
      var openWindow = function(closeCallback) {
          var win = window.open('stopTerm.do', 'stopTermForm', 'width=500, height=200');
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

      
      function member_suspended(){
         var checkId = document.getElementsByName('chk_id');
         
         var arr = new Array();
         for(var i = 0; i < checkId.length; i++) {
            if(checkId[i].checked) {
               arr.push(checkId[i].value);
            }
         }
         
         if(arr.length == 0) {
            alert('정지할 회원을 선택하세요');
            return;
         }
         
         
         openWindow(function(win) {
            var term = document.getElementById('term').value;
            
            if(term == "") {
               return;
            }
            
            
            if(confirm("정말 회원을 정지시키시겠습니까?")){
               var form = document.createElement("form");
               form.setAttribute('method', 'post');
               form.setAttribute('action', '<%= context %>/stopMember.do');
               var termData = document.createElement('input');
               termData.setAttribute('type', 'hidden');
               termData.setAttribute('name', 'term');
               termData.setAttribute('value', term);
               form.appendChild(termData);
               
               for(var i = 0; i < arr.length; i++) {
                  var input = document.createElement('input');
                  input.setAttribute('type', 'hidden');
                  input.setAttribute('name', 'checkId');
                  input.setAttribute('value', arr[i]);
                  form.appendChild(input);
               }
               document.body.appendChild(form);
               form.submit();
                  
            }
         });
         
      }
      
   // 전체 선택
   function allChk(obj){
           var chkObj = document.getElementsByName("chk_id");
           var rowCnt = chkObj.length - 1;
           var check = obj.checked;
           if (check) { 
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


   </script>   
   
</body>
</html>