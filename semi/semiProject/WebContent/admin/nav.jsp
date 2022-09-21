<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <script>
        function show_product(){
            if($('.product_sub').css('display') == 'none'){
            $('.product_sub').show();
            } else {
                $('.product_sub').hide();
            }
        }
        function show_order(){
            if($('.order_sub').css('display') == 'none'){
            $('.order_sub').show();
            } else {
                $('.order_sub').hide();
            }
        }
        function show_board(){
            if($('.board_sub').css('display') == 'none'){
                $('.board_sub').show();
            } else {
                $('.board_sub').hide();
            }
        }
    </script>
    <style>
        *{
            list-style: none;
            padding: 0;
            margin: 0;
        }
        a{
            text-decoration: none;
            color: black;
            display: block;
            height: 30px;
        }
        button{
            background: inherit ; 
            border:none; 
            box-shadow:none; 
            border-radius:0; 
            padding:0; 
            overflow:visible; 
            cursor:pointer;
            font-size: 16px;
        }
        #nav_left span {
            font-size: 24px;
            font-weight: bold;
            display: block;
            height: 30px;
            line-height: 30px;
        }
        hr {
        	margin-bottom: 10px;
        }
        .tab {
            display: inline-block;
            height: 90px;
            width: 100%;
        }
        .tab > div {
            display: none;
            font-size: 14px;
            font-weight: 500;
        }
    </style>
</head>
<body>
    <div id="nav_left">
        <span>관리자 메뉴</span>
        <hr />
        <div class="tab">
            <button class="product_tab" onclick="show_product()">상품 관리 ></button>
            <div class="product_sub">
                <a href="?page=productReg.jsp">상품 정보 등록</a>
                <a href="?page=productList.jsp">상품 정보 조회</a>
            </div>
        </div>
        <div class="tab">
            <button class="order_tab" onclick="show_order()">주문 관리 ></button>
            <div class="order_sub">
	            <a href="?page=orderList.jsp">주문 관리</a>
                <a href="?page=refundList.jsp">환불 관리</a>
            </div>
        </div>
        <div class="tab">
            <button class="board_tab" onclick="show_board()">게시판 관리 ></button>
            <div class="board_sub">
                <a href="?page=qnaList.jsp">문의 관리</a>
                <a href="?page=listNotice.jsp">공지사항 관리</a>
            </div>
        </div>
        <div class="tab">
            <a href="?page=userList.jsp">회원 관리 ></a>
        </div>
    </div>
</body>
</html>