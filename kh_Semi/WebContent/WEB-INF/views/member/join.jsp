<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로컬마켓</title>
<%@ include file="/resources/globalVariable.jsp" %>

<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/base.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/content-area.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/content.css">
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/join.css">

</head>
<body>
   <div class="wrap">
      <%@ include file="/WEB-INF/views/common/header.jsp"%>
      <div id="content-area">
         <%@ include file="/WEB-INF/views/common/nav.jsp"%>

         <div id="content">
            <div id="join">
               <h1><b>회원 가입</b></h1>
               <br>
               <div>
                  <b><font size="8em" color="orange">L O C K E T</font></b>
               </div>
               <form id="joinForm" method="post" action="<%= context %>/join.do">
                  <div><b>아 이 디*</b></div>
                  <div>
                     <input type="text" class="username_input" name="userId" id="userId" size="32" maxlength="20" required>
                     <button type="button" class="id_check_button" id="idCheckBtn">중복확인</button>
                     <br><br>
                  </div>
   
                  <div><b>비 밀 번 호*</b></div>
                  <div>
                     <input type="password" size="32" maxlength="20" name="userPw" id="userPw" required><br> <br>
                  </div>
   
                  <div><b>비 밀 번 호 재 확 인*</b></div>
                  <div>
                     <input type="password" size="32" maxlength="20" name="pwCheck" id="pwCheck" required><br> <br>
                  </div>
   
                  <div><b>비 밀 번 호 찾기 힌트*</b></div>
                  <div>
                     <select name="pwHint" id="pwHint">
                        <option value="0">질문을 선택해 주세요.</option>
                        <option>나의 보물 1호는?</option>
                        <option>다시 태어나면 되고 싶은 것은?</option>
                        <option>유년 시절 가장 생각나는 친구의 이름은 ?</option>
                        <option>추억하고 싶은 날짜가 있다면?</option>
                     </select>
                  </div>
                  <br>
   
                  <div><b>비 밀 번 호 찾기 답변*</b></div>
                  <div>
                     <input size="32" name="pwAns" id="pwAns" required><br> <br>
                  </div>
   
                  <div><b>이 메 일*</b></div>
                  <div>
                     <input size="32" name="email" id="email" required><br> <br>
                  </div>
   
                  <div><b>성 별*</b></div>
                  <div>
                     <input type="radio" name="gender" value="M" required checked>남자 
                     <input type="radio" name="gender" value="F" required>여자
                  </div>
                  <br>
                  
                  <div><b>닉 네 임*</b></div>
                  <div>
                     <input size="16" maxlength="15" name="nickname" id="nickname" required>
                     <button type="button" id="checkNickname">중복확인</button>
                  </div>
                  
                  <br>
   
                  <div><b>전화번호*</b></div>
                  <div>
                     <select name="phone1" id="phone1">
                        <option>010</option>
                        <option>011</option>
                        <option>016</option>
                     </select>
                     -
                     <input type="text" maxlength="4" size="4" name="phone2" id="phone2" required>
                     -
                     <input type="text" maxlength="4" size="4" name="phone3" id="phone3" required>
                  </div>
               
                  <br>
   
                  <div>
                     <input type="checkbox" id="checkterms"><b> 약관 전체 동의</b>
                  </div>
                  <br>
                  <div>
                     <input type="checkbox" name="terms"> 개인정보 수집 동의(필수) 
                     <font color="gray"><a>약관보기</a></font>
                  </div>
                  <div>
                     <input type="checkbox" name="terms" id="select"> 마케팅 활용 및 광고성 정보 수신 동의(선택) 
                     <font color="gray"><a>약관보기</a></font>
                  </div>
                  <input type="hidden" name="mCheck" id="mCheck" value="">
                  <br> <br>
   
                  <div>
                     <button type="submit" id="submit" style="width: 380px">가입 완료</button>
                  </div>
               </form>
            </div>
         </div>
      </div>
   </div>

   <div class="wrap">
      <%@ include file="/WEB-INF/views/common/footer.jsp" %>
   </div>
   
   <%@ include file="/WEB-INF/views/common/ad.jsp" %>
</body>
<script src="<%= context %>/resources/js/jquery-3.5.1.min.js"></script>
<script src="<%= context %>/resources/js/join.js"></script>
</html>