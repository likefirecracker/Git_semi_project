<%@page import="cs.QnABoardBean"%>
<%@page import="cs.QnABoardDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="../js/board.js" charset="UTF-8"></script>
</head>
<body>
	<% 
		int b_id = 0,b_ref = 1,b_level = 0,b_step = 0;
		String b_title="";
		/* if(session.getAttribute(id) == null){
			response.sendRedirect("login.jsp");
		} */
		b_id = Integer.parseInt(request.getParameter("b_id"));
		QnABoardDBBean qdb = QnABoardDBBean.getInstance();
		QnABoardBean qbb = qdb.getBoard(b_id,false);
		if(qbb != null) {
			b_ref = qbb.getB_ref();
			b_step = qbb.getB_step();
			b_level = qbb.getB_level();
			b_title = qbb.getB_title();
		}
		String pageNum = request.getParameter("pageNum");
	%>
	<h1>문의 답변</h1>
    <hr>
    <form action="reply_ok.jsp?b_id=<%= b_id %>&pageNum=<%= pageNum %>" method="post" name="write_frm" enctype="multipart/form-data">
    	<table>
            <tr>
                <td>문의유형</td>
                <td>
                    <input type="text" name="b_category" value="<%= qbb.getB_category() %>" readonly>
                </td>
            </tr>
            <tr>
                <td>작성자</td>
                <td>
                    <input type="text" name="name" readonly />
                </td>
            </tr>
            <tr>
                <td>제목</td>
                <td>
					<input type="text" name="b_title" value="[답변]<%= b_title %>" />
                </td>
            </tr>
            <tr>
                <td>답변내용</td>
                <td>
                    <textarea name="b_content" cols="30" rows="10" placeholder="내용을 입력해주세요."></textarea>
                </td>
            </tr>
            <tr>
                <td>사진</td>
                <td>
                   <label for="qnaImg" style="width: 50px; height: 50px; display: inline-block;" >
                       <img src="../images/upload.png" alt="upload" style="pointer-events: none; width: 100%;">
                   </label>
                   <input type="file" name="b_fname" id="qnaImg" style="display: none;"/>
                </td>
            </tr>
            <tr>
                <td>비밀번호</td>
                <td>
                	<input type="password" name="b_pwd" />
                </td>
                <td>비밀글</td>
                <td>
                	<input type="checkbox" name="b_secret" />
                </td>
            </tr>
            <tr>
                <td><input type="hidden" name="b_ref" value="<%= b_ref %>"></td>
                <td><input type="hidden" name="b_step" value="<%= b_step %>"></td>
                <td><input type="hidden" name="b_level" value="<%= b_level %>"></td>
            </tr>
            <tr>
                <td>
                    <input type="button" value="취소" onclick="location.href='list.jsp?pageNum=<%= pageNum %>'" />
                    <input type="reset" value="다시작성" />
                    <input type="button" value="작성하기" onclick="check_ok()" />
                </td>
            </tr>
        </form>
    </table>
</body>
</html>