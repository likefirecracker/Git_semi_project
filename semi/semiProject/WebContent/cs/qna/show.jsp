<%@page import="cs.QnABoardBean"%>
<%@page import="cs.QnABoardDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	QnABoardDBBean qdb = QnABoardDBBean.getInstance();
	QnABoardBean qbb = qdb.getBoard(Integer.parseInt(request.getParameter("b_id")),true);
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	String pageNum = request.getParameter("pageNum");
	
	if(qbb.getB_secret().equals("Y")&&!qbb.getU_id().equals(session.getAttribute("id"))){
%>
		<script>
			alert("작성자만 읽을 수 있습니다.");
			history.back();
		</script>	
<%
	}
%>
	<center>
		<h1>글 내 용 보 기</h1>
		<table border="1" cellspacing="0">
			<tr>
				<td>글번호</td>
				<td><%= qbb.getB_id() %></td>
				<td>문의유형</td>
				<td><%= qbb.getB_category() %></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><%= qbb.getU_id() %></td>
				<td>작성일</td>
				<td><%= sdf.format(qbb.getB_date()) %></td>
			<tr>
				<td>조회수</td>
				<td><%= qbb.getB_view() %></td>
				<td>파 일</td>
				<td colspan="3" style="width:120px; height:40px;">
					<%
						if(qbb.getB_fname() != null){
					%>
							<img src="../images/download.png" style="width:20px;" />
							<a href="FileDownload.jsp?fileNum=<%= qbb.getB_id() %>">(파일명 :<%= qbb.getB_rfname() %>)</a>
					<%
						}
					%>
				</td>
			</tr>
			<tr>
				<td>글제목</td>
				<td colspan="3"><%= qbb.getB_title() %></td>
			</tr>
			<tr>
				<td colspan="4"><%= qbb.getB_content() %></td>
			</tr>
			<tr>
				<td colspan="4">
					<input type="button" value="글목록" onclick="location.href='list.jsp?pageNum=<%= pageNum %>'" />
					&nbsp;&nbsp;&nbsp;&nbsp;
					<% 
						if(qbb.getU_id().equals(session.getAttribute("id"))){
					%>
					<input type="button" value="글수정" onclick="location.href='edit.jsp?b_id=<%= qbb.getB_id() %>&pageNum=<%= pageNum %>'" />
					&nbsp;&nbsp;&nbsp;&nbsp;
					<% 
						}
					%>
					<% 
						if(qbb.getU_id().equals(session.getAttribute("id"))||session.getAttribute("grade")=="관리자") {
					%>
					<input type="button" value="글삭제" onclick="location.href='delete.jsp?b_id=<%= qbb.getB_id() %>&pageNum=<%= pageNum %>'" />
					<% 
						}
					%>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<% 
						if(session.getAttribute("grade")=="admin" || session.getAttribute("id")=="admin" ) {
					%>
					<input type="button" value="답변글" onclick="location.href='reply.jsp?b_id=<%= qbb.getB_id() %>&pageNum=<%= pageNum %>'" />
					<% 
						}
					%>
				</td>
			</tr>
		</table>
	</center>
</body>
</html>