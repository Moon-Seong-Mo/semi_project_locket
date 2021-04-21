<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String context = request.getContextPath();
%>
<script>
	var context = "<%= context %>";
</script>
<script src="<%= context %>/resources/js/jquery-3.5.1.min.js"></script>
<link rel = "icon" href = "<%= context %>/favicon.ico">