<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.header {
	width: 1200px;
	height: 100px;
	margin: 0 auto;
}
#nav_left {
    width: 180px;
    height: 360px;
    border: 1px solid black;
    text-align: center;
    position: fixed;
    top: 50%;
    left: 0;
    transform: translateY(-50%)
} 
.content {
	width: 1200px;
	margin: 0 auto;
}
</style>
</head>
<body>
	<%
		String pageChange = request.getParameter("page");
		if(pageChange == null){
			pageChange = "admin_body.jsp";
		}
	%>
	<div class="header"><jsp:include page="admin_header.jsp" flush="false" /></div>
	<div class="left-nav"><jsp:include page="nav.jsp" flush="false" /></div>
	<div class="content"><jsp:include page="<%= pageChange %>" flush="false" /></div>

</body>
</html>