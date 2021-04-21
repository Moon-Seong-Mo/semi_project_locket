
function sendMessage(id, nickname) {
	window.open('', 'sendMseeage', 'width=650, height=400');
	var form = document.sendmsg;
	
	form.method = "post";
	form.target = 'sendMseeage';
	form.action = context + "/messageSendForm.do";
	
	form.submit();
}