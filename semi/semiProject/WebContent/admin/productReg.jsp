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
		<h1>상품 등록</h1>
		<form action="productReg_ok.jsp" method="post" name="reg_frm">
		<table border="1">
			<tr>
                <td>카테고리</td>
                <td>
                    <select name="p_category" id="category">
                        <option value="nonSelect">카테고리를 선택해 주세요.</option>
                        <option value="아우터">아우터</option>
                        <option value="상의">상의</option>
                        <option value="바지">바지</option>
                        <option value="신발">신발</option>
                        <option value="악세서리">악세서리</option>
                        <option value="기타">기타</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>상품명</td>
                <td>
                    <input type="text" name="p_name" />
                </td>
            </tr>
            <tr>
                <td>가격</td>
                <td>
                    <input type="number" name="p_price" />
                </td>
            </tr>
            <tr>
                <td>수량</td>
                <td>
					<input type="number" name="p_stock" />
                </td>
            </tr>
            <tr>
                <td>상세 설명</td>
                <td>
                    <textarea name="p_desc" cols="30" rows="10" placeholder="내용을 입력해주세요."></textarea>
                </td>
                <!-- 쇼핑몰처럼 이미지로 상세 페이지 꾸밀 수 있게도 필요  -->
            </tr>
            <tr>
                <td>대표 이미지</td>
                <td>
                   <input type="file" name="p_fname" id="productImg" onchange="checkFile(this);"/>
                   <div id="showFiles">( 업로드한 파일이 없습니다. )</div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="button" value="취소" onclick="location.href=admin_main.jsp" />
                    <input type="reset" value="다시작성" />
                    <input type="button" value="등록" onclick="check_ok();" />
                </td>
            </tr>
		</table>
		</form>
	</center>
</body>
</html>