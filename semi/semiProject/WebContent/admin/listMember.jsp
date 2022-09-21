<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="login.MemberBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="login.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="login.MemberBean" id="member"></jsp:useBean>
<%
	String pageNum = request.getParameter("pageNum");//
	String s_user_id="";
	
	if(pageNum == null){
		pageNum = "1";
	}
	
	if(request.getParameter("search_user_id")!=null){
		s_user_id = request.getParameter("search_user_id");
	} 
	MemberBean.s_user_id = s_user_id;
	
	MemberDBBean memberDB = MemberDBBean.getInstance();
	ArrayList<MemberBean> memberList = memberDB.listMember(pageNum,s_user_id);
	ArrayList<Integer> n_numbers = new ArrayList<>();
	
	String user_id, user_pwd, user_name, user_phone1, user_phone2, user_phone3, user_email
		, user_pcode, user_raddr, user_jibun, user_detailaddr;
	Timestamp user_regdate;
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="script.js?a=b"></script>
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
</head>
<body>
		<div style="text-align: center;">
	<h3>User_Manager</h3>
	<form method="post" action="listMember.jsp" style="margin: 20px;">
		<input type="text" name="search_user_id">
		<input type="submit" value="user_id 검색">
	</form>
	<table class="table table-bordered table-hover mb-0" border="1" style="margin: 0 auto; width:90%; cellspacing:0;">
		<tr height="25" style="background-color: #343a40">
			<th width="40" align="center">user_id</th>
			<th width="100" align="center">user_name</th>
			<th width="180" align="center">user_phone</th>
			<th width="140" align="center">user_email</th>
			<th width="180" align="center">user_regdate</th>
			<th width="250" align="center">user_addr</th>
			<th width="140" align="center">EXIT</th>
		</tr>
<%
	for(int i=0; i<memberList.size();i++){
		member = memberList.get(i);
		
		user_id = member.getUser_id();
		user_pwd=member.getUser_pwd();
		user_name=member.getUser_name();
		user_phone1=member.getUser_phone1();
		user_phone2=member.getUser_phone2();
		user_phone3=member.getUser_phone3();
		user_email=member.getUser_email();
		user_pcode=member.getUser_pcode();
		user_raddr=member.getUser_raddr();
		user_jibun=member.getUser_jibun();
		user_detailaddr=member.getUser_detailaddr();
		user_regdate=member.getUser_regdate();
		
		%>
		<tr height="25" style="background-color: #343a40"
			onmouseover="this.style.backgroundColor='#454b51'"
			onmouseout="this.style.backgroundColor='#343a40'">
			<td  align="center"><%= user_id%></td>
			<td  align="center" style="text-align: left">
				<a href="showMember.jsp?user_id=<%= user_id %>&pageNum=<%= pageNum %>">
					<%= user_name %>
				</a>
			</td>
			<td  align="center">
				<%= user_phone1 %>-<%= user_phone2 %>-<%= user_phone3 %>
			</td>
			<td  align="center">
				<%= user_email %>
			</td>
			<td  align="center">
				<%= sdf.format(user_regdate) %>
			</td>
			<td  align="center">
				우편번호 : <%= user_pcode %> <br>
				도 로 명 : <%= user_raddr %> <br>
				지     번 : <%= user_jibun %> <br>
				상세주소 : <%= user_detailaddr %>
			</td>
			<td  align="center">
				<form method="post" action="deleteM_ok.jsp?user_id=<%=user_id%>&pageNum=<%=pageNum%>" name="del_frm">
					<input type="submit" onclick="exitCheck()" value="탈퇴" name="send">
				</form>
			</td>
		</tr>
		<%
	}
	memberList.clear();
%>
	</table>
	<%= MemberBean.pageNumber(5) %>
	</div>
</body>
</html>