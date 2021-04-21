
var nickc = true;

var qCheck = function() {
	var q = document.getElementById("pwHint").value;
	var a = document.getElementById("pwAns").value;

	if (q == '0') {
		alert("비밀번호 힌트 질문을 선택해 주세요");
		return false;
	} else if (a == "") {
		alert("비밀번호 힌트 답을 입력해 주세요.");
		return false;
	} else {
		return true;
	}
};

var emailCheck = function() {
	var regExp = /^[a-zA-Z]([0-9a-zA-Z])*@[0-9a-zA-Z]+.[0-9a-zA-Z]+.[a-zA-Z]{2,3}$/i;
	var value = document.getElementById("email").value;
	
	if (regExp.test(value)) {
		return true;
	} else {
		return false;
	}
};

var phoneCheck = function() {
	var regExp = /\d{3,4}/;
	var value1 = document.getElementById("phone2").value;
	var value2 = document.getElementById("phone3").value;
	
	if(regExp.test(value1) && regExp.test(value2)) {
		return true;
	} else {
		return false;
	}
};

var nickName = document.getElementById("nickname");
nickName.keonkeydown = function() {
	nickc = false;
};

var checkNickname = document.getElementById("checkNickname");
checkNickname.onclick = function() {
	nickc = false;
	var regExp = /^[a-zA-Z][a-z0-9]{2,14}$/;
	var value = document.getElementById("nickname").value;

	if (regExp.test(value)) {
		checkNicknameDB(value);
	} else {
		alert("닉네임을 확인하세요.");
	}

};

var checkNicknameDB = function(name) {
	$.ajax({
		type: "POST",
		url: context + "/checkName.do",
		data: {"name" : name },
		success: function(data) {
			if(eval(data) == 0) {
				alert("사용 가능한 닉네임 입니다.");
				nickc = true;
			} else {
				alert("이미 사용 중인 닉네임입니다. 다른 닉네임을 입력하세요.");
				nickc = false;
			}
		},
		error: function() {
			alert("통신오류 다시 시도하세요");
		}
	});
};


var editForm = document.getElementById("editForm");
editForm.onsubmit = function() {
	if (!qCheck()) {
		return false;
	} else if (!emailCheck()) {
		alert("이메일을 확인하세요");
		return false;
	} else if (!phoneCheck()) {
		alert("전화번호를 확인하세요");
		return false;
	} else if (!nickc) {
		alert("닉네임을 확인하세요");
		return false;
	} else {
		return true;
	}
};

document.getElementById("updatePw").onclick = function() {
	window.open('updatePwForm.do', 'updatePwForm', 'width=500, height=250');
};