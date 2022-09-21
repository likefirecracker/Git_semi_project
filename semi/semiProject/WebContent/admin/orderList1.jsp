<%@page import="java.util.ArrayList"%>
<%@page import="order.OrderManageBean"%>
<%@page import="order.OrderManageDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	/* String pageChange = request.getParameter("page");
	if(pageChange == null){
		pageChange = "admin_body.jsp";
	} */

	OrderManageDBBean omdb = OrderManageDBBean.getInstance();
	
	int o_rank = 0;
	int o_dNum, p_num, p_count, p_price;
	String o_num, o_dStat, refund;
	
	// 페이징 처리
	int pageSize = 10; // 한페이지에 보여질 글 수
	int count = omdb.getCount(new OrderManageBean()); // 전체 글 수
	// 현재 페이지 정보 설정
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	} 
	// 첫 행번호 계산
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage-1)*pageSize+ 1; // 2페이지면 11~20
	ArrayList<OrderManageBean> list = omdb.orderList(startRow,pageSize,"N");
	
	int pageCount=1, pageBlock=5, startPage=1, endPage=1; // pageBlock: 한 페이지에 보여줄 페이지 블럭
	if(count != 0) {
		pageCount = (int)Math.ceil((double)count / pageSize); // 전체 페이지 수
		startPage = ((currentPage-1)/pageBlock)*pageBlock+1; // 페이지 블럭 시작 번호
		endPage = startPage + pageBlock -1; // 페이지 블럭 끝 번호
		if(endPage > pageCount){
			endPage = pageCount;
		} // 전체 페이지가 10페이지인데 마지막 페이지가 11이면 안되므로 조건문 설정
	}
%>
<!doctype html>
<html lang="ko">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>document</title>
    <!-- 부트스트랩 CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <!-- Simple bar CSS -->
    <link rel="stylesheet" href="css/simplebar.css">
    <!-- Fonts CSS -->
    <link href="https://fonts.googleapis.com/css2?family=Overpass:ital,wght@0,100;0,200;0,300;0,400;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    <!-- Icons CSS -->
    <link rel="stylesheet" href="css/feather.css">
    <link rel="stylesheet" href="css/select2.css">
    <link rel="stylesheet" href="css/dropzone.css">
    <link rel="stylesheet" href="css/uppy.min.css">
    <link rel="stylesheet" href="css/jquery.steps.css">
    <link rel="stylesheet" href="css/jquery.timepicker.css">
    <link rel="stylesheet" href="css/quill.snow.css">
    <!-- Date Range Picker CSS -->
    <link rel="stylesheet" href="css/daterangepicker.css">
    <!-- App CSS -->
    <link rel="stylesheet" href="css/app-light.css" id="lightTheme" disabled>
    <link rel="stylesheet" href="css/app-dark.css" id="darkTheme">
  </head>
  <body class="vertical  dark  ">
    <div class="wrapper">
    <nav class="topnav navbar navbar-light">
	        <button type="button" class="navbar-toggler text-muted mt-2 p-0 mr-3 collapseSidebar">
	          <i class="fe fe-menu navbar-toggler-icon"></i>
	        </button>
	        <ul class="nav">
	          <li class="nav-item dropdown">
	            <a class="nav-link dropdown-toggle text-muted pr-0" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
	              <span class="avatar avatar-sm mt-2">
	                <img src="./assets/avatars/face-1.jpg" alt="..." class="avatar-img rounded-circle">
	              </span>
	            </a>
	            <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownMenuLink">
	              <a class="dropdown-item" href="#">Profile</a>
	              <a class="dropdown-item" href="#">Settings</a>
	            </div>
	          </li>
	        </ul>
	      </nav>
	      <aside class="sidebar-left border-right bg-white shadow" id="leftSidebar" data-simplebar>
        	<a href="#" class="btn collapseSidebar toggle-btn d-lg-none text-muted ml-2 mt-3" data-toggle="toggle">
         	    <i class="fe fe-x"><span class="sr-only"></span></i>
        	</a>
        	<nav class="vertnav navbar navbar-light">
          <!-- nav bar -->
          <div class="w-100 mb-4 d-flex">
            <a class="navbar-brand mx-auto mt-2 flex-fill text-center" href="../index.jsp">
              <svg version="1.1" id="logo" class="navbar-brand-img brand-sm" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" viewBox="0 0 120 120" xml:space="preserve">
                <g>
                  <polygon class="st0" points="78,105 15,105 24,87 87,87 	" />
                  <polygon class="st0" points="96,69 33,69 42,51 105,51 	" />
                  <polygon class="st0" points="78,33 15,33 24,15 87,15 	" />
                </g>
              </svg>
            </a>
          </div>
           <!-- 좌측 네비게이션 바 -->
          <p class="text-muted nav-heading mt-4 mb-1">
            <span>관리자 메뉴</span>
          </p>
          <ul class="navbar-nav flex-fill w-100 mb-2">
            <li class="nav-item dropdown">
              <a href="#ui-elements" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle nav-link">
                <i class="fe fe-box fe-16"></i>
                <span class="ml-3 item-text">상품 관리</span>
              </a>
              <ul class="collapse list-unstyled pl-4 w-100" id="ui-elements">
                <li class="nav-item">
                  <a class="nav-link pl-3" href="productReg.jsp"><span class="ml-1 item-text">상품 정보 등록</span>
                  </a>
                </li>
                <li class="nav-item">
                  <a class="nav-link pl-3" href="productList.jsp"><span class="ml-1 item-text">상품 정보 조회</span></a>
                </li>
              </ul>
            </li>
            <li class="nav-item dropdown">
              <a href="#contact" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle nav-link">
                <i class="fe fe-book fe-16"></i>
                <span class="ml-3 item-text">주문 관리</span>
              </a>
              <ul class="collapse list-unstyled pl-4 w-100" id="contact">
                <a class="nav-link pl-3" href="orderList.jsp"><span class="ml-1">주문 관리</span></a>
                <a class="nav-link pl-3" href="refundList.jsp"><span class="ml-1">환불 관리</span></a>
              </ul>
            </li>
            <li class="nav-item dropdown">
              <a href="#profile" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle nav-link">
                <i class="fe fe-user fe-16"></i>
                <span class="ml-3 item-text">게시판 관리</span>
              </a>
              <ul class="collapse list-unstyled pl-4 w-100" id="profile">
                <a class="nav-link pl-3" href="qnaList.jsp"><span class="ml-1">문의 관리</span></a>
                <a class="nav-link pl-3" href="listNotice.jsp"><span class="ml-1">공지사항 관리</span></a>
              </ul>
            </li>
            <li class="nav-item w-100">
              <a class="nav-link" href="userList.jsp">
                <i class="fe fe-calendar fe-16"></i>
                <span class="ml-3 item-text">회원관리</span>
              </a>
            </li>
          </ul>
          </aside>
      <main role="main" class="main-content">
        <div class="container-fluid">
          <div class="row justify-content-center">
            <div class="col-12">
              <h2 class="h3 mb-3 page-title">주문 관리</h2>
              <table class="table border table-hover bg-white">
                <thead>
                  <tr role="row">
                    <!-- <th>
                      <div class="custom-control custom-checkbox">
                        <input type="checkbox" class="custom-control-input" id="all">
                        <label class="custom-control-label" for="all"></label>
                      </div>
                    </th> -->
                    <th>주문 순서</th>
                    <th>주문 번호</th>
                    <th>제품 번호</th>
                    <th>수량</th>
                    <th>금액</th>
                    <th>주문 상태</th>
                    <th>주문 수정</th>
                  </tr>
                </thead>
                <tbody>
    <%
		for(int i=0; i < list.size(); i++) {
			OrderManageBean omb = list.get(i); // 배열에 넣은 역순으로 board 객체에 값을 넣어줌
			o_rank++;
			o_dNum = omb.getOrder_detail_number();
			o_num = omb.getOrder_number();
			p_num = omb.getProduct_number();
			p_count = omb.getProduct_count();
			p_price = omb.getProduct_price();
			o_dStat = omb.getOrder_detail_status();
			refund = omb.getRefund_check();
			
	%>
                  <tr>
                    <!-- <td class="align-center">
                      <div class="custom-control custom-checkbox">
                        <input type="checkbox" class="custom-control-input">
                        <label class="custom-control-label"></label>
                      </div>
                    </td> -->
                    <td><%=o_rank%></td>
					<td><%=o_num%></td>
					<td>
						<a href="#"><%=p_num%></a>
					</td>
					<td><%= p_count %></td>
					<td><%=p_price%></td>
					<td>
						<input style="border:0px; color:#dee2e6; background-color:#353a40;" type="text" name="o_dstat" value="<%=o_dStat%>" readonly />
					</td>
					<td>
						<input type="radio" name="o_dNum" value="<%= o_dNum %>" />
					</td> <!-- 라디오 버튼  > 수정 버튼 > 정보 수정, 환불 처리 -->
	<%			
		}
	%>
                  </tr>
                </tbody>
              </table>
              <input style="border-radius:5px; border:0px; background-color:#212529; color:#dee2e6;" type="submit" value="수정">
              <nav aria-label="Table Paging" class="my-3">
                <ul class="pagination justify-content-end mb-0">
                  <li class="page-item">
        <%
			if(startPage > pageBlock) {
		%>
                  	  <a class="page-link" href="orderList1.jsp&pageNum=<%= startPage-pageBlock %>">이전</a>
        <%
			}
		%>
                  </li>
                  <li class="page-item">
        <%
			for(int i = startPage; i<= endPage; i++){
		%>
				<a class="page-link" href="orderList1.jsp&pageNum=<%= i %>"><%= i %></a>
		<%	
			}
		%>
                  </li>
                  <li class="page-item">
        <%
			if(startPage+pageBlock <= pageCount) {
		%>
				<a class="page-link" href="orderList1.jsp&pageNum=<%= startPage+pageBlock %>">다음</a>
		<%
			}
		%>          
                  </li>
                </ul>
              </nav>
            </div>
          </div> <!-- .row -->
        </div> <!-- .container-fluid -->
      </main> <!-- main -->
    </div> <!-- .wrapper -->
    <script src="js/jquery.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/moment.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/simplebar.min.js"></script>
    <script src='js/daterangepicker.js'></script>
    <script src='js/jquery.stickOnScroll.js'></script>
    <script src="js/tinycolor-min.js"></script>
    <script src="js/config.js"></script>
    <script src="js/d3.min.js"></script>
    <script src="js/topojson.min.js"></script>
    <script src="js/datamaps.all.min.js"></script>
    <script src="js/datamaps-zoomto.js"></script>
    <script src="js/datamaps.custom.js"></script>
    <script src="js/Chart.min.js"></script>
    <script>
      /* defind global options */
      Chart.defaults.global.defaultFontFamily = base.defaultFontFamily;
      Chart.defaults.global.defaultFontColor = colors.mutedColor;
    </script>
    <script src="js/gauge.min.js"></script>
    <script src="js/jquery.sparkline.min.js"></script>
    <script src="js/apexcharts.min.js"></script>
    <script src="js/apexcharts.custom.js"></script>
    <script src='js/jquery.mask.min.js'></script>
    <script src='js/select2.min.js'></script>
    <script src='js/jquery.steps.min.js'></script>
    <script src='js/jquery.validate.min.js'></script>
    <script src='js/jquery.timepicker.js'></script>
    <script src='js/dropzone.min.js'></script>
    <script src='js/uppy.min.js'></script>
    <script src='js/quill.min.js'></script>
    <script>
      $('.select2').select2(
      {
        theme: 'bootstrap4',
      });
      $('.select2-multi').select2(
      {
        multiple: true,
        theme: 'bootstrap4',
      });
      $('.drgpicker').daterangepicker(
      {
        singleDatePicker: true,
        timePicker: false,
        showDropdowns: true,
        locale:
        {
          format: 'MM/DD/YYYY'
        }
      });
      $('.time-input').timepicker(
      {
        'scrollDefault': 'now',
        'zindex': '9999' /* fix modal open */
      });
      /** date range picker */
      if ($('.datetimes').length)
      {
        $('.datetimes').daterangepicker(
        {
          timePicker: true,
          startDate: moment().startOf('hour'),
          endDate: moment().startOf('hour').add(32, 'hour'),
          locale:
          {
            format: 'M/DD hh:mm A'
          }
        });
      }
      var start = moment().subtract(29, 'days');
      var end = moment();

      function cb(start, end)
      {
        $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
      }
      $('#reportrange').daterangepicker(
      {
        startDate: start,
        endDate: end,
        ranges:
        {
          'Today': [moment(), moment()],
          'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
          'Last 7 Days': [moment().subtract(6, 'days'), moment()],
          'Last 30 Days': [moment().subtract(29, 'days'), moment()],
          'This Month': [moment().startOf('month'), moment().endOf('month')],
          'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
        }
      }, cb);
      cb(start, end);
      $('.input-placeholder').mask("00/00/0000",
      {
        placeholder: "__/__/____"
      });
      $('.input-zip').mask('00000-000',
      {
        placeholder: "____-___"
      });
      $('.input-money').mask("#.##0,00",
      {
        reverse: true
      });
      $('.input-phoneus').mask('(000) 000-0000');
      $('.input-mixed').mask('AAA 000-S0S');
      $('.input-ip').mask('0ZZ.0ZZ.0ZZ.0ZZ',
      {
        translation:
        {
          'Z':
          {
            pattern: /[0-9]/,
            optional: true
          }
        },
        placeholder: "___.___.___.___"
      });
      // editor
      var editor = document.getElementById('editor');
      if (editor)
      {
        var toolbarOptions = [
          [
          {
            'font': []
          }],
          [
          {
            'header': [1, 2, 3, 4, 5, 6, false]
          }],
          ['bold', 'italic', 'underline', 'strike'],
          ['blockquote', 'code-block'],
          [
          {
            'header': 1
          },
          {
            'header': 2
          }],
          [
          {
            'list': 'ordered'
          },
          {
            'list': 'bullet'
          }],
          [
          {
            'script': 'sub'
          },
          {
            'script': 'super'
          }],
          [
          {
            'indent': '-1'
          },
          {
            'indent': '+1'
          }], // outdent/indent
          [
          {
            'direction': 'rtl'
          }], // text direction
          [
          {
            'color': []
          },
          {
            'background': []
          }], // dropdown with defaults from theme
          [
          {
            'align': []
          }],
          ['clean'] // remove formatting button
        ];
        var quill = new Quill(editor,
        {
          modules:
          {
            toolbar: toolbarOptions
          },
          theme: 'snow'
        });
      }
      // Example starter JavaScript for disabling form submissions if there are invalid fields
      (function()
      {
        'use strict';
        window.addEventListener('load', function()
        {
          // Fetch all the forms we want to apply custom Bootstrap validation styles to
          var forms = document.getElementsByClassName('needs-validation');
          // Loop over them and prevent submission
          var validation = Array.prototype.filter.call(forms, function(form)
          {
            form.addEventListener('submit', function(event)
            {
              if (form.checkValidity() === false)
              {
                event.preventDefault();
                event.stopPropagation();
              }
              form.classList.add('was-validated');
            }, false);
          });
        }, false);
      })();
    </script>
    <script>
      var uptarg = document.getElementById('drag-drop-area');
      if (uptarg)
      {
        var uppy = Uppy.Core().use(Uppy.Dashboard,
        {
          inline: true,
          target: uptarg,
          proudlyDisplayPoweredByUppy: false,
          theme: 'dark',
          width: 770,
          height: 210,
          plugins: ['Webcam']
        }).use(Uppy.Tus,
        {
          endpoint: 'https://master.tus.io/files/'
        });
        uppy.on('complete', (result) =>
        {
          console.log('Upload complete! We’ve uploaded these files:', result.successful)
        });
      }
    </script>
    <script src="js/apps.js"></script>
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-56159088-1"></script>
    <script>
      window.dataLayer = window.dataLayer || [];

      function gtag()
      {
        dataLayer.push(arguments);
      }
      gtag('js', new Date());
      gtag('config', 'UA-56159088-1');
    </script>
  </body>
</html>