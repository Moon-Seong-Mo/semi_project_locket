<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저 검색</title>
<style>
	#userList {
		width: 100%;
	}
	#userList tr:hover {
		background-color: lightgray;
		cursor: pointer;
	}
	body{
		background: #fffcf5;
	}
	input{
		background: #fffcf5;
	}
	#nickname{
		width: 250px;
		height:20px;
	}
</style>
</head>
<body align="center">
	<h1>유저 검색</h1>
		<input type ='text' id="nickname" placeholder='닉네임을 입력하세요.'>
		<input type ="button" id="searchUser" size = '20' height="3" value="찾기">
		<br>
		<hr>
		
		<table id="userList">
		</table>
<script src="<%= request.getContextPath() %>/resources/js/jquery-3.5.1.min.js"></script>	
<script>
	$('#searchUser').click(function() {
		var searchName = $('#nickname').val();
		if(searchName == "") {
			alert('검색할 닉네임을 입력하세요.');
			return;
		}
		
		$.ajax({
			url: 'searchUser.do',
			type: "POST",
			data: {nickname:searchName},
			success: function(data) {
				var table = $('#userList');
				
				table.children().remove();
				
				$.each(data, function(index, value) {
					var $tr = $('<tr>');
					$tr.attr('name', 'user');
					$tr.attr('onclick', 'trClick(this)');
					var $td1 = $('<td>');
					$td1.text(value.id);
					$td1.attr('name', 'userId');
					var $td2 = $('<td>');
					$td2.text(value.nickName);
					$td2.attr('name', 'userName');
					
					$tr.append($td1);
					$tr.append($td2);
					
					table.append($tr);
				});
			}
		});
	});
	
	function trClick(tr) {
		var id = $(tr).children().first().text();
		var nickname = $(tr).children().last().text();
		opener.document.getElementById('id').value = id;
		opener.document.getElementById('nickname').value = nickname;
		self.close();
	}
	
	$('#userList').children().click(function() {
		var nickname = $(this).eq(1).text();
		console.log(nickname);
		
	});
</script>
</body>
</html>