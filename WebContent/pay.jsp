<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
<title>Companet</title>
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/small-business.css" rel="stylesheet">
<script type="text/javascript" src="httpRequest.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript">
function openWin() {
	window.open("sendMessage.jsp", "쪽지 보내기", "width=800, height=700, toolbar=no, menubar=no, scrollbar=no, resizable=yes");
}
 function requestPay() {
     // IMP.request_pay(param, callback) 호출
     
     var IMP = window.IMP;
        IMP.init('imp40727739');
        
     IMP.request_pay({ // param
         pg: "html5_inicis",
         pay_method: "card",
         merchant_uid: 'merchant_' + new Date().getTime(),
         name: "요금 결제",
         amount: 300000,
         buyer_email: "gildong@gmail.com",
         buyer_name: "홍길동",
         buyer_tel: "010-4242-4242",
         buyer_addr: "서울특별시 강남구 신사동",
         buyer_postcode: "01181"
     }, function (rsp) { // callback
    	 if ( rsp.success ) {
    		 
             var msg = '결제가 완료되었습니다.';
             msg += '고유ID : ' + rsp.imp_uid;
             msg += '상점 거래ID : ' + rsp.merchant_uid;
             msg += '결제 금액 : ' + rsp.paid_amount;
             msg += '카드 승인번호 : ' + rsp.apply_num;
         } else {
        	 var msg = '결제에 실패하였습니다. 에러내용 : ' + rsp.error_msg;
         }
    	 alert(msg);
     });
   }
    </script>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
  <!-- Navigation -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
      <a class="navbar-brand" href="main.jsp">Companet</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="dropdownId" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">인력수급</a>
            <div class="dropdown-menu" aria-labelledby="dropdownId">
              <a class="dropdown-item" href="com_app.jsp">회사</a>
              <a class="dropdown-item" href="free_app.jsp">프리랜서</a>
            </div>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="dropdownId" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">인력제공</a>
            <div class="dropdown-menu" aria-labelledby="dropdownId">
              <a class="dropdown-item" href="com_pro.jsp">회사</a>
              <a class="dropdown-item" href="free_pro.jsp">프리랜서</a>
            </div>
          </li>
          
          <li class="nav-item active">
            <a class="nav-link" href="pay.jsp">요금결제</a>
          </li>
        </ul>
        <%
				if (userID == null) {
			%>
			<script>
				location.href = "login.jsp";
			</script>

			<%
				} else {
			%>
        <ul class="navbar-nav ml-auto">
          	<li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="dropdownId" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">마이페이지</a>
            <div class="dropdown-menu" aria-labelledby="dropdownId">
              <a class="dropdown-item" href="sendMessage.jsp">쪽지함</a>
              <a class="dropdown-item" href="logoutAction.jsp">로그아웃</a>
            </div>
          </li>
          </ul>
          <%
				}
			%>
      </div>
    </div>
  </nav>

	<div class="container">
		<h3 align="center" style="margin-top:50px">요금제 안내</h3>
		<table class="table table-striped">
			<tr align="center">
				<td></td>
				<td align="center"><b>일반 회원</b></td>
				<td align="center"><b>유료 회원</b></td>
			<tr>
				<td align="center"><b>글 작성</b></td>
				<td align="center">O</td>
				<td align="center">O</td>
			</tr>
			<tr>
				<td align="center"><b>글 보기</b></td>
				<td align="center">O</td>
				<td align="center">O</td>
			</tr>
			<tr>
				<td align="center"><b>쪽지 송수신</b></td>
				<td align="center">X</td>
				<td align="center">O</td>
			</tr>
			<tr>
				<td align="center"><b>요금</b></td>
				<td align="center">무료</td>
				<td align="center">300,000원/년</td>
			</tr>
		</table>
	</div>
	<div class="row text-center" style="width: 100%; margin-top:30px">
		<div style="width: 30%; float: none; margin: 0 auto">
				<button class="btn btn btn-success btn-lg" style="width: 100%" onclick="requestPay()">유료회원으로 전환</button>
		</div>
	</div>

	  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>
</html>