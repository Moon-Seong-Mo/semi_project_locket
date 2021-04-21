<%@page import="com.sun.corba.se.pept.transport.ContactInfo"%>
<%@page import="product.model.vo.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="product.model.vo.Product_File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<% 
	Product p = (Product)request.getAttribute("product");
	ArrayList<Product_File> pfList = (ArrayList<Product_File>)request.getAttribute("pfList");
	Product_File titleImg = null;
	if(pfList.size() > 0) {
		titleImg = pfList.get(0);
	}
	Product_File img1 = null;
	Product_File img2 = null;
	Product_File img3 = null;
	
	ArrayList<String> locationList = (ArrayList<String>) request.getAttribute("locationList");
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
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/product_register.css">

</head>
<body>
   <div class="wrap">
      <%@ include file="/WEB-INF/views/common/header.jsp"%>
      <div id="content-area">
         <%@ include file="/WEB-INF/views/common/nav.jsp"%>
         <div id ="content">
         <br>
         
        <h1>중고 물품수정</h1>
        
        <br><br>
		<!-- 파일업로드를 위해 enctype을 지정해줘야 된다. -->
		<form action="<%= request.getContextPath() %>/productUpdate.do" method="post" encType="multipart/form-data" id="updateProduct"><!-- 파일올리는 거기 때문에 -->
			<input type="hidden" name="pId" value="<%= p.getProductId() %>">
			<div class="insertArea">
				<table id="insertThumbTable">
				<tr>
                  <th>지역</th>
                  <td colspan="3">
                     <select name="location1" id="location1" onchange="sidoChange();">
                     <option value="0">시/도</option>
                     <% for(String location : locationList) { %>
                     <option><%= location %></option>
                     <% } %>
                     </select>
                     <select name="location2" id="location2" onchange="sigunguChange();" disabled>
                     	<option value="0">시/군/구</option>
                     </select>
                     <select name="location3" id="location3" disabled>
                     	<option value="0">동</option>
                     </select>
                  </td>
               	</tr>
					<tr>
						<th>카테고리</th>
						<td>
							<select id="category" name="category">
								<option value="의류">의류</option>
								<option value="패션잡화">패션잡화</option>
								<option value="디지털가전">디지털가전</option>
								<option value="뷰티/미용">뷰티/미용</option>
								<option value="유아/출산">유아/출산</option>
								<option value="기타">기타</option>
							</select>
						</td>
					</tr>
					
					<tr>
						<th width="100px">물품명</th>
						<td colspan="3"><input type="text" id="title1" name="title" value="<%= p.getTitle() %>"></td>
					</tr>
					
					<tr>
						<th>판매 가격</th>
						<td colspan="3"><input type="text" id="price1" name="price" placeholder="&#8361 가격 입력" value="<%= p.getPrice() %>"></td>
					</tr>
					
					
					<tr>
						<th>상품  상태</th>
						<td><input type ="radio" name="condition" value="미개봉"> 미개봉</td>
				        <td><input type ="radio" name="condition" value="거의 새 것"> 거의 새 것</td>
				        <td><input type ="radio" name="condition" value="사용감 있음"> 사용감 있음</td>
					</tr>
					
					<tr>
						<th>배송 방법</th>
						<td><input type ="radio" name="delivery" value="직거래"> 직거래</td>
				        <td><input type ="radio" name="delivery" value="택배거래"> 택배거래</td>
				        <td><input type ="radio" name="delivery" value="상관없음"> 상관없음</td>
					</tr>
					<tr>
						<td> </td><td> </td>
					</tr>
					<tr>
						<th>대표 이미지</th>
						<td colspan="3">
							<div id="titleImgArea">
								<img id="titleImg" width="525" height="300" <%= titleImg == null ? "" : "src='"  + context + "/product_uploadFiles/" + titleImg.getChangeName() + "'"  %>>
							</div>
						</td>
					</tr>

					<tr>
						<th>추가 사진</th>
						<td>
							<div id="contentImgArea1">
								<img id="contentImg1" width="167" height="100" <%= pfList.size() <= 1 ? "" : pfList.get(1) == null ? "" : "src='"  + context + "/product_uploadFiles/" + pfList.get(1).getChangeName() + "'"  %>> 
							</div>
						</td>
						<td>
							<div id="contentImgArea2">
								<img id="contentImg2" width="167" height="100" <%= pfList.size() <= 2 ? "" : pfList.get(1) == null ? "" : "src='"  + context + "/product_uploadFiles/" + pfList.get(2).getChangeName() + "'"  %>> 
							</div>
						</td>
						<td>
							<div id="contentImgArea3">
								<img id="contentImg3" width="167" height="100" <%= pfList.size() <= 3 ? "" : pfList.get(1) == null ? "" : "src='"  + context + "/product_uploadFiles/" + pfList.get(3).getChangeName() + "'"  %>> 
							</div>
						</td>
					</tr>
					<tr>
						<th>물품 설명</th>
						<td colspan="3"><textarea id="pContent" name="explain" rows="10" cols="80" 
						placeholder="게시글 내용을 작성해주세요. (가품 및 판매금지품목은 게시가 제한됩니다.)" style="resize:none;"><%= p.getExplain() %></textarea>
					</tr>		
				</table>
				
				<br><br>
				
				<div class="btnArea">			
					<input type="button" id="cancelBtn" onclick="location.href='<%= request.getContextPath() %>/list.pro'" value="목록으로">
					<input type="submit" id="obj" value="상품수정">
				</div>
				
				<!-- 파일 업로드 하는 부분 -->
				<div id="fileArea">
					<input type="file" id="thumbnailImg1" multiple="multiple" name="titleImg" onchange="LoadImg(this,1)" accept="image/*">
					<input type="file" id="thumbnailImg2" multiple="multiple" name="thumbnailImg2" onchange="LoadImg(this,2)" accept="image/*">
					<input type="file" id="thumbnailImg3" multiple="multiple" name="thumbnailImg3" onchange="LoadImg(this,3)" accept="image/*">
					<input type="file" id="thumbnailImg4" multiple="multiple" name="thumbnailImg4" onchange="LoadImg(this,4)" accept="image/*">
				</div>
				<script>
					var location1 = document.getElementById("location1");
					for(var i = 0; i < location1.children.length; i++) {
						if(location1.children[i].value == '<%= p.getLocation1() %>') {
							location1.children[i].setAttribute('selected', '');
						}
					}
					
					sidoChange();
					
					setTimeout(setLocation2, 500);
					function setLocation2() {
						var location2 = document.getElementById("location2");
						for(var i = 0; i < location2.children.length; i++) {
							if(location2.children[i].value == '<%= p.getLocation2() %>') {
								location2.children[i].setAttribute('selected', '');
							}
						}
						sigunguChange();
						setTimeout(setLoaction3, 100);
					}
					
					function setLoaction3() {
						var location3 = document.getElementById("location3");
						for(var i = 0; i < location3.children.length; i++) {
							if(location3.children[i].value == '<%= p.getLocation3() %>') {
								location3.children[i].setAttribute('selected', '');
							}
						}
					}
				
				
					var category = document.getElementById("category");
					for(var i = 0; i < category.children.length; i++) {
						if(category.children[i].value === '<%= p.getCategory() %>') { 
							category.children[i].setAttribute('selected', '');
							break;
						}
					}
					
					var condition = document.getElementsByName('condition');
					for(var i = 0; i < condition.length; i++) {
						if(condition[i].value == '<%= p.getCondition() %>') {
							condition[i].setAttribute('checked', '');
							break;
						}
					}
					
					var delivery = document.getElementsByName('delivery');
					for(var i = 0; i < delivery.length; i++) {
						if(delivery[i].value == '<%= p.getDelivery() %>') {
							delivery[i].setAttribute('checked', '');
							break;
						}
					}
					
				
					// 내용 작성 부분의 공간을 클릭할 때 파일 첨부 창이 뜨도록 설정하는 함수
					$(function(){
						
						
						$("#fileArea").hide();
						
						$("#titleImgArea").click(function(){
							$("#thumbnailImg1").click();
						});
						$("#contentImgArea1").click(function(){
							$("#thumbnailImg2").click();
						});
						$("#contentImgArea2").click(function(){
							$("#thumbnailImg3").click();
						});
						$("#contentImgArea3").click(function(){
							$("#thumbnailImg4").click();
						});
					});
					
					var check1 = false;
					var check2 = false;
					var check3 = false;
					var check4 = false;
					
					// 각각의 영역에 파일을 첨부 했을 경우 미리 보기가 가능하도록 하는 함수
					function LoadImg(value, num){
						if(value.files && value.files[0]){
							var reader = new FileReader();
							
							var form = document.getElementById('updateProduct');
							var input = document.createElement('input');
							input.setAttribute("type", "hidden");
							input.setAttribute("name", "changeFile");
							
							reader.onload = function(e){								
								switch(num){
								case 1: 
									$("#titleImg").attr("src", e.target.result);
									if(!check1) {
										<%= titleImg == null ? "" : "input.setAttribute('value', '" + titleImg.getPfId() + "');" %>
										form.appendChild(input);
										check1 = true;
									}
									break;
								case 2:
									$("#contentImg1").attr("src", e.target.result);
									if(!check2) {
										<%= pfList.size() <= 1 ? "" : pfList.get(1) == null ? "" : "input.setAttribute('value', '" + pfList.get(1).getPfId() + "'); form.appendChild(input);" %>
										check2 = true;
									}
									break;
								case 3: 
									$("#contentImg2").attr("src", e.target.result);
									if(!check3) {
										<%= pfList.size() <= 2 ? "" : pfList.get(2) == null ? "" : "input.setAttribute('value', '" + pfList.get(2).getPfId() + "'); form.appendChild(input);" %>
										check3 = true;
									}
									break;
								case 4:
									$("#contentImg3").attr("src", e.target.result);
									if(!check4) {
										<%= pfList.size() <= 3 ? "" : pfList.get(3) == null ? "" : "input.setAttribute('value', '" + pfList.get(3).getPfId() + "'); form.appendChild(input);" %>
										check4 = true;
									}
									break;
								}
							}
							
							reader.readAsDataURL(value.files[0]);
						}
					}
					
					function productSubmit() {
		                   var title = document.getElementById("title1").value;
		                   var price = document.getElementById("price1").value;                   
		                    var content = document.getElementById("pContent").value;                    
		                    var condition = document.getElementsByName('condition');
		                    var delivery = document.getElementsByName('delivery');
		                    var image = document.getElementById("titleImg").src;
		                    var cate = document.getElementsByName('category').value;

		                    if(title == "") {
		                       alert("제목을 입력하세요");
		                       return;
		                    } else if(content == "") {
		                      alert("내용을 입력하세요");
		                      return;
		                   } else if(price == "") {
		                      alert("가격을 입력하세요");
		                      return;
		                    } else if(image == "") {
		                     alert("사진을 최소 1장 이상 등록해주세요.");
		                     return;
		                   } else if(cate == "") {
		                    alert("카테고리를 선택해주세요.");
		                    return;
		                  }
		                    
		                    //////상태체크 /////
		                    var sel_con = null;
		                  for(var i=0; i < condition.length; i++){
		                     if(condition[i].checked == true){ 
		                        sel_con = condition[i].value;
		                     }
		                  }
		                  if(sel_con == null){
		                       alert("상품 상태를 선택하세요."); 
		                     return false;
		                  }
		                  //////배송체크 /////
		                  var sel_del = null;
		                  for(var i=0; i < delivery.length; i++){
		                     if(delivery[i].checked == true){ 
		                        sel_del = delivery[i].value;
		                     }
		                  }
		                  if(sel_del == null){
		                       alert("배송 방법을 선택하세요."); 
		                     return false;
		                  }
		                  
		                  var regexp = /^[0-9]*$/
		                  v = $('#price1').val();
		                  if(!regexp.test(v)) {
		                        alert("가격은 숫자만 입력하세요");
		                      $('#price1').val(v.replace(regexp,''));
		                      return false;
		                  }
		                     
		                      document.getElementById('updateProduct').submit();            
		               }   
					
					function sidoChange() {
		            	 var location1 = document.getElementById('location1').value;
		            	 var location2 = document.getElementById('location2');
		            	 var location3 = document.getElementById('location3');
		            	 location2.innerHTML = "";
		            	 location3.innerHTML = "";
		            	 if(location1 != '0') {
			            	 $.ajax({
			            		 url: 'addr.do',
			            		 type: 'get',
			            		 data: {sido: location1},
			            		 success: function(data) {
									for(var i in data) {
										var option = document.createElement('option');
										option.innerHTML = data[i];
										location2.appendChild(option);
										
									}
									sigunguChange();
									location2.removeAttribute('disabled');
								}
			            	 });
		            	 } else {
		            		 location2.setAttribute('disabled', "disabled");
		            		 location3.setAttribute('disabled', "disabled");
		            		 location2.innerHTML = "<option value='0'>시/군/구</option>";
		            		 location3.innerHTML = "<option value='0'>동</option>";
		            	 }
					 }
		             
		             function sigunguChange() {
		            	 var location1 = document.getElementById('location1').value;
		            	 var location2 = document.getElementById('location2');
		            	 var location3 = document.getElementById('location3');
		            	 location3.innerHTML = "";
		            	 if(location2 != '0') {
			            	 $.ajax({
			            		 url: 'addr.do',
			            		 type: 'get',
			            		 data: {sido: location1, sigungu: location2.value},
			            		 success: function(data) {
									for(var i in data) {
										var option = document.createElement('option');
										option.innerHTML = data[i];
										location3.appendChild(option);
									}
									location3.removeAttribute('disabled');
								}
			            	 });
		            	 } else {
		            		 location3.setAttribute('disabled', "disabled");
		            		 location3.innerHTML = "<option value='0'>동</option>";
		            		 
		            	 }
		             }
				</script>
				
			</div>
			<br>
			</form>
		</div>
	</div>
</div>

   

   <div class="wrap">
      <%@ include file="/WEB-INF/views/common/footer.jsp"%>
   </div>

   <%@ include file="/WEB-INF/views/common/ad.jsp"%>
</body>
</html>