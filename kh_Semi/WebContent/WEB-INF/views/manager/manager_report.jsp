<%@page import="message.model.vo.PageInfo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="manager.model.vo.Report"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "/resources/globalVariable.jsp" %>
<%
   ArrayList<Report> report = (ArrayList<Report>) request.getAttribute("reportList");
   PageInfo pi = (PageInfo)request.getAttribute("pi");
   String option = (String)request.getAttribute("option");
   
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
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/manager_report.css">

</head>
<body>
   <div class="wrap">
   <%@ include file="/WEB-INF/views/common/header.jsp"%>
      <div id="content-area">
         <%@ include file="/WEB-INF/views/common/nav.jsp"%>
   
   <div id="content">
   <br>
      <h1>신고 관리</h1><br><br>
         <form action="category.do">
            <div id="report-area-drop">
               <select id="report_category" name="category">
                  <option value="댓글 신고" class="drop" id="replyRep">댓글 신고</option>
                  <option value="게시글 신고" class="drop" id="boardRep">게시글 신고</option>
                  <option value="상품 신고" class="drop" id="productRep">상품 신고</option>
               </select>
                  <button id="search" type ="submit">검색</button>
               <script> 
                   var category = document.getElementById("report_category");
                   for(var i = 0; i < category.children.length; i++) {
                      if(category.children[i].value == '<%= option %>') { 
                         category.children[i].setAttribute('selected', '');
                      }
                   }
                </script>
            </div>
         </form>
            <br>
            <div class="Report_list_wrap">
               <table class="Report_list">
                  <tr>
                     <td class="report-check"><input type="checkbox" id ="allCheck" onclick = "allChk(this);"></td>
                     <th>No.</th>
                     <th>신고자</th>
                     <th>신고 받은 회원</th>
                     <th>신고 사유</th>
                     <th></th>
                  </tr>
                  <tbody>
                  <% if(report.isEmpty()){ %>
                  <tr>
                     <td colspan="6" align="center">신고 목록이 존재하지 않습니다.</td>
                  </tr>
                  <% } else { %>
                     <% for(Report r : report) { %>
                  <tr>
                     <td class="report-check"><input type="checkbox" name="chk_id" value="<%= r.getMemberId2() %>" onclick="selectOne();"></td>
                     <td><%= r.getReportNum() %></td>
                     <td><%= r.getMemberId() %></td>
                     <td><%= r.getMemberId2() %></td>
                     <td><%= r.getReason() %></td>
                     <td><a href="<%= (r.getPath().split("#").length == 2 ? r.getPath().split("#")[0].replace("option=0", "option=1") + "&cNum=" + r.getPath().split("#")[1] : r.getPath().replace("option=0", "option=1")) %>">바로가기</a></td>
                  </tr>
                     <% } %>
                  <% } %>
                  </tbody>
               </table>
            </div>
            <div class="report-btn">
               <input id="btn1" type="submit" value="회원 정지" onclick="suspend();">
               <input type="hidden" id="term">
               <script>
               var openWindow = function(closeCallback) {
                   var win = window.open('reportStop.do', 'reportStopForm', 'width=500, height=200');
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
               
                  function suspend(){
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
                           form.setAttribute('action', '<%= context %>/stopReport.do');
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
               </script>
               <input id="btn2" type="submit" value="회원 제명" onclick="expulsion();">
               <script>
                  function expulsion(){
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
                        form.setAttribute('action', '<%= context %>/Reportdelete.do');
                        
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
                  
               </script>
               
               <script>
                  var context = document.location.href.split("?");
                  if(typeof context[1] == "undefined") {
                     context[1] = "";
                  } else {
                     context[1] = "&" + context[1].replace(/currentPage=\d{0,}/g, "").replace(/&{0,}/, "");
                     console.log(context[1].replace(/currentPage=\d{0,}/g, "").replace(/&{0,}/, ""));
                  }
               </script>
               <br><br><br>
               <div class="paging" align="center">

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
                        
                        function selectOne(){
                        	var all = document.getElementById()
                        	var chk_id = document.getElementsByName('chk_id');
                                 var count = 0;
                                 
                                 for(var i = 0; i < chk_id.length; i++){
                                    if(chk_id[i].checked){
                                       count++;
                                    } 
                                 }
                                 
                                 if(count != chk_id.length){
                                    all.checked = false;
                                 } else{
                                    all.checked = true;
                                 }
                              }
                  </script>
                  
                  <button onclick="location.href=context[0] + '?currentPage=<%= maxPage %>' + context[1]">&gt;&gt;</button>
               
               </div>

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