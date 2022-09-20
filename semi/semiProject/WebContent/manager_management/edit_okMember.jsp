<%@page import="login.MemberDBBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="login.MemberBean" id="member"></jsp:useBean>
<jsp:setProperty property="*" name="member"/>
<%
	request.setCharacterEncoding("utf-8");
	response.encodeRedirectURL("utf-8");
	String phone="",phone1="",phone2="",phone3="",addr="",user_pcode="", user_raddr="", user_jibun="", user_detailaddr="";

	if(request.getParameter("user_id")!=null){
		phone1 = request.getParameter("user_phone1");
		phone2 = request.getParameter("user_phone2");
		phone3 = request.getParameter("user_phone3");
		
		phone = phone1+"-"+phone2+"-"+phone3;
		
		user_pcode=request.getParameter("user_pcode");
		user_raddr=request.getParameter("user_raddr");
		user_jibun=request.getParameter("user_jibun");
		user_detailaddr=request.getParameter("user_detailaddr");
		
		addr = user_pcode + " " + user_raddr + " " + user_jibun + " " +user_detailaddr;
		
		member.setUser_addr(addr);
		member.setUser_phone(phone);
		member.setUser_regdate(new Timestamp(System.currentTimeMillis()));
		
		MemberDBBean db = MemberDBBean.getInstance();
		db.editMember(member);
		
		response.sendRedirect("listMember.jsp");
	} else{
		response.sendRedirect("listMember.jsp");
	}
%>