<%@page import="login.MemberDBBean"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="cs.NoticeDBBean"%>
<%@page import="cs.NoticeBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean class="cs.NoticeBean" id="notice"></jsp:useBean>
<jsp:useBean class="login.MemberBean" id="member"></jsp:useBean>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		String[] arraylist = {"010","02","031","051"};
		
		MemberDBBean dbBean = MemberDBBean.getInstance();
		InetAddress address = InetAddress.getLocalHost();
		String ip = address.getHostAddress();
	
		for(int i = 0;i<100;i++){
			member.setUser_id("test"+i);
			member.setUser_pwd("test");
			member.setUser_name("test"+i);
			member.setUser_phone(arraylist[(int)(Math.random()*4)]+"-0000-0000");
			member.setUser_email("test@test");
			member.setUser_regdate(new Timestamp(System.currentTimeMillis()));
			member.setUser_addr("test");
			
			//noticeDBBean.insertNotice(notice);
			dbBean.register(member);
			if(i==100){
				System.out.print("완료");
			}
		}
		
	%>
</body>
</html>