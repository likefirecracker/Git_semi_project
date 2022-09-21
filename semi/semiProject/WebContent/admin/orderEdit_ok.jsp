<%@page import="order.OrderManageDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean class="order.OrderManageBean" id="omb"></jsp:useBean>
<jsp:setProperty property="*" name="omb"/>
<%
	String pageNum = request.getParameter("pageNum");
	OrderManageDBBean omdb = OrderManageDBBean.getInstance();
	
	int re = omdb.editOrder(omb);
	if(re == 1){
%>
		<script>
			alert("주문이 수정되었습니다.");
			location.href= "admin_main.jsp?page=orderList.jsp&pageNum=<%= pageNum %>";
		</script>
<%
	} else {
%>
		<script>
			alert("수정에 실패했습니다.")
			history.go(-1);
		</script>
<%
	}
%>