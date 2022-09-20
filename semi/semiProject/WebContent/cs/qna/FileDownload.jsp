<%@page import="cs.QnABoardBean"%>
<%@page import="cs.QnABoardDBBean"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int bid = Integer.parseInt(request.getParameter("fileNum"));
	QnABoardDBBean qdb = QnABoardDBBean.getInstance();
	QnABoardBean qbb = qdb.getFileName(bid);
	
	String fName = "";
	String rfName = "";
	if(qbb != null) {
		fName = qbb.getB_fname();
		rfName = qbb.getB_rfname();
	}
	
	String saveDirectory = application.getRealPath("/upload"); // 저장 경로
	String fPath = saveDirectory + File.separator + fName; // separator : 경로 구분자 '/' '\'
	
	File file = new File(fPath);
	long length = file.length();
	rfName = new String(rfName.getBytes("ms949"), "8859_1"); // ms949 : 한글 인코딩
	
	
	response.setContentType("application/octet-stream"); // 8비트로 된 데이터(지정되지 않은 파일 형식)
	response.setContentLength((int)length);
	response.setHeader("Content-Disposition", "attachment;filename=" + rfName); // 파일 링크를 클릭했을때 다운로드 화면이 출력되게 처리함
	
	BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));
	
	out.clear();
	out = pageContext.pushBody(); // 출력할게 남아 있으면 다 비움
	
	BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());

	int data;
	while((data = bis.read()) != -1){ // End of File
		bos.write(data);
	}
	
	bis.close();
	bos.close();
%>
