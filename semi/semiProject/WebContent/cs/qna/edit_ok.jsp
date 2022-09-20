<%@page import="cs.QnABoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="cs.QnABoardBean" id="qbb"></jsp:useBean>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	String content = request.getParameter("b_content");
	content = content.replace("\r\n", "<br>");
	qbb.setB_id(Integer.parseInt(request.getParameter("b_id")));
	qbb.setB_category(request.getParameter("b_category"));
	qbb.setB_title(request.getParameter("b_title"));
	qbb.setB_content(content);	
	qbb.setB_pwd(request.getParameter("b_pwd"));
	String pageNum = request.getParameter("pageNum");
	QnABoardDBBean qdb = QnABoardDBBean.getInstance();
	int re = qdb.editBoard(qbb);
	
	if(re == 1){
%>
		<script>
			alert("글이 수정되었습니다.");
			location.href= "list.jsp?pageNum=<%= pageNum %>";
		</script>
<%
	}  else if(re == 0) {
%>
		<script>
			alert("비밀번호가 틀렸습니다.")
			history.go(-1);
		</script>
<%
	}else if(re == -1) {
%>
		<script>
			alert("수정에 실패했습니다.")
			history.go(-1);
		</script>
<%
	}
%>