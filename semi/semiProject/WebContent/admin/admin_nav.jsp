<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<ul class="navbar-nav flex-fill w-100 mb-2">
            <li class="nav-item dropdown">
              <a href="#ui-elements" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle nav-link">
                <i class="fe fe-box fe-16"></i>
                <span class="ml-3 item-text">상품 관리</span>
              </a>
              <ul class="collapse list-unstyled pl-4 w-100" id="ui-elements">
                <li class="nav-item">
                  <a class="nav-link pl-3" href="adminIndex.jsp?pages=productReg"><span class="ml-1 item-text">상품 정보 등록</span>
                  </a>
                </li>
                <li class="nav-item">
                  <a class="nav-link pl-3" href="adminIndex.jsp?pages=productList"><span class="ml-1 item-text">상품 정보 조회</span></a>
                </li>
              </ul>
            </li>
            <li class="nav-item dropdown">
              <a href="#contact" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle nav-link">
                <i class="fe fe-book fe-16"></i>
                <span class="ml-3 item-text">주문 관리</span>
              </a>
              <ul class="collapse list-unstyled pl-4 w-100" id="contact">
                <a class="nav-link pl-3" href="adminIndex.jsp?pages=orderList"><span class="ml-1">주문 관리</span></a>
                <a class="nav-link pl-3" href="adminIndex.jsp?pages=refundList"><span class="ml-1">환불 관리</span></a>
              </ul>
            </li>
            <li class="nav-item dropdown">
              <a href="#profile" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle nav-link">
                <i class="fe fe-user fe-16"></i>
                <span class="ml-3 item-text">게시판 관리</span>
              </a>
              <ul class="collapse list-unstyled pl-4 w-100" id="profile">
                <a class="nav-link pl-3" href="adminIndex.jsp?pages=qnaList"><span class="ml-1">문의 관리</span></a>
                <a class="nav-link pl-3" href="adminIndex.jsp?pages=listNotice"><span class="ml-1">공지사항 관리</span></a>
              </ul>
            </li>
            <li class="nav-item w-100">
              <a class="nav-link" href="adminIndex.jsp?pages=listMember">
                <i class="fe fe-calendar fe-16"></i>
                <span class="ml-3 item-text">회원관리</span>
              </a>
            </li>
          </ul>
</body>
</html>