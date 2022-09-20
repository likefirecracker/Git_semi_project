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
		String id = "admin";
		String grade = "admin";
		session.setAttribute("id", id); 
		session.setAttribute("grade", grade); 
		String b_title="";
		/* if(session.getAttribute(id) == null){
			response.sendRedirect("login.jsp");
		} */
	%>
	<h1>문의 작성</h1>
    <hr>
    <form action="write_ok.jsp" method="post" name="write_frm" enctype="multipart/form-data">
    	<table>
            <tr>
                <td>문의유형</td>
                <td>
                    <select name="b_category" id="category">
                        <option value="nonSelect">문의 유형을 선택해 주세요.</option>
                        <option value="회원정보">회원정보</option>
                        <option value="상품문의">상품문의</option>
                        <option value="주문/결제">주문/결제</option>
                        <option value="배송">배송</option>
                        <option value="교환/취소">교환/취소</option>
                        <option value="서비스">서비스</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>작성자</td>
                <td>
                    <input type="text" name="name" readonly />
                </td>
            </tr>
            <tr>
                <td>휴대전화</td>
                <td>
                    <input type="text" name="phone" readonly />
                </td>
            </tr>
            <tr>
                <td>이메일</td>
                <td>
                    <input type="text" name="email" readonly />
                </td>
            </tr>
            <tr>
                <td>제목</td>
                <td>
					<input type="text" name="b_title" placeholder="제목을 입력해주세요." />
                </td>
            </tr>
            <tr>
                <td>문의내용</td>
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
                <td>
                    <input type="button" value="취소" onclick="location.href=list.jsp" />
                    <input type="reset" value="다시작성" />
                    <input type="button" value="작성하기" onclick="check_ok()" />
                </td>
            </tr>
        </form>
    </table>
</body>
</html>