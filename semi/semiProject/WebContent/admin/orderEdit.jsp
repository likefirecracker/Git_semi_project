<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="order.OrderManageBean"%>
<%@page import="order.OrderManageDBBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%
	OrderManageDBBean omdb = OrderManageDBBean.getInstance();
	OrderManageBean omb = omdb.getBoard(Integer.parseInt(request.getParameter("o_dNum")));
	String pageNum = request.getParameter("pageNum");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	String o_dStat = omb.getOrder_detail_status();
	int p_count = omb.getProduct_count();
	int p_price = omb.getProduct_price();
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
      <main role="main" class="main-content">
        <div class="container-fluid">
          <div class="row justify-content-center">
            <div class="col-12">
              <h2 class="page-title">주문서 수정</h2>
              <div class="row">
                <div class="col-md-12">
                  <div class="card shadow mb-4">
                    <div class="card-header">
                      <strong class="card-title">주문 내역</strong>
                    </div>
                    <div class="card-body">
                      <form action="orderEdit_ok.jsp?pageNum=<%= pageNum %>" method="post" name="order_frm">
                        <div class="form-row">
                          <div class="form-group col-md-4">
                            <label for="inputEmail4">주문 일자</label>
                            <input type="text" class="form-control" id="inputEmail5" value="<%= sdf.format(omb.getOrder_date()) %>" readonly />
                          </div>
                          <div class="form-group col-md-4">
                            <label for="inputPassword4">주문 번호</label>
                            <input type="text" class="form-control" name="order_number" id="inputPassword5" value="<%= omb.getOrder_number() %>" readonly />
                          </div>
                          <div class="form-group col-md-4">
                            <label for="inputState">주문 상태</label>
                            <select id="status" class="form-control" name="order_detail_status">
	                            <option value="입금 완료">입금 완료</option>
		                        <option value="배송 준비">배송 준비</option>
		                        <option value="배송중">배송중</option>
		                        <option value="배송 완료">배송 완료</option>
		                        <option value="구매 확정">구매 확정</option>
                            </select>
                          </div>
                        </div>
                        <div class="form-row">
                          <div class="form-group col-md-3">
                            <label for="inputEmail4">주문자 ID</label>
                            <input type="text" class="form-control" id="inputEmail5" value="<%= omb.getUser_id() %>" readonly />
                          </div>
                          <div class="form-group col-md-3">
                            <label for="inputEmail4">상품 번호</label>
                            <input type="text" class="form-control" id="inputEmail5" value="<%= omb.getProduct_number() %>" readonly />
                          </div>
                          <div class="form-group col-md-3">
                            <label for="inputPassword4">수량(개)</label>
                            <input type="text" class="form-control" id="inputPassword5" value="<%= p_count %>" />
                          </div>
                          <div class="form-group col-md-3">
                            <label for="inputPassword4">금액(원)</label>
                            <input type="text" class="form-control" id="inputPassword5" value="<%= p_price %>" />
                          </div>
                        </div>
                        <div class="form-row">
                          <div class="form-group col-md-3">
                            <label for="inputPassword4">수령자</label>
                            <input type="text" class="form-control" name="receiver_name" id="inputPassword5" value="<%= omb.getReceiver_name() %>" />
                          </div>
                        </div>
                        <div class="form-row">
                          <div class="form-group col-md-2">
                          	<label for="inputPassword4">전화번호</label>
                          </div>
                        </div>
                        <div class="form-row">
                          <div class="form-group col-md-2">
                            <select id="phone" class="form-control" name="receiver_phone1">
	                            <option value="010">010</option>
		                        <option value="02">02</option>
		                        <option value="031">031</option>
		                        <option value="051">051</option>
                            </select>
                          </div>
                          <div class="form-group col-md-2">
                            <input type="text" class="form-control" name="receiver_phone2" value="<%= omb.getReceiver_phone2() %>" maxlength="4" />
                          </div>
                          <div class="form-group col-md-2">
                            <input type="text" class="form-control" name="receiver_phone3" value="<%= omb.getReceiver_phone3() %>" maxlength="4" />
                          </div>
                        </div>
	                    <div class="form-row">
	                    	<div class="form-group col-md-3">
                          		<label for="inputPassword4">수령 주소</label>
                          	</div>
                        </div>
                        <div class="form-row">
	                        <div class="form-group col-md-1">
	                        	<input type="text" class="form-control" name="receiver_pcode" id="sample4_postcode" value="<%= omb.getReceiver_pcode() %>">
	                        </div>
	                        <div class="form-group col-md-1">
							<input type="button" class="form-control" onclick="sample4_execDaumPostcode()" value="주소 변경"><br>
                        	</div>
                        </div>
                        <div class="form-row">
	                        <div class="form-group col-md-4">
								<input type="text" class="form-control" name="receiver_raddr" id="sample4_roadAddress" value="<%= omb.getReceiver_raddr() %>">
								<input type="hidden" class="form-control" name="receiver_jibun" id="sample4_jibunAddress" value="<%= omb.getReceiver_jibun() %>">
								<span id="guide" style="color:#999;display:none;"></span>
							</div>
							<div class="form-group col-md-4">
								<input type="text" class="form-control" name="receiver_detailaddr" id="sample4_detailAddress" value="<%= omb.getReceiver_detailaddr() %>">
								<input type="hidden" id="sample4_extraAddress" placeholder="참고항목">
							</div>
						</div>
						
                        <div class="form-row">
                          
                        </div>
                        <input type="button" class="btn btn-primary" value="주문 수정" onclick="check()" />
                        <input type="reset" class="btn btn-primary">
                        <input type="button" class="btn btn-primary" value="주문 목록" onclick="history.go(-1)" />
                      </form>
                    </div> <!-- /. card-body -->
                  </div> <!-- /. card -->
                </div> <!-- /. col -->
              </div> <!-- /. end-section -->
            </div> <!-- .col-12 -->
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
	<script type="text/javascript" src="admin.js" charset="UTF-8"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
    <script type="text/javascript">
		/*주문 수정 페이지에서 넘겨 받은 주문 상태가 기본으로 선택되게 하는 스크립트(Jquery 필요)*/
		$(function(){
			$("#status > option[value='<%= o_dStat %>']").prop("selected", true);
		});
		/* 변수를 받아야해서 스크립트 파일에 넣지 못함 */
	</script>
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