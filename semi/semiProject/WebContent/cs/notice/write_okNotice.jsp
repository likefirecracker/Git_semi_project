<%@page import="cs.NoticeDBBean"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean class="cs.NoticeBean" id="notice"></jsp:useBean>
<jsp:setProperty property="*" name="notice"/>
<script type="text/javascript">
<% 
	if(request.getParameter("n_user_id")==null){
		response.sendRedirect("listNotice.jsp");
	}else{
		InetAddress address = InetAddress.getLocalHost();
		String ip = address.getHostAddress();
		int re;
		
		notice.setN_date(new Timestamp(System.currentTimeMillis()));
		notice.setN_ip(ip);
		NoticeDBBean noticeDB = NoticeDBBean.getInstance();
		
		notice.setUser_id(request.getParameter("n_user_id"));
		notice.setN_pwd(request.getParameter("n_pwd"));
		notice.setN_title(request.getParameter("n_title"));
		notice.setN_content(request.getParameter("n_content"));
			
		re = noticeDB.insertNotice(notice);
		
		if(re == 1){
		%>
			alert("성공적으로 게시글이 올라갔습니다.");
			document.location.href="listNotice.jsp";
		<%
		} else{
		%>
			alert("게시글을 올리는데 실패하셨습니다.");
			document.location.href="writeNotice.jsp";
		<%
		}	
	}
	
	
	
	
%>
</script>
