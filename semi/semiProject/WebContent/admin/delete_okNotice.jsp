<%@page import="cs.NoticeDBBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<jsp:useBean class="cs.NoticeBean" id="notice"></jsp:useBean>
<%
	int n_num=0;
	String bpwd = "";
	int re = -1;
	
	if(request.getParameter("n_num")==null){
		response.sendRedirect("adminIndex.jsp?pages=listNotice");
	} else{
		n_num = Integer.parseInt(request.getParameter("n_num"));
		bpwd = request.getParameter("n_pwd");
		NoticeDBBean noticeDBBean = NoticeDBBean.getInstance();
		notice = noticeDBBean.getNotice(n_num, false);
		System.out.print(n_num);
		
		re =noticeDBBean.deleteNotice(n_num,bpwd);
		
		String pageNum=request.getParameter("pageNum");
		
		if(re==1){
			response.sendRedirect("adminIndex.jsp?pages=listNotice&pageNum="+pageNum);
		} else if(re==0){
	%>
		<script>
			alert("비밀번호가 맞지 않습니다.");
			history.go(-1);
		</script>
	<%
		} else if(re==-1){
	%>
		<script>
			alert("삭제에 실패하였습니다.");
			history.go(-1);
		</script>
	<%
		}
	}
%>