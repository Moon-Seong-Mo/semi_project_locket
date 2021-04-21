<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, product.model.vo.*, java.util.*"%>
<%@page import="board.model.vo.Board"%>
<%@page import="group.model.vo.Group"%>
<%@page import="board.model.vo.PageInfo"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
   ArrayList<Product> pList = (ArrayList<Product>) request.getAttribute("pList");
   ArrayList<Board> bList = (ArrayList<Board>) request.getAttribute("bList");
   ArrayList<Group> gList = (ArrayList<Group>) request.getAttribute("gList");
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");

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
   href="<%=context%>/resources/css/mainpage.css">
<link rel="stylesheet" type="text/css"
   href="<%=context%>/resources/css/allSearch.css">
<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<link
   href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
   rel="stylesheet">
<style>
</style>
</head>
<body>
   <div class="wrap">
      <%@ include file="/WEB-INF/views/common/header.jsp"%>
      <div id="content-area">
         <%@ include file="/WEB-INF/views/common/nav.jsp"%>

      <div id="content">

      <!--  ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
      <h1>중고물품</h1>
      <br>
      <div class="product_list_wrap">
         <table class="product_list">
         <thead>
            <%if (!pList.isEmpty()) {%>
            <tr>
               <th width="50px">번호</th>
               <th width="50px">닉네임</th>
               <th width="200px">제목</th>
               <th width="100px">가격</th>
               <th width="50px">조회수</th>
            </tr>
            <% } %>
         </thead>



         <tbody>
         <%if (pList.isEmpty()) {%>
         <tr>
            <td>
            <div class="noneProduct">
               <label class="glyphicon glyphicon-alert"> </label> <label>등록된
                  중고 물품이 없습니다.</label> <br>
               <br> <label id="golist"
                  class="glyphicon glyphicon-hand-right"></label>
               <button id="golist"
                  onclick="location.href='<%=context%>/list.pro'">상품
                  목록으로 가기!</button>
               <br> <label id="goRegisterProduct"
                  class="glyphicon glyphicon-hand-right"></label>
               <button id="goRegisterProduct"
                  onclick="location.href='<%=context%>/registerForm.pro'">상품
                  등록하러 가기!</button>
            </div>
            </td>
         </tr>


            <%} else {%>
            <%for (int i = 0; i < pList.size(); i++) { %>
            <% Product p = pList.get(i); %>

            <tr>
               <td><%=p.getProductId()%></td>
               <td><%=p.getNickname()%></td>
               <td class="title" onclick="pDetail(<%= p.getProductId() %>);"><%=p.getTitle()%></td>
               <td><%=p.getPrice()%>원</td>
               <td><%=p.getProductCount()%></td>
            </tr>
            <%}%>
            <%}%>
         </tbody>
      </table>
      
      <script>
            function pDetail(pNum) {
               <% if(loginMember != null) { %>
               location.href='<%= context %>/pdetail.pro?option=0&pId='+ pNum;
               <% } else { %>
               alert('로그인 후 이용 가능합니다.');
               <% } %>
         }
      </script>


      <br><br>
      
      <h4>최근 게시물 10개까지만 검색 되었습니다. 더 많은 게시물을 원하시면 밑 검색창을 이용하세요.</h4>
      
      <form action="productSearch.pro" method="get" class="productForm">
         <br> <select name="searchOption">
            <option value="TITLE">제목</option>
            <option value="MEMBERNAME">닉네임</option>
         </select> <input type="text" name="word" size="20"
            placeholder="검색어를 입력해주세요">
         <button id="searchProduct" type="submit">검색</button>

      </form>
      
      <form action = "<%= context %>/deleteProduct.ad" method="post" id="deleteForm"></form>
      
      <br><br><hr><br>
      
      <!--  ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->





      <h1>자유 게시판</h1>
      <br>
      <br>
      <div class="Board_list_wrap">
         <table class="board_list">
            <thead>
               <% if (!bList.isEmpty()) { %>
               <tr>
                  <th width="50px">번호</th>
                  <th width="50px">닉네임</th>
                  <th width="200px">제목</th>
                  <th width="100px">작성날</th>
                  <th width="50px">조회수</th>
               </tr>
               <% } %>
            </thead>
   
            <tbody>
               <% if (bList.isEmpty()) { %>
         <tr>
            <td>
            <div class="noneBoard">
               <label class="glyphicon glyphicon-alert"> </label> <label>작성된 게시물이 없습니다.</label> 
               <br><br> 
               <label id="golist" class="glyphicon glyphicon-hand-right"></label>
               <button id="golist" onclick="location.href='<%=context%>/boardList.do'">자유게시판 목록으로 가기!</button>
               <br> <label id="goRegisterProduct" class="glyphicon glyphicon-hand-right"></label>
               <button id="goRegisterProduct" onclick="location.href='<%=context%>/boardWriteForm.do'">게시물 등록하러 가기!</button>
            </div>
            </td>
         </tr>
   
   
               <%} else {%>
               <% for (int i = 0; i < bList.size(); i++) { %>
               <% Board b = bList.get(i); %>
   
               <tr>
                  <td><%=b.getBoardNum()%></td>
                  <td><%=b.getNickName()%></td>
                  <td class="title" onclick="bDetail(<%= b.getBoardNum() %>);"><%=b.getBoardTitle()%></td>
                  <td><%=sdf.format(b.getCreateDate())%></td>
                  <td><%=b.getBoardCount()%> </td>
               </tr>
               <% } %>
               <% } %>
            </tbody>
         </table>
         
         <script>
            function bDetail(bNum) {
               location.href='<%= context %>/boardDetail.do?bnum='+ bNum;
         }
         </script>

            
            <br><br>
            <h4>최근 게시물 10개까지만 검색 되었습니다. 더 많은 게시물을 원하시면 밑 검색창을 이용하세요.</h4>

         
            <form action="boardSearch.do" method="get" class="boardForm">
               <br>
               <select name="searchOption">
                  <option value="TITLE">제목</option>
                  <option value="BOARD_C">내용</option>
                  <option value="MEMBERNAME">작성자</option>
               </select>
               <input type="text" name="word" size="20" placeholder="검색어를 입력해주세요">
               <button id="search" type="submit">검색</button> 
            </form>

            
            
            
             <br><br><hr><br>
      
      <!--  ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->





      <h1>공동구매 게시판</h1>
      <br>
      <br>
      <div class="Group_list_wrap">
         <table class="group_list">
            <thead>
               <% if (!gList.isEmpty()) { %>
               <tr>
                  <th width="50px">번호</th>
                  <th width="50px">닉네임</th>
                  <th width="200px">제목</th>
                  <th width="100px">작성날</th>
                  <th width="50px">조회수</th>
               </tr>
               <% } %>
            </thead>
   
            <tbody>
               <% if (gList.isEmpty()) { %>
         <tr>
            <td>
            <div class="noneGroup">
               <label class="glyphicon glyphicon-alert"> </label> <label>해당 공동구매 상품이 없습니다.</label> 
               <br><br> 
               <label id="golist" class="glyphicon glyphicon-hand-right"></label>
               <button id="golist" onclick="location.href='<%=context%>/groupList.do'">공동구매 목록으로 가기!</button>
            </div>
            </td>
         </tr>
               <%} else {%>
               <% for (int i = 0; i < gList.size(); i++) { %>
               <% Group g = gList.get(i); %>
   
               <tr>
                  <td><%=g.getGroupNum()%></td>
                  <td><%=g.getNickName()%></td>
                  <td class="title" onclick="gDetail(<%= g.getGroupNum() %>);"><%=g.getGroupTitle()%></td>
                  <td><%=g.getgDate()%> </td>
                  <td><%=g.getGroupCount()%> </td>
               </tr>
               <% } %>
               <% } %>
            </tbody>
         </table>

      <script>
            function gDetail(bNum) {
               <% if(loginMember != null) { %>
               location.href='<%= context %>/groupDetail.do?bnum='+ bNum;
               <% } else { %>
               alert('로그인 후 이용 가능합니다.');
               <% } %>
         }
         </script>
            
            <br><br>
            <h4>최근 게시물 10개까지만 검색 되었습니다. 더 많은 게시물을 원하시면 밑 검색창을 이용하세요.</h4>

         
            <form action="groupSearch.do" method="get" class="groupForm">
               <br>
               <select name="searchOption">
                  <option value="TITLE">제목</option>
                  <option value="BOARD_C">내용</option>
                  <option value="MEMBERNAME">작성자</option>
               </select>
               <input type="text" name="word" size="20" placeholder="검색어를 입력해주세요">
               <button id="search" type="submit">검색</button> 
            </form>

            <br> <br>
            </div>
            </div>
         </div>
      </div>
   </div>
</div>
      <script src="<%=context%>/resources/js/jquery-3.5.1.min.js"></script>
</body>
</html>