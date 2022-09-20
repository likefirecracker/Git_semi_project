<%@page import="cs.NoticeDBBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<jsp:useBean class="cs.NoticeBean" id="notice"></jsp:useBean>
<%
	int n_num = 0;
	if(request.getParameter("n_num")==null){
		response.sendRedirect("listNotice.jsp");
	} else{
		NoticeDBBean noticeDBBean = NoticeDBBean.getInstance();
		n_num = Integer.parseInt(request.getParameter("n_num"));
		noticeDBBean.getNotice(n_num,false);
		String bpwd = notice.getN_pwd();		
	}
	String pageNum=request.getParameter("pageNum");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="notice.js?a=d"></script>
</head>
<body>
	<center>
	<h3>글 삭 제 하 기</h3>
	<form method="post" action="delete_okNotice.jsp?n_num=<%= n_num %>&pageNum=<%=pageNum %>" name="del_frm">
	<table>
		<tr height="50">
			<td colspan="2" align="left">&gt;&gt; 암호를 입력하세요. &lt;&lt;</td>
		</tr>
		<tr>
			<td>암&nbsp;&nbsp;호</td>
			<td><input type="password" name="n_pwd"></td>
		</tr>
		<tr>
			<td><input type="button" value="글삭제" onclick="delete_ok()"></td>
			<td><input type="reset" value="다시작성"></td>
			<td><input type="button" value="글목록" onclick="document.location.href='listNotice.jsp?pageNum=<%= pageNum %>'"></td>
		</tr>
	</table>
	</form>
	</center>
</body>
</html>