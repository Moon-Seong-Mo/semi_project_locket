<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.util.ArrayList, product.model.vo.*, java.util.*, manager.model.vo.Report" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="oracle.net.aso.f"%>

<% 
   Product p = (Product)request.getAttribute("product");
   ArrayList<Product_File> pfList = (ArrayList<Product_File>)request.getAttribute("pfList");
   Product_File titleImg = null;
   if(pfList.size() > 0) {
      titleImg = pfList.get(0);
   }
   
   ArrayList<PComment> clist = (ArrayList<PComment>) request.getAttribute("commentList");
   SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
      ArrayList<WishList> wlist = (ArrayList<WishList>)request.getAttribute("wish");
      
      String wfImageName = null;
   if(p.getpImage() != null) {
      File wf = new File(p.getpImage());
      wfImageName = wf.getName();
   }
   
   String cNum = (String)request.getAttribute("cNum");
   Report report = (Report)request.getAttribute("r");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로컬마켓</title>
<%@ include file="/resources/globalVariable.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=context%>/resources/css/base.css">
<link rel="stylesheet" type="text/css" href="<%=context%>/resources/css/content-area.css">
<link rel="stylesheet" type="text/css" href="<%=context%>/resources/css/content.css">
<link rel="stylesheet" type="text/css" href="<%=context%>/resources/css/product_detail.css">
</head>
<body>
<div class="wrap">
   <%@ include file="/WEB-INF/views/common/header.jsp"%>
   <div id="content-area">
       <%@ include file="/WEB-INF/views/common/nav.jsp"%>
      <div id="content">
          <div class="outer">
            <br>
            <div id="menuname"> 
               <%= p.getCategory()%> >>
            </div>

            <div id="productTitle">
                <%= p.getTitle()%>
            </div>
            <br>
            <div id="infoBar">
              <div id="profile_area">
                  <div id="nickName">
                     <div id="profile">
                  <% if(wfImageName == null) { %>
                     <label id="memberIcon" class="glyphicon glyphicon-user" style="top:15px; right: 30px;"></label>
                  <% } else { %>
                     <img src="<%= context %>/userProfile_uploadFiles/<%= wfImageName %>">
                  <% } %>     
                  </div>         
                     <%= p.getNickname() %>
                  <% if(loginMember != null && !loginMember.getNickName().equals(p.getNickname())) { %>
                     <form name="sendmsg">
						<input type="hidden" name="userId" value="<%= p.getProductWriter() %>">
						<input type="hidden" name="nickname" value="<%= p.getNickname() %>">
						<input type="button" id="sendmsg" value="쪽지 보내기" onclick="sendMessage();">
					</form>
				  <% } %>
				  <br>
				  <div style="margin-left: 65px; margin-top: -40px; font-size: 15px; font-weight: normal;"><%= p.getRankName() %></div>
				  <br>
				  <div style="margin-left: 65px; margin-top: -40px; font-size: 15px; font-weight: normal;">거래량 : <%= p.getDealCount() %></div>
			      <p id="day_view_c">
                      	 작성일 <%=p.getCreate_date() %>&nbsp;&nbsp;&nbsp;&nbsp;
                    	 조회수 <%= p.getProductCount() %>
                  </p>
                  </div>    
              </div>
            </div>

            <div class="detail" id="thumbTable">   
            <div id="ImgArea" >
                   <br>
                   <img id="titleImg" src="<%= request.getContextPath() %>/product_uploadFiles/<%= titleImg.getChangeName() %>"> 
                   <br>
            </div>  
            <div id="simpleExplain">  
                   <div id="productTitle2">
                       <label>판매</label> <%= p.getTitle()%>
                  </div>
               
                  <div id="price">
                       <%= p.getPrice()%><label>원</label>
                  </div><br>
               
                  <div id="etc">
                       <label>상품 상태  </label>&nbsp;&nbsp;<%= p.getCondition()%><br>
                       <label>배송 방법  </label>&nbsp;&nbsp;<%= p.getDelivery()%><br>
                       <label>지역 </label>&nbsp;&nbsp;<%= p.getLocation1() %> 
                       <% if(!p.getLocation1().equals(p.getLocation2())) { %>
                             <%= p.getLocation2() %> 
                       <% } %>
                       <%= p.getLocation3() %>
                  </div>
               </div>    
           </div>
   
           <label id="warning">
                 거래전 필독! 주의하세요!<br>
             * 안전결제는 카페 내에서만 결제가 가능합니다(카카오톡으로 링크 첨부 후 결제 유도는 사기99%!)<br>
             * 스마트스토어 및 안전결제 게시글인데 현금결제를 유도하는 경우 사기일 가능성이 높습니다.  <br>
             * 거래 전 연락처 및 계좌번호를 사이버캅과 더치트로 조회해 주시기 바랍니다.<br>
             * 중고나라는 통신판매중개자로 통신판매자의 당사자가 아닙니다. 회원과 구매 회원 간의 상품거래 정보 및 거래에 관여하지 않으며 어떠한 의무와 책임도 부담하지 않습니다.<br>
           </label>

            <div class="detail">
              <% for(int i=1; i<pfList.size(); i++){ %>
                  <div class="detailImgArea">
                        <a href="<%= request.getContextPath() %>/product_uploadFiles/<%= pfList.get(i).getChangeName() %>">
                        <img id="detailImg<%= i%>" class="detailImg" 
                        src="<%= context %>/product_uploadFiles/<%= pfList.get(i).getChangeName() %>">
                        </a>
                     </div>
              <% } %>
            </div>
            
            <br><br>

         <div class="wish">
            <input type="hidden" name="pId" value="<%= p.getProductId() %>">
            <% boolean checkWlist = false; boolean checkPwriter = false; %>
            <% if(loginMember.getId().equals(p.getProductWriter())) { %>
               <% checkPwriter = true; %>
            <% } %>
            <% for(int i = 0; i < wlist.size(); i++) { %>
               <% WishList ww = wlist.get(i); %>
               <% if(loginMember.getId().equals(ww.getMemberId()) && ww.getProductId() == p.getProductId()) { %>
                  <% if(checkWlist) {continue;} %>
                  <% checkWlist = true; %>
               <% } %>
            <% } %>
            <% if(!checkPwriter && checkWlist) { %>
               <button id="after" class="glyphicon glyphicon-heart"></button>
            <% } else if(!checkPwriter) { %>
               <label id="before1">찜하기</label>
               <button id="before2" class="glyphicon glyphicon-heart-empty"></button>
            <% } %>
         </div>

         <div id="explainArea">
            <h4>상세 설명</h4>
            <br>
            <%= p.getExplain() %>
         </div>
         <div class="btnArea">
         <% if(!loginMember.getId().equals(p.getProductWriter())) { %>
               <form method="post" name="reportVla" id="reportVla">
                  <input type="hidden" name="pId" value="<%=p.getProductId()%>">
                  <input type="hidden" name="writer" value="<%= p.getNickname() %>">
                  <input type="hidden" name="writerId" value="<%= p.getProductWriter() %>">
                  <a href="javascript:void(0);" onclick="reportSendForm('reportVla', '상품 신고');"class="reportBtn">신고</a>
               </form>            
            <% } %> 
            
            <br><br><br>
            
            <% if(!loginMember.getId().equals(p.getProductWriter())) { %>
               <form action='' method="post" name="newWin">
                  <input type="hidden" name="pId" value="<%=p.getProductId()%>">
                  <input type="hidden" name="pTitle" value="<%= p.getTitle() %>">
                  <input type="hidden" name="writer" value="<%= p.getNickname() %>">
                  <input type="hidden" name="pPrice" value="<%= p.getPrice() %>">
                  <input type="hidden" name="writerId" value="<%= p.getProductWriter() %>">
                  <input type="submit" id="obj" value="거래신청" onclick="wantBuy();">
               </form>            
            <% } %>
         </div>
         <br>
           
           <br><br>
                     
         <!--  댓글  -->
         <%if(loginMember != null && !clist.isEmpty()) { %>
            <h4 id="cc">댓글</h4>
            <br>
            <%for(PComment c : clist) {%>
               <div class="comment_area" <%= cNum == null ? "" : Integer.parseInt(cNum) == c.getCommentNum() ? "style='color: red;'" : "" %>>
               
                  <div id="profile">
                  <% if(c.getpImage() == null) { %>
                     <label id="memberIcon" class="glyphicon glyphicon-user" style="top:15px; right: 30px;"></label>
                  <% } else { %>
                     <img src="<%= context %>/userProfile_uploadFiles/<% out.print(new File(c.getpImage()).getName()); %>">
                  <% } %>  
                  </div>
                  
                  <div class="comment_box">
                     <div class="comment_nickName" id="coco"><%= c.getMemberName() %></div>
                     <div class="comment_text" id="coco"><%= c.getComment() %></div>
                     <div class="comment_date"><%= sdf.format(c.getWrDate()) %></div>
                  </div>
                  <% if(c.getMemberId().equals(loginMember.getId())) { %>
                  <form action="<%= context %>/PCommentDelete.pro" method="post" style="float: right;" onsubmit="return commentDelete();">
                     <input type="hidden" name="pId" value="<%= p.getProductId() %>">
                     <input type="hidden" name="cNum" value="<%= c.getCommentNum() %>">
                     <input type="submit" value="삭제">
                  </form>
                  <% } else { %>
                      <form method="post" name="reportComment<%= c.getCommentNum() %>" id="reportComment<%= c.getCommentNum() %>">
                  		<input type="hidden" name="writer" value="<%= c.getMemberName() %>">
                 		<input type="hidden" name="writerId" value="<%= c.getMemberId() %>">
                 		<input type="hidden" name="cNum" value="<%= c.getCommentNum() %>">
                     <a href="javascript:void(0);" onclick="reportSendForm('reportComment<%= c.getCommentNum() %>', '댓글 신고');"class="reportComment" style="width: 30px; right: 12px; top: 20px;">신고</a>
                     <% } %>
                  </form>
               </div>
            <% } %>
         <% } %>
               
         <% if(loginMember != null) { %>
            <div class="commentWrite">
               <div id="commentInfo">
                  <div id="coco"><%= loginMember.getNickName() %></div>
               </div>
               <form action="PCommentWrite.pro" method="post">
                  <input name="pId" type="hidden" value="<%= p.getProductId() %>">
                  <textarea name="comment"></textarea>
                  <input type="submit" id="cSubmit" value="등록">
               </form>
            </div><br>
         <% } %>
         
         <% if(loginMember != null && loginMember.getId().equals(p.getProductWriter())) { %>
            <div style="padding-top: 20px;">
               <form action="<%= context %>/productUpdateForm.do" method="post" id="writerForm">
                  <input type="hidden" name="pId" value="<%= p.getProductId() %>">
                  <button class="button1" id="pUpdate" type="submit">수정</button>
                  <button class="button1" id="pDelete" type="button" style="background: rgb(223,72,0);" onclick="deleteProduct();">삭제</button>
               </form>  
               <% } %>
         	   <% if(loginMember != null && loginMember.getRankCode() == 99) { %>
        		 <button id="removeCheck" onclick="deleteList(this);" value="<%= p.getProductId() %>">게시물 삭제</button>
      	  	   <% } %><br>
      	 	   <button id="toList" onclick="goList();" class="glyphicon glyphicon-arrow-left"> 목록으로</button>    
            </div>
         </div>
      </div>
   </div>
</div>

   <div class="wrap">
      <%@ include file="/WEB-INF/views/common/footer.jsp"%>
      </div>
      <%@ include file="/WEB-INF/views/common/ad.jsp"%>
   
   <script>
      function goList(){
         location.href='<%= context %>/list.pro';
      }
   
      function deleteProduct() {
         if(confirm("정말 삭제하시겠습니까?")) {
            var form = document.getElementById("writerForm");
            form.setAttribute("action", "<%= context %>/deleteProduct.pro");
            form.submit();
         }
      }
      
      function commentDelete() {
         if(confirm("정말 삭제하시겠습니까?")) {
            return true;
         } else {
            return false;
         }
      }
      
      $(function(){
         $('#before2').click(function(){
            var pId = $(this).parent().children().eq(0).val();      
            var bool = confirm('찜 목록에 추가할까요?');
            
            if(bool) {
               $('#before2').hide();
               $('#before1').hide();
               $('#after').show();
               location.href='<%= request.getContextPath() %>/addWish.pro?option=0&pId=' + pId;
               alert('찜목록 추가 완료!');
            }
         });
      });
      
     function wantBuy(){
         var gsWin = window.open('about:blank','buyingProductForm','width=500,height=500');
         var frm =document.newWin;
         frm.action = '<%= context %>/buyingProductForm.do';
         frm.target ="buyingProductForm";
         frm.method ="post";
         frm.submit();
     }
      
     function deleteList(e) {
          if(confirm('관리자 권한으로 삭제하시겠습니까?')) {
             var pId = e.value;      
             location.href='superDelete.do?pId=' + pId;
          }
      }
     
     function reportSendForm(fname, r){
   	  var re = window.open('', 'reportSend', 'width=450, height=450');
   	  var form = document.getElementById(fname);
   	  var input = document.createElement('input');
   	  input.setAttribute('type', 'hidden');
   	  input.setAttribute('name', 'path');
   	  input.setAttribute('value', window.location.pathname + window.location.search);
   	  form.appendChild(input);
   	  
   	  var cate = document.createElement('input');
   	  cate.setAttribute('type', 'hidden');
   	  cate.setAttribute('name', 'cate');
   	  cate.setAttribute('value', r);
   	  form.appendChild(cate);
   	  
   	  form.action = '<%= context %>/reportSendForm.do';
   	  form.target = "reportSend";
   	  form.submit();
	}
     
   </script>
</body>
<script src="<%= context %>/resources/js/sendMessage.js"></script>
</html>