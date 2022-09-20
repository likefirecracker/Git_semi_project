<%@page import="java.util.ArrayList"%>
<%@page import="cs.NoticeDBBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<jsp:useBean class="cs.NoticeBean" id="notice"></jsp:useBean>
<%
	String pageNum=request.getParameter("pageNum");
	int n_num = 0,n_hit=0,n_before=0,n_after=0;
	String n_date="", user_id="", n_title="", n_content="";
	NoticeDBBean noticeDBBean = NoticeDBBean.getInstance();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	if(request.getParameter("n_num")==null){
		response.sendRedirect("listNotice.jsp");
	} else {
		n_num = Integer.parseInt(request.getParameter("n_num"));
		notice = noticeDBBean.getNotice(n_num, true);
		n_date = sdf.format(notice.getN_date());
		user_id=notice.getUser_id();
		n_hit=notice.getN_hit();
		n_title=notice.getN_title();
		n_content = notice.getN_content();
		n_before = notice.getBefore();
		n_after = notice.getAfter();
	}
	String n_title2="";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<body>
	<div style="margin: 0 auto; text-align: center;">
	<h3>글 내 용 보 기</h3>
	<table width="600" border="1" cellspacing="0" style="margin: 0 auto;">
		<tr>
			<th width="100" colspan="1">글번호</th>
			<td width="200" align="center" colspan="1"><%= n_num %></td>
			<th width="100" colspan="1">조회수</th>
			<td width="200" align="center" colspan="1"><%= n_hit %></td>
		</tr>
		<tr>
			<th colspan="1">작성자</th>
			<td align="center" colspan="1"><%= user_id %></td>
			<th colspan="1" width="100">작성일</th>
			<td align="center" colspan="1"><%= n_date %></td>
		</tr>
		<tr>
			<th colspan="1">글제목</th>
			<td colspan="3" align="left"><%= n_title %></td>
		</tr>
		<tr height="500">
			<th colspan="1">글내용</th>
			<td colspan="3"><%= n_content %></td>
		</tr>
		<tr>
			<td colspan="4" align="right">
	<%	
			if(session.getAttribute("n_user_id") != null){
				if(!session.getAttribute("n_user_id").equals("")){
	%> 
					<input type="button" value="글수정" onclick="location.href='editNotice.jsp?n_num=<%= n_num %>&pageNum=<%=pageNum%>'">&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value="글삭제" onclick="location.href='deleteNotice.jsp?n_num=<%= n_num %>&pageNum=<%=pageNum%>'">&nbsp;&nbsp;&nbsp;&nbsp;
	<%
				}
			}
	%>
				<input type="button" value="글목록" onclick="location.href='listNotice.jsp?pageNum=<%=pageNum%>'">
			</td>
		</tr>
	</table>
	<%
		if(n_num+1 >0 ){
			notice = noticeDBBean.getNotice(n_after, false);
			n_title2 = notice.getN_title();
			if(n_title2 != null){
	%>
				<div >
					<a href="showNotice.jsp?n_num=<%= n_after %>&pageNum=<%= pageNum %>" id="upPage">
						위 페이지&nbsp;PREV&nbsp;&nbsp;&nbsp;&nbsp;<%= n_title2 %>
					</a>
				</div>
	<%
			}		
		}
	%>
	<%
		if(n_num-1 >0 ){
			notice = noticeDBBean.getNotice(n_before, false);
			n_title2 = notice.getN_title();
	%>
			<div >
				<a href="showNotice.jsp?n_num=<%= n_before %>&pageNum=<%= notice.getBefore() %>" id="upPage">
					아래 페이지&nbsp;PREV&nbsp;&nbsp;&nbsp;&nbsp;<%= n_title2 %>
				</a>
			</div>
	<%
		}
	%>
	</div>
</body>
</html>







