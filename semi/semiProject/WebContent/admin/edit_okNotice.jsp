<%@page import="cs.NoticeDBBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean class="cs.NoticeBean" id="notice"></jsp:useBean>
<jsp:setProperty property="*" name="notice"/>
<%
	String pageNum=request.getParameter("pageNum");
	int re=-1;
	if(request.getParameter("n_num")==null){
		response.sendRedirect("adminIndex.jsp");
	} else{
		int n_num = Integer.parseInt(request.getParameter("n_num"));
		notice.setN_num(n_num);
		NoticeDBBean noticeDBBean = NoticeDBBean.getInstance();
		re=noticeDBBean.editNotice(notice);
		if(re==1){
			response.sendRedirect("adminIndex.jsp?pages=showNotice&n_num="+n_num+"&pageNum="+pageNum);
		} else if(re==0){
			%>
			<script type="text/javascript">
				alert("비밀번호가 일치하지 않습니다.");
				history.go(-1);
			</script>
			<%
		} else if(re==-1){
			%>
			<script type="text/javascript">
				alert("글 수정을 실패했습니다.");
				history.go(-1);
			</script>
			<%
		}
	}
%>