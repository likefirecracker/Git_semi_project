<%@page import="java.net.InetAddress"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="cs.NoticeDBBean"%>
<%@page import="cs.NoticeBean"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:useBean class="cs.NoticeBean" id="notice"></jsp:useBean>

<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
		NoticeDBBean noticeDBBean = NoticeDBBean.getInstance();
		InetAddress address = InetAddress.getLocalHost();
		String ip = address.getHostAddress();	
	
		for(int i = 0;i<100;i++){
			notice.setN_content("test");
			notice.setN_title("test"+i);
			notice.setN_date(new Timestamp(System.currentTimeMillis()));
			notice.setN_hit(0);
			notice.setN_ip(ip);
			notice.setN_pwd("1234");
			notice.setUser_id("test");
			notice.setN_num(i);
			
			noticeDBBean.insertNotice(notice);
			
			if(i==70){
				System.out.print(i);
			}
		}
		
	%>
</body>
</html>