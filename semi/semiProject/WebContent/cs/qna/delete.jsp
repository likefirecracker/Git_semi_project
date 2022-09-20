<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="../js/board.js" charset="UTF-8"></script>
</head>
<body>
<%
	int b_id = Integer.parseInt(request.getParameter("b_id"));
	String pageNum = request.getParameter("pageNum");
%>
	<center>
		<h1>글 삭 제 하 기</h1>
		<form method="post" action="delete_ok.jsp?b_id=<%= b_id %>&pageNum=<%= pageNum %>" name="del_frm">
		<table>
			<tr height="50">
				<td colspan="2" align="left">
					<h2>>> 암호를 입력하세요.<<</h2>
				</td>
			</tr>
			<tr height="50">
				<td width="80">암&nbsp;&nbsp;호</td>
				<td><input type="password" name="b_pwd" size="12" maxlength="12" /></td>
			</tr>
			<tr height="50">
				<td colspan="2" align="center">
					<input type="button" value="글삭제" onclick="delete_ok()" />&nbsp;&nbsp;&nbsp;
					<input type="reset" value="다시작성" />&nbsp;&nbsp;&nbsp;
					<input type="button" value="글목록" onclick="location.href='list.jsp?pageNum=<%= pageNum %>'" />
				</td>
			</tr>
		</table>
		</form>
	</center>
</body>
</html>