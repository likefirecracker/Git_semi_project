<%@page import="cs.NoticeBean"%>
<%@page import="cs.NoticeDBBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	int  n_num = 0;
	String n_user_id;
	String n_title="";
	NoticeDBBean noticeDB = NoticeDBBean.getInstance();
	NoticeBean notice;
	if(request.getParameter("n_num")!=null){
		n_num = Integer.parseInt(request.getParameter("n_num"));
		notice=noticeDB.getNotice(n_num, false);
	} else{
		notice = null;
	}
	
	if(request.getParameter("n_user_id")!=null){
		n_user_id=request.getParameter("n_user_id");
	} else{
		n_user_id="";
		response.sendRedirect("listNotice.jsp");
	}
	
	
	if(notice != null){
		n_title = notice.getN_title();
	}
	String pageNum=null;
	if(request.getParameter("pageNum")==null){
		pageNum="1";
	}else{
		pageNum=request.getParameter("pageNum");		
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script type="text/javascript" src="notice.js"></script>
</head>
<body>
	<div style="text-align: center;">
		<h1>글 올 리 기</h1>
		<form method="post" action="write_okNotice.jsp" name="wrt_frm">
			<input type="hidden" name="n_num" value="<%= n_num %>">
			<table>
				<tr height="30">
					<td width="80">글제목</td>
					<td colspan="3" width="460">
						<%
							if(n_num==0){
						%>
								<input type="text" name="n_title" size="64">
						<%
							} else{
						%>
								<input type="text" name="n_title" size="64" value="[답변]:<%= n_title %>" readonly>								
						<%
							}
						%>
					</td>
				</tr>
				<tr height="30">
					<td width="80">이  름</td>
					<td colspan="3" width="460">
						<input type="text" name="n_user_id" size="64" value="<%=n_user_id%>" readonly>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<textarea rows="10" cols="65" name="n_content"></textarea>
					</td>
				</tr>
				<tr>
					<td width="80">암 호</td>
					<td width="140">
						<input type="password" name="n_pwd" size="12" maxlength="12">
					</td>
				</tr>
				<tr>
					<td height="50" colspan="4" align="center">
						<input type="button" value="글쓰기" onclick="onclick_ok()">&nbsp;
						<input type="reset" value="다시작성">
						<input type="button" value="글목록" onclick="location.href='listNotice.jsp?&pageNum=<%=pageNum%>'">
					</td>	
				</tr>
			</table>
		</form>
	</div>
</body>
</html>