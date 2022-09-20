<%@page import="cs.NoticeDBBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<jsp:useBean class="cs.NoticeBean" id="notice"></jsp:useBean>
<%
	int n_num=0;
	if(request.getParameter("n_num") == null){
		response.sendRedirect("listNotice.jsp");
	} else{
		NoticeDBBean noticeDBBean = NoticeDBBean.getInstance();
		n_num = Integer.parseInt(request.getParameter("n_num"));
		notice = noticeDBBean.getNotice(n_num,false);				
	}
	String pageNum=request.getParameter("pageNum");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<script src="notice.js"></script>
<body>
	<div style="text-align: center;">
		<h1>글 수정하기</h1>
		<form method="post" action="edit_okNotice.jsp?n_num=<%= n_num %>&pageNum=<%= pageNum %>" name="wrt_frm">
			<table>
				<tr height="30">
					<td width="80">작성자</td>
					<td width="140">
						<input type="text" name="user_id" size="15" maxlength="20"  value="<%= notice.getUser_id()%>" readonly>
					</td>
				</tr>
				<tr height="30">
					<td width="80">글제목</td>
					<td colspan="3" width="460">
						<input type="text" name="n_title" size="64"  value="<%= notice.getN_title()%>">
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<textarea rows="10" cols="65" name="n_content"><%= notice.getN_content()%></textarea>
					</td>
				</tr>
				<tr>
					<td>
						암&nbsp;&nbsp;호
					</td>
					<td height="50">
						<input type="password" name="n_pwd">
					</td>	
				</tr>
				<tr>
					<td height="50" colspan="4" align="center">
						<input type="button" value="글수정" onclick="onclick_ok()">&nbsp;
						<input type="reset" value="다시작성">
						<input type="button" value="글목록" onclick="location.href='showNotice.jsp?pageNum=<%= pageNum %>'">
					</td>	
				</tr>
			</table>
		</form>
	</div>
</body>
</html>