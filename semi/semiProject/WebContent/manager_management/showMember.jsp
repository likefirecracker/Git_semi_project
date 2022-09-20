<%@page import="login.MemberDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean class="login.MemberBean" id="member"></jsp:useBean>
<%
	String user_id="";
	String[] phone= new String[2];
	String phone1="", phone2="", phone3="";
	MemberDBBean db = MemberDBBean.getInstance();
	if(request.getParameter("user_id")==null){
		response.sendRedirect("listMember.jsp");
	} else{
		user_id = request.getParameter("user_id");
		member = db.getMember(user_id);
		
		phone = member.getUser_phone().split("-");
		phone1=phone[0];
		phone2=phone[1];
		phone3=phone[2];
	}
	String[] arraylist = {"010","02","031","051"};
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="jquery.min.js"></script>
<script type="text/javascript" src="script.js" charset="utf-8"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
	
    $(function(){
	    $('#searchName').val("<%=phone1%>").prop("selected",true);
    });

</script>
<body>
	<form name="reg_frm" action="edit_okMember.jsp" method="post">
		<table border="1" >
			<tr>
				<td colspan="2" align="center">
				<h1 style= text-align:center>Green</h1>
				</td>
			</tr>
			<tr>
				<td width="80">UserID</td>
				<td><input type="text" name="user_id" size ="20" readOnly value="<%= user_id %>"></td>
			</tr>
			<tr>
				<td width="80">비밀번호</td>
				<td><input type="password" name="user_pwd" size ="20">*</td>
			</tr>
			<tr>
				<td width="80">암호 확인</td>
				<td><input type="password" name="user_pwdch" size ="20">*</td>
			</tr>
			<tr>
				<td width="80">이 름</td>
				<td><input type="text" name="user_name" size ="20" value="<%=member.getUser_name()%>">*</td>
			</tr>
			
			<tr>
				<td width="80">전화 번호</td>
				<td>
					<select name = "user_phone1" id="searchName">
						<option value = "010">010</option>
						<option value = "02">02</option>
						<option value = "031">031</option>
						<option value = "051">051</option>
					</select>
					<input type="text" name="user_phone2" size ="10" maxlength="4" value="<%= phone2 %>">
					<input type="text" name="user_phone3" size ="10" maxlength="4" value="<%= phone3 %>">
				</td>
			</tr>
			
			<tr>
				<td width="80">E-mail</td>
				<td><input type="text" name="user_email" size ="30" value="<%= member.getUser_email() %>">*</td>
			</tr>
			<tr>
				<td>주소</td>
				<td>
					<input type="text" name="user_pcode" id="sample4_postcode" placeholder="우편번호" >
					<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기"><br>
					<input type="text" name="user_raddr" id="sample4_roadAddress" placeholder="도로명주소" size="60" ><br>
					<input type="hidden" name="user_jibun" id="sample4_jibunAddress" placeholder="지번주소"  size="60">
					<span id="guide" style="color:#999;display:none"></span>
					<input type="text" name="user_detailaddr" id="sample4_detailAddress" placeholder="상세주소"  size="60"><br>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
				<input type="button" value="수정완료" onclick="check_ok()">
				<input type="reset" value="다시입력">
				&nbsp;&nbsp;&nbsp;
				<input type="button" value="수정안함" 
                 onclick="location.href='listMember.jsp'">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>