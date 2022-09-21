<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<center>
		<h1>회원 관리</h1>
		<form action="userEdit.jsp?userId=" method="post">
		<table border="1">
			<tr>
				<td>ID</td>
				<td>이름</td>
				<td>전화번호</td>
				<td>이메일</td>
				<td>주문 수량</td>
				<td>수정</td>
			</tr>
			<tr>
				<td>user1</td>
				<td>홍길동</td>
				<td>010-0000-0000</td>
				<td>abc@abc.kr</td>
				<td>3</td>
				<td>
					<input type="radio" value="수정" />
				</td>
			</tr>
		</table>	
		<input type="submit" value="회원 정보 수정">
		</form>
	</center>
</body>
</html>