<%@page import="cs.QnABoardBean"%>
<%@page import="cs.QnABoardDBBean"%>
<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String pageNum = request.getParameter("pageNum");
	String pwd = request.getParameter("b_pwd");
	int b_id = Integer.parseInt(request.getParameter("b_id"));
	QnABoardDBBean qdb = QnABoardDBBean.getInstance();
	QnABoardBean qbb = qdb.getBoard(b_id, false);
	String fName = qbb.getB_fname();
	String fPath = "C:/study/space_jsp/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/shop/upload";
	
	int re = qdb.deleteBoard(pwd, b_id); 
	
	if(re == 1){
		
		if(fName != null){
			File file = new File(fPath+fName); // 생성자 매개변수: 폴더 경로 + 파일 이름
			file.delete();
		}
%>
		<script>
			alert("글이 삭제되었습니다.");
			location.href= "list.jsp?pageNum=<%= pageNum %>";
		</script>
<%
	} else if(re == 0) {
%>
		<script>
			alert("비밀번호가 틀렸습니다.")
			history.go(-1);
		</script>
<%
	}else if(re == -1) {
%>
		<script>
			alert("삭제에 실패했습니다.")
			history.go(-1);
		</script>
<%
	}
%>