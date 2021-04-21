<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로컬마켓</title>
<%@ include file="/resources/globalVariable.jsp"%>

<link rel="stylesheet" type="text/css" href="<%=context%>/resources/css/base.css">
<link rel="stylesheet" type="text/css" href="<%=context%>/resources/css/content-area.css">
<link rel="stylesheet" type="text/css" href="<%=context%>/resources/css/content.css">
<link rel="stylesheet" type="text/css" href="<%=context%>/resources/css/product_register.css">

</head>
<body>
   <div class="wrap">
      <%@ include file="/WEB-INF/views/common/header.jsp"%>
      <div id="content-area">
         <%@ include file="/WEB-INF/views/common/nav.jsp"%>
         
         
         <h1>중고물품 등록</h1><hr><br>
   
   <div id="wrap">
   <form>
      <table>
         <tr>
            <td rowspan = 4>
            <select>
               <option value="categorysel" id = "categorysel">카테고리를 선택해 주세요.</option>
               <option value="clothes" id = "clothes">의류</option>
               <option value="furniture" id = "furniture">가구</option>
               <option value="shoes" id = "shoes">신발</option>
               <option value="computer" id = "computer">컴퓨터</option>
            </select>
            </td>
            
            <td>
            <h3>제목</h3>
            </td>
         </tr>
         
         
         <tr>
            <td><input  type ="text" id = title placeholder = "제목을 입력하세요"  ></td>
         </tr>
         
         
         <tr>
            <td><h3>판매가격</h3></td>
         </tr>
         <tr>
            <td><input type ="text" id= price placeholder = "가격을 입력하세요">원</td>
         </tr>
         
      </table>
      </div>
            <input type="file" name="profile_pt" id="profile_pt" onchange="previewImage(this,'View_area')"><br>
         <div id='View_area'></div>

         
         <h3>상품 상태</h3>
         <input type ="radio" > 미개봉<br>
         <input type ="radio" > 거의 새 것<br>
         <input type ="radio" > 사용감 있음<br>
         
         <h3>배송 방법</h3>
         <input type ="radio" > 직거래<br>
         <input type ="radio" > 택배거래<br>
         
         
         <h3>판매자 정보</h3>
         <input type ="text" placeholder = "전화번호를 입력하세요."><br><br><br>
         
         
         <input type ="file" name="file"  accept=".JPEG, .PNG" multiple>
         
         <h3>상품 상세내용</h3>
         <textArea rows="30" cols = "80" placeholder ="내용을입력해주세요"></textArea>
         
         <br>
         <div id = "selbt">
         <input type = "button" id = cancel value = "취소">
         <input type = "button" id = register value = "물품등록">
         </div>
         
   </form>
   
   
   
   
   
   <script>
   function previewImage(targetObj, View_area) {
      var preview = document.getElementById(View_area); 
      var ua = window.navigator.userAgent;

    
      if (ua.indexOf("MSIE") > -1) {
         targetObj.select();
         try {
            var src = document.selection.createRange().text; // get file full path(IE9, IE10에서 사용 불가)
            var ie_preview_error = document.getElementById("ie_preview_error_" + View_area);


            if (ie_preview_error) {
               preview.removeChild(ie_preview_error); //error가 있으면 delete
            }

            var img = document.getElementById(View_area); //이미지가 뿌려질 곳

            //이미지 로딩, sizingMethod는 div에 맞춰서 사이즈를 자동조절 하는 역할
            img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"+src+"', sizingMethod='scale')";
         } catch (e) {
            if (!document.getElementById("ie_preview_error_" + View_area)) {
               var info = document.createElement("<p>");
               info.id = "ie_preview_error_" + View_area;
               info.innerHTML = e.name;
               preview.insertBefore(info, null);
            }
         }
     //ie가 아닐때(크롬, 사파리, FF)
      } else {
         var files = targetObj.files;
         for ( var i = 0; i < files.length; i++) {
            var file = files[i];
            var imageType = /image.*/; //이미지 파일일경우만.. 뿌려준다.
            if (!file.type.match(imageType))
               continue;
            var prevImg = document.getElementById("prev_" + View_area); //이전에 미리보기가 있다면 삭제
            if (prevImg) {
               preview.removeChild(prevImg);
            }
            var img = document.createElement("img"); 
            img.id = "prev_" + View_area;
            img.classList.add("obj");
            img.file = file;
            img.style.width = '200px'; 
            img.style.height = '200px';
            preview.appendChild(img);
            if (window.FileReader) { // FireFox, Chrome, Opera 확인.
               var reader = new FileReader();
               reader.onloadend = (function(aImg) {
                  return function(e) {
                     aImg.src = e.target.result;
                  };
               })(img);
               reader.readAsDataURL(file);
            } else { // safari is not supported FileReader
               //alert('not supported FileReader');
               if (!document.getElementById("sfr_preview_error_"
                     + View_area)) {
                  var info = document.createElement("p");
                  info.id = "sfr_preview_error_" + View_area;
                  info.innerHTML = "not supported FileReader";
                  preview.insertBefore(info, null);
               }
            }
         }
      }
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