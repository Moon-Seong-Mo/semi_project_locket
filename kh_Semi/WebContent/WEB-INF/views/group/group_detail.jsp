<%@page import="java.text.DecimalFormat"%>
<%@ page import="group.model.vo.Attachment"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="group.model.vo.Group"%>
<%@ page import="apply.model.vo.Apply"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>   

<%
   Group g = (Group) request.getAttribute("group");
   Apply a = (Apply) request.getAttribute("apply");
   int applyCount = (int) request.getAttribute("applyCount");
   String contentText = g.getExplain();
   contentText = contentText.replaceAll("\r\n", "<br>");
   ArrayList<Attachment> flist = (ArrayList<Attachment>) request.getAttribute("fileList");
   boolean checkDate = (boolean) request.getAttribute("checkDate");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로컬마켓</title>
<%@ include file="/resources/globalVariable.jsp"%>

<link rel="stylesheet" type="text/css"
   href="<%=context%>/resources/css/base.css">
<link rel="stylesheet" type="text/css"
   href="<%=context%>/resources/css/content-area.css">
<link rel="stylesheet" type="text/css"
   href="<%=context%>/resources/css/content.css">
<link rel="stylesheet" type="text/css"
   href="<%=context%>/resources/css/group_detail.css">


</head>
<body>
   <div class="wrap">
      <%@ include file="/WEB-INF/views/common/header.jsp"%>
      <div id="content-area">
         <%@ include file="/WEB-INF/views/common/nav.jsp"%>

         <div id="content">
            <h1>공동구매 물품</h1>
            <% if(loginMember != null && loginMember.getRankCode() == 99){ %>
            <form action="<%= context %>/buy_list_a.do" method="get" id="buy_list_a">
               <input type="hidden" id="gNum" name="gNum" value="<%= g.getGroupNum() %>">
               <input type='submit' onclick="location.href='<%= context %>/buy_list_a.do'" value="주문자 조회" id="buy_list_admin">
            </form>
            <% } %>
            <br>
            <div id="product-box">
               <div>
                  <span id="main-inform"><b><%=g.getGroupTitle()%></b></span>
                  <br><br>
                  <div class="explain">
                     <span id="n">게시자 : <%=g.getNickName()%> </span>
                     <span style="float: right;">구매자 : <%= applyCount %>명</span>
                     <% if(loginMember != null && !loginMember.getNickName().equals(g.getNickName())) { %>
                        <form name="sendmsg">
                           <input type="hidden" name="userId" value="<%= g.getGroupWriter() %>">
                           <input type="hidden" name="nickname" value="<%= g.getNickName() %>">
                           <input type="button" id="sendmsg" value="쪽지 보내기" onclick="sendMessage();">
                        </form>
                     <% } %>                  
                     <br> 시작일 : <span><%=g.getStartDate()%></span>&nbsp;&nbsp;&nbsp;&nbsp;종료일 : <span><%=g.getEndDate()%></span>    
                     <span id="groupCount" style="float: right;">조회수 : <%=g.getGroupCount()%></span>
                  </div>

                  <hr>
               </div>

               <div>
                  <div id="product-body1">
                     <div class="explain">
                        <%=g.getExplain()%>
                     </div>
                  </div>
                  <br><br>
                  <div id="need">
                  안심하세요 !!!  <br>
                  * 관리자 검정 및 검수하에 공동구매가 진행되오니, 모든 책임 및 배상은 로켓에서 집니다. <br>
                  * 거래 취소를 원할 시 관리자에게 쪽지를 보내주세요 *
                     (취소 까지 1~4일이 소요됩니다.)
                  </div>
               </div>
               <div id="product-body2">
   
                  <% if (flist.size() > 0) { %>
                  <hr>
                  <% for (int i = 0; i < flist.size(); i++) { %>
                  <%Attachment at = flist.get(i);%>
                           <img src= "<%=context%>/group_uploadFiles/<%=at.getChangeName()%>">
                           <% } %>   
                      <% } %>          
               </div>
               <br>
               <p>
                  <span class="explain"> 가격 : <% DecimalFormat df = new DecimalFormat("###,###"); %> <%= df.format(g.getPrice()) %> 원 </span> 
               </p>
               <br>

               <hr>
               <br>
               <% if (loginMember != null && loginMember.getRankCode() != 99 && checkDate) { %>
               <form name="formBnum">
                  <input type="hidden" id="bnum" name="bnum" value="<%= g.getGroupNum() %>"> 
                  <button id="ApplyBtn" onclick="applySubmit();">공동구매 신청</button>
               </form>
               <% } %>
               <div id="product-footer">
               </div>
                  <button id="toList" class="glyphicon glyphicon-arrow-left" onclick="location.href='<%= context %>/groupList.do'"> 목록으로</button>
            </div>

            <div id="del_mod_bt">
               <% if (loginMember != null && loginMember.getRankCode() == 99 && applyCount == 0) { %>
                  <form action="<%= context %>/updateGroupForm.do" method="post" id="writerForm">
                     <input type="hidden" name="bnum" value="<%= g.getGroupNum() %>">
                     <button type="submit" id="mod-btn" class="my-btn">수정</button>
                     <button type="button" id="del-btn" class="my-btn" onclick="deleteGroup();">삭제</button>
                  </form>
               <% } %>
            </div>
         </div>
      </div>
   </div>
   
   <div class="wrap">
      <%@ include file="/WEB-INF/views/common/footer.jsp"%>
   </div>
   <script>
      function deleteGroup() {
         if(confirm("정말 삭제하시겠습니까?")) {
            var form = document.getElementById("writerForm");
            form.setAttribute("action", "<%= context %>/deleteGroup.do");
            form.submit();
         }
      }
      
      function applySubmit() {
         <% if(a != null && g.getGroupNum() == a.getgNum() && loginMember.getId().equals(a.getMemberId()))  { %>
            alert('이미 구매하신 상품입니다!');
         <% } else { %>
               window.open('', 'pay', 'width=800, height=500');
               var form = document.formBnum;
               form.method = 'post';
               form.target = 'pay';
               form.action = 'applyForm.do';
               
               form.submit();
         <% } %>
         }
   </script>
   <%@ include file="/WEB-INF/views/common/ad.jsp"%>
</body>
<script src="<%= context %>/resources/js/sendMessage.js"></script>
</html>