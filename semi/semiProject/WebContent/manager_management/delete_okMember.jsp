<%@page import="login.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="login.MemberBean" id="member"></jsp:useBean>
<%
	String user_id="";
	String pageNum="";
	
	if(request.getParameter("user_id")==null){
		response.sendRedirect("listMember.jsp");
	}else{
		user_id=request.getParameter("user_id");
		pageNum=request.getParameter("pageNum");
		
		MemberDBBean db = MemberDBBean.getInstance();
		db.deleteMember(user_id);
		response.sendRedirect("listMember.jsp?pageNum="+pageNum+"");
	} 
%>