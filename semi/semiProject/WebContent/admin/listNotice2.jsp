<%@page import="java.text.SimpleDateFormat"%>
<%@page import="cs.NoticeBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="cs.NoticeDBBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean class="cs.NoticeBean" id="notice"></jsp:useBean>
<%

	String pageNum = request.getParameter("pageNum");//

	String n_user_id = "test";
	
	session.setAttribute("n_user_id", n_user_id);

	if(pageNum == null){
		pageNum = "1";
	}
	
	NoticeDBBean noticeDB = NoticeDBBean.getInstance();
	ArrayList<NoticeBean> noticeList = noticeDB.listNotice(pageNum);
	ArrayList<Integer> n_numbers = new ArrayList<>();
	
	int n_num, n_hit;
	String n_title, user_id;
	Timestamp n_date;
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<div style="text-align: center;">
	<h3>공지사항</h3>
	<table border="1" width="800" cellspacing="0">
		<tr height="25">
			<th width="40" align="center">번호</th>
			<th width="450" align="center">글제목</th>
			<th width="120" align="center">작성자</th>
			<th width="140" align="center">작성일</th>
			<th width="140" align="center">조회수</th>
		</tr>
<%
	for(int i=0; i<noticeList.size();i++){
		notice = noticeList.get(i);
		
		n_num = notice.getN_num();
		n_title = notice.getN_title();
		user_id = notice.getUser_id();
		n_hit = notice.getN_hit();
		n_date = notice.getN_date();
		
		n_numbers.add(i, n_num);
		%>
		<tr height="25" bgcolor="#f7f7f7"
			onmouseover="this.style.backgroundColor='#eeeeef'"
			onmouseout="this.style.backgroundColor='#f7f7f7'">
			<td  align="center"><%= n_num%></td>
			<td  align="center" style="text-align: left">
				<a href="../cs/notice/showNotice.jsp?n_num=<%= n_num %>&pageNum=<%= pageNum %>">
					<%= n_title %>
				</a>
			</td>
			<td  align="center">
				<%= user_id %>
			</td>
			<td  align="center">
				<%= sdf.format(n_date) %>
			</td>
			<td  align="center">
				<%= n_hit %>
			</td>
		</tr>
		<%
	}
	noticeList.clear();
%>
	</table>
		
	<%= NoticeBean.pageNumber(4) %>
	</div>
</body>
</html>