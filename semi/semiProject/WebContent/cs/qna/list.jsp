<%@page import="cs.QnABoardBean"%>
<%@page import="cs.QnABoardDBBean"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	int b_id,b_view, b_level, b_fsize;
	String b_category, u_id, b_title, b_content, b_pwd, b_secret, b_anschk;
	Timestamp b_date;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	QnABoardDBBean qdb = QnABoardDBBean.getInstance();
	
	// 페이징 처리
	int pageSize = 10; // 한페이지에 보여질 글 수
	int count = qdb.getCount(new QnABoardBean()); // 전체 글 수
	// 현재 페이지 정보 설정
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	} 
	// 첫 행번호 계산
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage-1)*pageSize+ 1; // 2페이지면 11~20
	ArrayList<QnABoardBean> list = qdb.listBoard(startRow,pageSize);
	
	int pageCount=1, pageBlock=5, startPage=1, endPage=1; // pageBlock: 한 페이지에 보여줄 페이지 블럭
	if(count != 0) {
		pageCount = (int)Math.ceil((double)count / pageSize); // 전체 페이지 수
		startPage = ((currentPage-1)/pageBlock)*pageBlock+1; // 페이지 블럭 시작 번호
		endPage = startPage + pageBlock -1; // 페이지 블럭 끝 번호
		if(endPage > pageCount){
			endPage = pageCount;
		} // 전체 페이지가 10페이지인데 마지막 페이지가 11이면 안되므로 조건문 설정
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<center>
		<h1>Q&A</h1>
		<table>
			<tr>
				<td>글번호</td>
				<td>분류</td>
				<td>제목</td>
				<td>작성자</td>
				<td>작성일</td>
				<td>조회수</td>
				<td>첨부파일</td>
				<td>비공개</td>
			</tr>
	<%
			for(int i=0; i < list.size(); i++) {
				QnABoardBean board = list.get(i); // 배열에 넣은 역순으로 board 객체에 값을 넣어줌
				b_id=board.getB_id();
				u_id=board.getU_id();
				b_category=board.getB_category();
				b_pwd=board.getB_pwd();
				b_title= board.getB_title();
				b_date= board.getB_date();
				b_view= board.getB_view();
				b_level = board.getB_level();
				b_fsize = board.getB_fsize();
				b_secret = board.getB_secret();
	%>
			<tr height="25" bgcolor="#E8E8E8" onmouseover="this.style.backgroundColor='#AEBAB4'"
			onmouseout="this.style.backgroundColor='#E8E8E8'">
				<td align="center"><%=b_id%></td>
				<td align="center"><%=b_category%></td>
				<td id="title" style="width:150px;">
					<%
						if(b_level > 0){
							for(int j=0; j<b_level; j++){
					%>
								&nbsp;
					<%
							}
					%>
						<img src="../images/replyE.png" style="width:10px;" />
					<%
						}
					%>
					<a href="show.jsp?b_id=<%= b_id %>&pageNum=<%= pageNum %>"><%=b_title%></a>
				</td>
				<td><%= u_id %></td>
				<td><%=sdf.format(b_date)%></td>
				<td><%=b_view%></td>
				<td style="width:80px; height:40px;">
					<%
						if(b_fsize != 0) {
					%>
							<img src="../images/image.png" style="width:30px; margin-left:25px;" />
					<%
						}
					%>
				</td>
				<td style="width:80px; height:40px;">
					<%
						if(b_secret.equals("Y")) {
					%>
							<img src="../images/lock.png" style="width:30px; margin-left:25px;" />
					<%
						}
					%>
				</td>
			</tr>
		<%
			}
		%>
	<% if(session.getAttribute("id") != null){
		%>
			<tr>
				<td colspan="8"><a href="write.jsp?pageNum=<%= pageNum %>">글 쓰 기</a></td>
			</tr>
	<% 
		}
	%>
		</table>
		<div>
	<%
		if(startPage > pageBlock) {
	%>
			<a href="list.jsp?pageNum=<%= startPage-pageBlock %>">이전</a>
	<%
		}
	%>
	<%
		for(int i = startPage; i<= endPage; i++){
	%>
			<a href="list.jsp?pageNum=<%= i %>"><%= i %></a>
	<%	
		}
	%>
	<%
		if(startPage+pageBlock <= pageCount) {
	%>
			<a href="list.jsp?pageNum=<%= startPage+pageBlock %>">다음</a>
	<%
		}
	%>
</div>
	</center>
</body>
</html>