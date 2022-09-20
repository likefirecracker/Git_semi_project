<%@page import="cs.QnABoardDBBean"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean class="cs.QnABoardBean" id="qBoard"></jsp:useBean>
<%
	String path = request.getRealPath("upload");
	int size = 1024*1024*20; // 20MB로 크기 제한
	int fileSize = 0;
	String file = "";
	String oriFile = "";
	MultipartRequest multi = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());
	Enumeration files = multi.getFileNames();
	String str = (String)files.nextElement();
	file = multi.getFilesystemName(str); // 파일 이름을 가져옴 
	
	if(file != null){
		oriFile = multi.getOriginalFileName(str); // 원본 이름
		fileSize = file.getBytes().length;
	}
%>
<%
	String content = multi.getParameter("b_content");
	content = content.replace("\r\n", "<br>"); 
		
	qBoard.setU_id(session.getAttribute("id").toString());
	qBoard.setB_category(multi.getParameter("b_category"));
	qBoard.setB_title(multi.getParameter("b_title"));
	qBoard.setB_content(content);
	qBoard.setB_pwd(multi.getParameter("b_pwd"));
	if(multi.getParameter("b_secret")!=null){
		qBoard.setB_secret("Y");
	} else {
		qBoard.setB_secret("N");
	}
	qBoard.setB_date(new Timestamp(System.currentTimeMillis()));
	
	InetAddress address = InetAddress.getLocalHost();
	String ip = address.getHostAddress();
	qBoard.setB_ip(ip);
	
	if(file != null){
		qBoard.setB_fname(file);
		qBoard.setB_fsize(fileSize);
		qBoard.setB_rfname(oriFile);
	}
	
	QnABoardDBBean qdb = QnABoardDBBean.getInstance();
	int re = qdb.insertBoard(qBoard);
	
	if(re == 1){
		response.sendRedirect("list.jsp");
	}else{
		response.sendRedirect("write.jsp");
	}
%>
