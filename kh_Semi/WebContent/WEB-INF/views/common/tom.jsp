<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Top of this Month</title>
<link rel="stylesheet" type="text/css" href="<%= context %>/resources/css/tom.css">
</head>
<body>
	<div id="tom">
		<div>
			<b>이달의 로켓왕!</b>
		</div>
		<br>
		
		<table id="tom-table">
			<tr id="table-head">
				<th>No.</th>
				<th>Name</th>
				<th>거래 수</th>
			</tr>
		</table>
		<div id="loading">
			<img src="<%= context %>/resources/images/loading.gif"/>
		</div>
	</div>
	
</body>
<script>
	
	$.ajax({
		url: 'topOfMonth.do',
		type: 'post',
		data: {first: 1, last: 3},
		success: function(data) {	
			var table = document.getElementById("tom-table");
			for(var i in data) {
				var tr = document.createElement("tr");
				var td1 = document.createElement("td");
				td1.innerHTML = data[i].rank;
				var td2 = document.createElement("td");
				td2.innerHTML = data[i].nickname;
				var td3 = document.createElement("td");
				td3.innerHTML = data[i].count;
				
				tr.appendChild(td1);
				tr.appendChild(td2);
				tr.appendChild(td3);
				table.appendChild(tr);
				
			}
			$('#tom-table').show();
			$('#loading').hide();
			
		}
	});
	
	
</script>
</html>