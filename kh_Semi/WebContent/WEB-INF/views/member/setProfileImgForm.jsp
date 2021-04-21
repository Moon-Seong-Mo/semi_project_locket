<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필 설정</title>
</head>
<style>
table {
	margin: 0 auto;
	text-align: center;
}
#profileImgArea {
	width: 150px;
    height: 150px; 
    border-radius: 70%;
    overflow: hidden;
}

#profileImg {
	width: 100%;
    height: 100%;
    object-fit: cover;	
}
</style>
<body>
	<h2 align="center">프로필 설정</h2>

	<form action="<%=request.getContextPath()%>/setProfileImg.do" method="post" encType="multipart/form-data">
		<table>
			<tr>
				<td><label>사진선택</label></td>
			</tr>
			<tr>
				<td>
					<div id="profileImgArea" onclick="clickImg();">
						<img id="profileImg" width="150px" height="150px"
							style="border: 1px solid lightgray; border-radius: 80px; overflow: hidden;">
					</div>
				</td>
			</tr>
		</table>
		<div style="display: none;">
			<input type="file" name="profile" id="profile" accept="image/*"
				onchange="loadImg(this)">
		</div>
		<br>
		<br>

		<div class="btns" align="center">
			<input type="submit" id="cancelBtn" value="확인">
		</div>
	</form>
</body>
<script>
	function clickImg() {
		document.getElementById('profile').click();
	}

	function loadImg(value) {
		if (value.files && value.files[0]) {
			var reader = new FileReader();

			reader.onload = function(e) {
				document.getElementById('profileImg').setAttribute('src', e.target.result);
			}

			reader.readAsDataURL(value.files[0]);
		}
	}
</script>
</html>