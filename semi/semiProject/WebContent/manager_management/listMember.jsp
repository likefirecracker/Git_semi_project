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
		MemberBean.s_user_id = s_user_id;
	}
	
	MemberDBBean memberDB = MemberDBBean.getInstance();
	ArrayList<MemberBean> memberList = memberDB.listMember(pageNum,s_user_id);
	ArrayList<Integer> n_numbers = new ArrayList<>();
	
	String user_id, user_pwd, user_name, user_phone, user_email, user_addr;
	Timestamp user_regdate;
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="script.js?a=b"></script>
</head>
<body>
		<div style="text-align: center;">
	<h3>User_Manager</h3>
	<form method="post" action="listMember.jsp">
		<input type="text" name="search_user_id">
		<input type="submit" value="user_id 검색">
	</form>
	<table border="1" width="800" cellspacing="0" style="margin: 0 auto">
		<tr height="25">
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
		user_phone=member.getUser_phone();
		user_email=member.getUser_email();
		user_addr=member.getUser_addr();
		user_regdate=member.getUser_regdate();
		
		%>
		<tr height="25" bgcolor="#f7f7f7"
			onmouseover="this.style.backgroundColor='#eeeeef'"
			onmouseout="this.style.backgroundColor='#f7f7f7'">
			<td  align="center"><%= user_id%></td>
			<td  align="center" style="text-align: left">
				<a href="showMember.jsp?user_id=<%= user_id %>&pageNum=<%= pageNum %>">
					<%= user_name %>
				</a>
			</td>
			<td  align="center">
				<%= user_phone %>
			</td>
			<td  align="center">
				<%= user_email %>
			</td>
			<td  align="center">
				<%= sdf.format(user_regdate) %>
			</td>
			<td  align="center">
				<%= user_addr %>
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
	<%= MemberBean.pageNumber(4) %>
	</div>
</body>
</html>