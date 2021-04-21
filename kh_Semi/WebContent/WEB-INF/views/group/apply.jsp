<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="group.model.vo.*, member.model.vo.Member, shipping_address.model.vo.*,java.util.ArrayList"%>
<%
   Group g = (Group) request.getAttribute("group");
   /* Member loginMember = (Member) session.getAttribute("loginMember"); */
   Member buyMember = (Member)request.getAttribute("buyMember");
   ArrayList<Shipping_address> list = (ArrayList<Shipping_address>)request.getAttribute("list");
%>

<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<meta charset="UTF-8">
<title>공동구매 신청</title>
<%@ include file="/resources/globalVariable.jsp"%>
<link
   href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap"
   rel="stylesheet">
<link rel="stylesheet" type="text/css"
   href="<%=context%>/resources/css/apply.css">
</head>
<body>
   <div align="center" id="applyFrame">

      <h2>공동구매 신청</h2>

      <table>
         <tr>
            <td class="tax">상품 명 :</td>
            <td align="center"><%=g.getGroupTitle()%></td>
         </tr>
         <tr>
            <td class="tax">구매수량 :</td>
            <td><input type="number" name="amount" id="amount" min='1'
               value="1"></td>
         </tr>
         <tr>
            <td class="tax">가격 :</td>
            <td align="center"><%=g.getPrice()%></td>
         </tr>
         <tr>
            <td class="tax">배송지 :</td>
            <!-- 배송지명 select 드롭다운 선택 시 하단에 주소뜨게하기 -->
            <td><select id="deli">
                  <% if(list != null) { %>
                     <% for(Shipping_address sa : list) { %>
                     <option><%= sa.getAdderss() %></option>
                     <% } %>
                  <% } %>
            </select></td>
         </tr>
         <tr>
            <th class="tax" style="margin-top: 12px;">합계 :</th>
            <th><p id="totalPrice"><%=g.getPrice()%></p></th>
         </tr>
      </table>

      <br>
      <br>

      <div class="btns" align="center">
         <button onclick="requestPay();">결제하기</button>
         <input type="button" id="cancelBtn" onclick="self.close();"
            value="취소하기">
      </div>
   </div>

   <script>
      $(function(){
         $('#amount').click(function(){
            var totalPrice = $('#amount').val() * "<%=g.getPrice()%>";
            $('#totalPrice').text(totalPrice);
         });
      });            
   </script>

   <script>
      var gNum = <%= g.getGroupNum() %>;
      var buyMemberId = '<%= buyMember.getId() %>';
      function requestPay(){
    	 window.resizeTo(1000, 750);
    	  
         var amount = $('#amount').val() * "<%=g.getPrice()%>";
                        
         var name = "<%=g.getGroupTitle()%>";
         var buyer_name = "<%=buyMember.getNickName()%>";
         var buyer_phone = "<%=buyMember.getPhone()%>";
         var buyer_email = "<%=buyMember.getEmail()%>";
         var buyer_addr = $('#deli').val();

         var merchant_uid;
         
         $.ajax({
            url : "apply.do",
            type : "post",
            success : function(merchant_uid) {
               if (merchant_uid != "") {
                  payment(amount, name, buyer_name, buyer_email, buyer_phone, buyer_addr, merchant_uid);
               } else {
                  alert("결제 실패");
               }
            },
            error : function() {
               alert("ajax 통신 실패");
            }

         });

      }

      function payment(amount, name, buyer_name, buyer_email, buyer_phone, buyer_addr, merchant_uid) {
         var IMP = window.IMP;
         IMP.init("imp55592976"); // 가맹점 식별코드 (고유코드)

         IMP.request_pay({ // param
            pg : "html5_inicis", // 이니시스 결제방식
            pay_method : "card", // 무통장 입금

            merchant_uid : merchant_uid, // 결제 고유 식별번호
            amount : amount, // 결제 금액
            name : name, // 주문 대상
            buyer_name : buyer_name, // 주문자이름
            buyer_email: buyer_email,      // 주문자 이메일
            buyer_tel: buyer_phone,         // 주문자 연락처
            buyer_addr: buyer_addr

         }, function(rsp) { // callback
            if (rsp.success) {
               // ajax call -> DB에 저장
               // --> call success callback
               
               var msg = '결제가 완료되었습니다.';
               msg += '\n고유ID : ' + rsp.imp_uid;
               msg += '\n상점 거래ID : ' + rsp.merchant_uid;
               msg += '결제 금액 : ' + rsp.paid_amount;
               msg += '카드 승인번호 : ' + rsp.apply_num;

               alert(msg);
               
               $.ajax({
                  url: "applySuccess.do",
                  type: "post",
                  data: {
                     gNum: gNum,
                     buyMemberId: buyMemberId,
                     buyer_addr: buyer_addr,
                     amount: rsp.paid_amount,
                     merchantUID: rsp.merchant_uid
                     },
                  async: false,
                  success: function(data) {
                     console.log(data.result);
                     if(data.result > 0) {
                        alert('결제내역 저장완료');
                        location.href="<%= context %>/buy_list.do";
                     } else {
                        alert('결제내역 저장실패');
                     }
                     self.close();
                  },
                  error: function() {
                     console.log('에러');
                  }
               });
            } else {
               var msg = '결제에 실패하였습니다.';
               msg += '에러내용 : ' + rsp.error_msg;
            }
            window.resizeTo(800, 500);
         });
        
      }
   </script>

   <script type="text/javascript"
      src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>

</body>
</html>