<%@page import="cs.QnABoardBean"%>
<%@page import="cs.QnABoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	QnABoardDBBean qdb = QnABoardDBBean.getInstance();
	QnABoardBean qbb = qdb.getBoard(Integer.parseInt(request.getParameter("b_id")),false);
	String content = qbb.getB_content();
	content = content.replace("<br>","\r\n");
	String pageNum = request.getParameter("pageNum");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="../js/board.js" charset="UTF-8"></script>
</head>
<body>
	<center>
		<h1>글 수 정 하 기</h1>
		<form method="post" action="edit_ok.jsp?b_id=<%= qbb.getB_id() %>" name="write_frm">
			<table>
				<tr height="30">
					<td width="80">작성자</td>
					<td width="140">
						<input type="text" size="10" readonly value="<%= qbb.getU_id() %>"/>
					</td>
					<td width="80">문의유형</td>
					<th>
                    <select name="b_category" id="category">
                        <option value="nonSelect">문의 유형을 선택해 주세요.</option>
                        <option value="회원정보">회원정보</option>
                        <option value="상품문의">상품문의</option>
                        <option value="주문/결제">주문/결제</option>
                        <option value="배송">배송</option>
                        <option value="교환/취소">교환/취소</option>
                        <option value="서비스">서비스</option>
                    </select>
                </th>
				</tr>
				<tr height="30">
					<td width="80">글제목</td>
					<td colspan="3">
						<input type="text" name="b_title" size="58" value="<%= qbb.getB_title() %>" />
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<textarea cols="70" rows="10" name="b_content" maxlength="3000"><%= content %></textarea>
					</td>
				<tr>
				<tr height="30">
					<td>
						<td width="80" align="left">암호</td>
						<td width="140" colspan="3" align="left">
							<input type="password" name="b_pwd" size="12" maxlength="12"/>
					</td>
				</tr>
				<tr height="50">
					<td colspan="4" align="center">
						<input type="button" value="글수정" onclick="check_ok()" />
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="reset" value="다시작성" />
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" value="글목록" onclick="location.href='list.jsp?pageNum=<%= pageNum %>'" />
					</td>
				</tr>
			</table>		
		</form>
	</center>
</body>
</html>