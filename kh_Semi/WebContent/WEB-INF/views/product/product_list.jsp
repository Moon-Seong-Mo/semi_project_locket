<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page
   import="java.util.ArrayList, product.model.vo.*, board.model.vo.PageInfo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
   ArrayList<String> locationList = (ArrayList<String>) request.getAttribute("locationList");
   ArrayList<String> locationList2 = (ArrayList<String>) request.getAttribute("locationList2");
   ArrayList<String> locationList3 = (ArrayList<String>) request.getAttribute("locationList3");
   String location1 = (String) request.getAttribute("location1");
   String location2 = (String) request.getAttribute("location2");
   String location3 = (String) request.getAttribute("location3");

   String option = (String)request.getAttribute("option");
   ArrayList<Product> pList = (ArrayList<Product>)request.getAttribute("pList");
   ArrayList<Product_File> pfList = (ArrayList<Product_File>)request.getAttribute("pfList");
   PageInfo pi = (PageInfo)request.getAttribute("pi");
   
   int listCount = pi.getListCount();
   int currentPage = pi.getCurrentPage();
   int maxPage = pi.getMaxPage();
   int startPage = pi.getStartPage();
   int endPage = pi.getEndPage();
   
   String option2 = (String) request.getAttribute("option2");
   String word = (String) request.getAttribute("word");
   
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로컬마켓</title>
<%@ include file="/resources/globalVariable.jsp"%>
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/base.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/content-area.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/content.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/product_list.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
</head>
<body>
   <div class="wrap">
      <%@ include file="/WEB-INF/views/common/header.jsp"%>
      <div id="content-area">
         <%@ include file="/WEB-INF/views/common/nav.jsp"%>

         <div id="content">
            <h1>중고 물품</h1>

            <br> <br>

            <form action="categorySearch.pro" method="get" class="catesearch" id="catesearch" onsubmit="submitForm();">
             <select name="location1" id="location1" onchange="sidoChange();">
                     <option value="0">시/도</option>
                     <% for(String location : locationList) { %>
                     <option><%= location %></option>
                     <% } %>
                     </select>
                     <select name="location2" id="location2" onchange="sigunguChange();" disabled>
                     	<option value="0">시/군/구</option>
                     	<% if(locationList2 != null) { %>
                     	<% for(String location : locationList2) { %>
	                    <option><%= location %></option>
	                    <% } %>
	                    <% } %>
                     </select>
                     <select name="location3" id="location3" onchange="dongChange();" disabled>
                     	<option value="0">동</option>
                     	<% if(locationList3 != null) { %>
                     	<% for(String location : locationList3) { %>
	                     <option><%= location %></option>
	                    <% } %>
	                    <% } %>
             </select>
               <br> 
               <select name="categorySearch" id="categorySearch">
                  <option value="0">카테고리 선택</option>
                  <option value="의류">의류</option>
                  <option value="패션잡화">패션잡화</option>
                  <option value="디지털가전">디지털가전</option>
                  <option value="뷰티/미용">뷰티/미용</option>
                  <option value="유아/출산">유아/출산</option>
                  <option value="기타">기타</option>
               </select>

               <script> 
                   var categorySearch = document.getElementById("categorySearch");
                   for(var i = 0; i < categorySearch.children.length; i++) {
                      if(categorySearch.children[i].value === '<%= option %>') { 
                         categorySearch.children[i].setAttribute('selected', '');
                      }
                   }
                   
                   /* function cateCheck() {
                     if(document.getElementById('categorySearch').value == '0') {
                        alert('카테고리를 선택해주세요');
                        return false;
                     } else {
                        return true;   
                     } 
                  } */
                </script>

               <button id="search" type="submit">검색</button>
			</form>
			
            <div id="item-list-product">
               <% if(pList.isEmpty() || pfList.isEmpty()) { %>
               <div class="none">
                  <label class="glyphicon glyphicon-alert"> </label> <label>조회된
                     중고 물품이 없습니다.</label> <br> <br> <br> <label id="golist"
                     class="glyphicon glyphicon-hand-right"></label>
                  <button id="golist"
                     onclick="location.href='<%= context %>/list.pro'" style="width:300px; background-color: #FFFCF5;">상품
                     목록으로 가기!</button>
                  <br> <br> <label id="goRegister"
                     class="glyphicon glyphicon-hand-right"></label>
                  <button id="goRegister"
                     onclick="location.href='<%= context %>/registerForm.pro'" style="width:300px; background-color: #FFFCF5;">상품
                     등록하러 가기!</button>
               </div>
               <% } else { %>
               <% for(int i = 0; i < pList.size(); i++) { %>
               <% Product p = pList.get(i); %>
                  <div class="item" align="center">
                     <input type="hidden" value="<%= p.getProductId() %>" name="productNum">
                     <% for(int j = 0; j < pfList.size(); j++){ %>
                        <% Product_File pf = pfList.get(j); %>
                     <% if(pf.getP_num() == p.getProductId()){ %>
                        <img src="<%= request.getContextPath() %>/product_uploadFiles/<%= pf.getChangeName() %>">
                     <% } %>
                     <% } %>
                     <br>
                     <div class="itemLocation"><%= p.getLocation1() %> <%= p.getLocation1().equals(p.getLocation2()) ? "" : p.getLocation2() %> <%= p.getLocation3() %></div>
                     <p>
                        <% if (p.getRankCode() == 4) { %> 
                           <label id="star" class="glyphicon glyphicon-star"></label>
                        <% } %>
                        &nbsp;&nbsp;No.
                        <%= p.getProductId() %>&nbsp;&nbsp;&nbsp;&nbsp;<%= p.getTitle() %><br>
                        <%= p.getPrice() %>원&nbsp;&nbsp;&nbsp;&nbsp;조회수 :
                        <%= p.getProductCount() %>
                     </p>
                  </div>
                  <% } %>
               <% } %>
			 </div>
			 
                  <select id="so" name="searchOption">
                     <option value="TITLE">제목</option>
                     <option value="MEMBERNAME">닉네임</option>
                  </select> 
                  <input type="text" id="word" name="word" size="20" placeholder="검색어를 입력해주세요" value="<%= word == null ? "" : word %>">
                  <button id="searchWord" type="button">검색</button>


               <script>
                  var context = document.location.href.split("?");
                  if(typeof context[1] == "undefined") {
                     context[1] = "";
                  } else {
                     context[1] = "&" + context[1].replace(/currentPage=\d{0,}/g, "").replace(/&{0,}/, "");
                  }
               </script>

               <br>

               <div class="paging" align="center">
                  <!-- 맨 처음으로 -->
                  <button onclick="location.href=context[0] + '?currentPage=1' + context[1]">&lt;&lt;</button>
                  <!-- 이전 페이지로 -->
                  <button onclick="location.href=context[0] + '?currentPage=<%= currentPage - 1 %>' + context[1]" id="beforeBtn">&lt;</button>
                  <script>
                  if(<%= currentPage %> <= 1) {
                     var before = $('#beforeBtn');
                     before.attr('disabled', 'true'); //비활성화 시키겠다!
                  }
               </script>
                  <!-- 숫자 목록 버튼 -->
                  <% for(int p = startPage; p <= endPage; p++) { %>
                  <% if(p == currentPage) { %>
                  <button id="choosen" disabled><%= p %></button>
                  <% } else {  %>
                  <button id="numBtn"
                     onclick="location.href=context[0] + '?currentPage=<%= p %>' + context[1]"><%= p %></button>
                  <% }  %>
                  <% } %>

                  <!-- 다음 페이지로 -->
                  <button onclick="location.href=context[0] + '?currentPage=<%= currentPage + 1 %>' + context[1]" id="afterBtn">&gt;</button>
                  <script>
                     if(<%= currentPage %> >= <%= maxPage %>) {
                        var after = $('#afterBtn');
                        after.attr('disabled', 'true');
                     }
                  </script>
                  <!-- 맨 끝으로 -->
                  <button onclick="location.href=context[0] + '?currentPage=<%= maxPage %>' + context[1]">&gt;&gt;</button>
               </div>
               <script>
                  $(function(){
                     $('.item').click(function(){
                        <% if(loginMember != null) { %>
                           var pId = $(this).children().eq(0).val();
                           location.href='<%= context %>/pdetail.pro?option=0&pId='+ pId;            
                        <% } else { %>
                           alert('죄송합니다. 회원만 상세보기가 가능합니다!');
                        <% } %>
                     });
                  });
                  
                  <% if(location1 != null) { %>
                  var location1 = document.getElementById("location1");
					for(var i = 0; i < location1.children.length; i++) {
						if(location1.children[i].value === '<%= location1 %>') {
							location1.children[i].setAttribute('selected', '');
						}
					}
                  <% } %>
                  <% if(location2 != null) { %>
                  var location2 = document.getElementById("location2");
					for(var i = 0; i < location2.children.length; i++) {
						if(location2.children[i].value === '<%= location2 %>') {
							location2.children[i].setAttribute('selected', '');
						}
					}
					<% if(!location1.equals("0")) { %>
					location2.removeAttribute('disabled');
					<% } %>
                  <% } %>
                  <% if(location3 != null) { %>
                  var location3 = document.getElementById("location3");
					for(var i = 0; i < location3.children.length; i++) {
						if(location3.children[i].value === '<%= location3 %>') {
							location3.children[i].setAttribute('selected', '');
						}
					}
					<% if(!location2.equals("0")) { %>
					location3.removeAttribute('disabled');
					<% } %>
                  <% } %>
                  
                  <% if(option != null) { %>
                  var option = document.getElementById("categorySearch");
					for(var i = 0; i < option.children.length; i++) {
						if(option.children[i].value === '<%= option %>') {
							option.children[i].setAttribute('selected', '');
						}
					}
                  <% } %>
                  
                  <% if(option2 != null) { %>
                  var option2 = document.getElementById("so");
					for(var i = 0; i < option2.children.length; i++) {
						if(option2.children[i].value === '<%= option2 %>') {
							option2.children[i].setAttribute('selected', '');
						}
					}
                  <% } %>
                  
                  <% if(word != null) { %>
                  var word = document.getElementById("word");
					for(var i = 0; i < word.children.length; i++) {
						if(word.children[i].value === '<%= word %>') {
							word.children[i].setAttribute('selected', '');
						}
					}
                  <% } %>
                  
                  
                  function sidoChange() {
                	 var form = document.getElementById('catesearch');
                	 var location2 = document.getElementById('location2');
                	 location2.removeAttribute('disabled');
                	 location2.value = '0';
                	 var location3 = document.getElementById('location3');
                	 location3.removeAttribute('disabled');
                	 location3.value = '0';
                	 
                	 //inputData(form);
                	 
                 	 form.submit();
           
     			 }
                  
                  function sigunguChange() {
                	 var form = document.getElementById('catesearch');
                	 var location3 = document.getElementById('location3');
                	 location3.removeAttribute('disabled');
                	 location3.value = '0';
                	 
                	 //inputData(form);
                	 
                  	 form.submit();
            
                  }
                  
                  function dongChange() {
                	 var form = document.getElementById('catesearch');
                	 
                	 //inputData(form);
                	 
                   	 form.submit();
				  }
                  
                document.getElementById('searchWord').onclick = function () {
					submitForm();
				};
				
                function submitForm() {
                	var form = document.getElementById('catesearch');
                	
                	inputData(form);
                	
               	 	form.submit();
				}
                
                function inputData(form) {
                	var so = document.getElementById('so').value;
                	var word = document.getElementById('word').value;
                	
                	var input1 = document.createElement('input');
                	input1.setAttribute('name', 'searchOption');
                	input1.setAttribute('type', 'hidden');
                	input1.setAttribute('value', so);
                	var input2 = document.createElement('input');
                	input2.setAttribute('name', 'word');
                	input2.setAttribute('type', 'hidden');
                	input2.setAttribute('value', word);
                	
                	form.appendChild(input1);
                	form.appendChild(input2);
				}
               </script>
            </div>
         </div>
      </div>
   <div class="wrap">
      <%@ include file="/WEB-INF/views/common/footer.jsp"%>
   </div>
   <%@ include file="/WEB-INF/views/common/ad.jsp"%>
</body>
</html>