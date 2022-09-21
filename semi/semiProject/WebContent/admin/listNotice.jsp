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
<meta charset="UTF-8">
<title>Insert title here</title>
    <!-- Simple bar CSS -->
    <link rel="stylesheet" href="css/simplebar.css">
    <!-- Fonts CSS -->
    <link href="https://fonts.googleapis.com/css2?family=Overpass:ital,wght@0,100;0,200;0,300;0,400;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    <!-- Icons CSS -->
    <link rel="stylesheet" href="css/feather.css">
    <link rel="stylesheet" href="css/dataTables.bootstrap4.css">
    <!-- Date Range Picker CSS -->
    <link rel="stylesheet" href="css/daterangepicker.css">
    <!-- App CSS -->
    <link rel="stylesheet" href="css/app-dark.css?" id="darkTheme">
    <link rel="stylesheet" href="css/app-light.css?a=b" id="lightTheme" disabled>
</head>
<body>
	<div style="text-align: center;">
	<h3>공지사항</h3>
	<table class="table table-bordered table-hover mb-0" style="margin: 0 auto; width: 90%">
	    <thead>
	      <tr style="background-color: #343a40">
	        <th style="text-align: center;">번호</th>
	        <th style="text-align: center;">글제목</th>
	        <th style="text-align: center;">작성자</th>
	        <th style="text-align: center;">작성일</th>
	        <th style="text-align: center;">조회수</th>
	      </tr>
	    </thead>
	    <tbody>
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
		<tr style="background-color: #343a40">
			<td  align="center"><%= n_num%></td>
			<td  align="center" style="text-align: left">
				<a href="adminIndex.jsp?pages=showNotice&n_num=<%= n_num %>&pageNum=<%= pageNum %>">
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
<%
	if(session.getAttribute("n_user_id")!=null){
%>
			<!-- 	    
			<td><span class="badge badge-pill badge-warning">Hold</span></td>
	        <td><span class="badge badge-pill badge-danger">Danger</span></td>
	        <td><span class="badge badge-pill badge-success">Success</span></td>
	         -->
	      
	    </tbody>
	</table>
		<div style="text-align: right; margin: 20px 5% 0px 5%">
			<input type="button" value="글쓰기" 
						onclick="location.href='writeNotice.jsp?pageNum=<%= pageNum %>&n_user_id=<%= n_user_id %>'">		
		</div>
<%
		}
%>
	<%= NoticeBean.pageNumber(5) %>
	</div>
</body>
</html>