<%@page import="cs.NoticeDBBean"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<jsp:useBean class="cs.NoticeBean" id="notice"></jsp:useBean>
<%
	int n_num=0;
	if(request.getParameter("n_num") == null){
		response.sendRedirect("adminIndex.jsp");
	} else{
		NoticeDBBean noticeDBBean = NoticeDBBean.getInstance();
		n_num = Integer.parseInt(request.getParameter("n_num"));
		notice = noticeDBBean.getNotice(n_num,false);				
	}
	String pageNum=request.getParameter("pageNum");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
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
    <link rel="stylesheet" href="css/quill.snow.css?a=b">
    <!-- Date Range Picker CSS -->
    <link rel="stylesheet" href="css/daterangepicker.css">
    <!-- App CSS -->
    <link rel="stylesheet" href="css/app-light.css" id="lightTheme" disabled>
    <link rel="stylesheet" href="css/app-dark.css" id="darkTheme">
</head>
<script src="notice.js?a=b"></script>
<body>
	<div style="text-align: center; margin: 10px auto; width: 90%" class="card shadow">
		<h1 style="margin: 10px">글 수정하기</h1>
		<form method="post" action="edit_okNotice.jsp?n_num=<%= n_num %>&pageNum=<%= pageNum %>" name="wrt_frm">
			<table style="margin: 0 auto; width: 90%" >
				<tr height="30">
					<td width="80">작성자</td>
					<td width="140" align="left">
						<%-- <input type="text" name="user_id" size="15" maxlength="20"  value="<%= notice.getUser_id()%>" readonly> --%>
	                        <input type="text" class="form-control" value="<%= notice.getUser_id() %>" aria-label="Username" aria-describedby="basic-addon1" readonly style="height: 25px; width: 90%;">
					</td>
				</tr>
				<tr height="30">
					<td width="80">글제목</td>
					<td colspan="3" width="460">
	                        <input name="n_title" type="text" class="form-control" value="<%= notice.getN_title() %>" aria-label="Username" aria-describedby="basic-addon1" style="height: 25px; width: 90%;">
					</td>
				</tr>
				<tr>
					<td colspan="4">
                   		<div class="card-body" style="color: #ccc; width: 100%;">
                   			<div id="editor" style="min-height:300px;" contenteditable="true">
                   				<%= notice.getN_content() %>
                   			</div>
                   		</div>
                  		<input type="hidden" value="" name="n_content" id="content">
					</td>
				</tr>
				<tr>
					<td>
						암&nbsp;&nbsp;호
					</td>
					<td height="50">
                        <input type="password" name="n_pwd" class="form-control" aria-label="Username" aria-describedby="basic-addon1" style="height: 25px; width: 100px;">
					</td>	
				</tr>
				<tr>
					<td height="50" colspan="4" align="center">
						<input type="button" value="글수정" onclick="onclick_ok()">&nbsp;
						<input type="reset" value="다시작성">
						<input type="button" value="글목록" onclick="location.href='adminIndex.jsp?pages=showNotice&pageNum=<%= pageNum %>&n_num=<%=n_num%>'">
					</td>	
				</tr>
			</table>
		</form>
	</div>
	
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
</body>
</html>