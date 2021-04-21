
var idc = false;
var nickc = false;

var inputId = document.getElementById("userId");
inputId.onkeyup = function() {
	idCheck(this);
};

var idCheckBtn = document.getElementById("idCheckBtn");
idCheckBtn.onclick = function() {
	if (idCheck(userId)) {
		idCheckDB();
	} else {
		alert("아이디를 확인하세요.");
	}
};

var idCheck = function(e) {
	idc = false;
	var regExp = /^[a-z][a-z0-9]{5,19}$/g;
	var value = e.value;

	if (regExp.test(value)) {
		return true;
	} else {
		if (value.length > 6) {
			e.value = value.slice(0, value.length - 1);
		}
		return false;
	}
};

var idCheckDB = function() {
	$.ajax({
		type: "POST",
		url: context + "/checkId.do",
		data: { "id" : inputId.value },
		datatype: "text",
		success: function(data) {
			if(eval(data) == 0) {
				alert("사용 가능한 아이디입니다.");
				idc = true;
			} else {
				alert("이미 사용 중인 아이디입니다. 다른 아이디를 입력하세요.");
				idc = false;
			}

		},
		error: function() {
			alert("통신오류 다시 시도하세요");
		}
	});
};

var userPw = document.getElementById("userPw");
var userPwCheck = document.getElementById("pwCheck");


var pwCheck = function(e) {
	var regExp = /^[a-zA-Z][a-zA-Z\d!*$]{5,19}$/;
	var value = e.value;

	if (regExp.test(value)) {
		return true;
	} else {
		return false;
	}
};

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


var allCheck = document.getElementById("checkterms");
var checkbox = document.getElementsByName("terms");

allCheck.onclick = function() {
	if (allCheck.checked) {
		for (var i in checkbox) {
			checkbox[i].checked = true;
		}
	} else {
		for (var i in checkbox) {
			checkbox[i].checked = false;
		}
	}
};


for (var i in checkbox) {
	checkbox[i].onclick = function() {
		var check = true;
		for (var i = 0; i < checkbox.length; i++) {
			if (!checkbox[i].checked) {
				check = false;
			}
		}
		if (check) {
			allCheck.checked = true;
		} else {
			allCheck.checked = false;
		}
	};
}

var mCheck = function() {
	var select = document.getElementById("select");
	
	if(checkbox[0].checked) {
		if(select.checked) {
			document.getElementById("mCheck").value = "Y";
		} else {
			document.getElementById("mCheck").value = "N";
		}
		return true;
	} else {
		return false;
	}
};


var joinForm = document.getElementById("joinForm");
joinForm.onsubmit = function() {
	if (!idc) {
		alert("아이디를 확인하세요");
		return false;
	} else if (!pwCheck(userPw) || userPw.value != userPwCheck.value) {
		alert("비밀번호를 확인하세요");
		return false;
	} else if (!qCheck()) {
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
	} else if (!mCheck()) {
		alert("약관을 확인하세요");
		return false;
	} else {
		return true;
	}
	
};