<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Companet</title>

  <!-- Bootstrap core CSS -->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="css/small-business.css" rel="stylesheet">

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
          
          <li class="nav-item">
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

  <!-- Page Content -->
  <div class="container">

    <!-- Heading Row -->
    <div class="row align-items-center my-5">
      <div class="col-lg-7">
        <img class="img-fluid rounded mb-4 mb-lg-0" src="image\main_image.png" width="900" height="400" alt="">
      </div>
      <!-- /.col-lg-8 -->
      <div class="col-lg-5">
        <h2 class="font-weight-light">기업 간의 자유로운 인력 공유</h2><hr>
        <p>프로젝트에 갑작스런 공석이 생겼을 때, 필요 인재를 바로 충원하지 못할 때가 있습니다. Companet에서는 여러 기업이 올려놓은 인재를 잠시 공유해올 수 있도록 다리 역할을 합니다.</p>
        <a class="btn btn-primary" href="com_app.jsp">시작하기!</a>
      </div>
      <!-- /.col-md-4 -->
    </div>
    <!-- /.row -->

    <!-- Call to Action Well -->
    <div class="card text-white bg-secondary my-5 py-4 text-center">
      <div class="card-body">
        <p class="text-white m-0">유료회원은 쪽지 기능을 사용할 수 있습니다.</p>
      </div>
    </div>

    <!-- Content Row -->
    <div class="row">
      <div class="col-md-4 mb-5">
        <div class="card h-100">
          <div class="card-body">
            <h2 class="card-title">인력 수급</h2>
            <p class="card-text">타 기업 인력이나 검증된 프리랜서를 수급해올 수 있는 게시판입니다. 타 기업이 올린 경력있는 인력들이 있습니다.</p>
          </div>
          <div class="card-footer">
            <a href="com_app.jsp" class="btn btn-primary btn-sm">이동하기</a>
          </div>
        </div>
      </div>
      <!-- /.col-md-4 -->
      <div class="col-md-4 mb-5">
        <div class="card h-100">
          <div class="card-body">
            <h2 class="card-title">인력 제공</h2>
            <p class="card-text">자신의 기업에 현재 공유 가능한 인력을 경력과 함께 홍보할 수 있습니다. 함께 일했던 프리랜서도 홍보할 수 있습니다.</p>
          </div>
          <div class="card-footer">
            <a href="com_pro.jsp" class="btn btn-primary btn-sm">이동하기</a>
          </div>
        </div>
      </div>
      <!-- /.col-md-4 -->
      <div class="col-md-4 mb-5">
        <div class="card h-100">
          <div class="card-body">
            <h2 class="card-title">요금제 안내</h2>
            <p class="card-text">글작성자와 연락을 위해 필요한 쪽지 기능은 유료회원이 되면 이용 가능합니다. 유료회원이 되어 더 많은 기능을 이용해보세요.</p>
          </div>
          <div class="card-footer">
            <a href="pay.jsp" class="btn btn-primary btn-sm">이동하기</a>
          </div>
        </div>
      </div>
      <!-- /.col-md-4 -->

    </div>
    <!-- /.row -->

  </div>
  <!-- /.container -->

  <!-- Footer -->
  <footer class="py-5 bg-dark">
    <div class="container">
      <p class="m-0 text-center text-white">Copyright &copy; Companet</p>
    </div>
    <!-- /.container -->
  </footer>

  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>
