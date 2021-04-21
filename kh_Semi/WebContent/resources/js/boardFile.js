
var fnum = 0;
function changeFile(e) {
	var br = document.createElement("br");
	var input = document.createElement("input");
	input.setAttribute("name", "file" + fnum);
	input.setAttribute("type", "file");
	input.setAttribute("style", "display: inline-block; float: left;");
	input.setAttribute("onchange", "changeFile(this);");

	var delBtn = document.createElement("input");
	delBtn.setAttribute("name", "fileDel");
	delBtn.setAttribute("type", "button");
	delBtn.setAttribute("value", "삭제");
	delBtn.setAttribute("style", "display: inline-block; float: left;");
	delBtn.setAttribute("onclick", "delFile('setFile" + fnum + "');");

	var setFile = document.createElement("div");
	setFile.setAttribute("id", "setFile" + fnum++);
	setFile.setAttribute("style", "display: flex; margin-left: 90px;");
	setFile.append(input);
	setFile.append(delBtn);

	document.getElementById("fileField").append(setFile);

	e.setAttribute("onchange", null);

	var fileText = document.getElementById("filetext");
	fileText.style.height = fileText.offsetHeight + 26 + "px";
};

function delFile(id) {
	var setFile = document.getElementById(id);
	$(setFile).remove();

	var fileText = document.getElementById("filetext");
	fileText.style.height = fileText.offsetHeight - 26 + "px";

	var fileField = document.getElementById("fileField");
	if (fileField.lastChild.firstChild == null) {
		var file = document.getElementById("file");
		file.setAttribute("onchange", "changeFile(this);");
	} else {
		fileField.lastChild.firstChild.setAttribute("onchange", "changeFile(this);");
	}
};

function boardUpdate(form) {
	var title = document.getElementById("title").value.replace(/ /g,"");
	var content = document.getElementById("boardContent").value.replace(/ /g,"");
			
	if(title == "") {
		alert("제목을 입력하세요");
		return false;
	} else if(content == "") {
		alert("내용을 입력하세요");
		return false;
	}
	
	var input = document.createElement('input');
	input.setAttribute('type', 'hidden');
	input.setAttribute('name', 'exfileCount');
	input.setAttribute('value', document.getElementsByClassName('exfile').length);
	form.append(input);
	
	return true;
}
