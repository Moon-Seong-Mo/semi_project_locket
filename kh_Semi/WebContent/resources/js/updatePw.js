var form = document.getElementById("updatePwForm");
form.onsubmit = function() {
	var userPw = document.getElementById("userPw").value;
	var newPw = document.getElementsByName("newPw")[0].value;
	var newPw2 = document.getElementsByName("newPw2")[0].value;
	
	if(!pwCheck(userPw) || !pwCheck(newPw) || !pwCheck(newPw2)) {
		alert("비밀번호 규칙에 맟게 입력하세요.");
		return false;
	} else if(newPw != newPw2) {
		alert("변경 비밀번호 일치 여부를 확인해 주세요.");
		return false;
	} else {
		return true;
	}
};

var pwCheck = function(value) {
	var regExp = /^[a-zA-Z][a-zA-Z\d!*$]{5,19}$/;

	if (regExp.test(value)) {
		return true;
	} else {
		return false;
	}
};
