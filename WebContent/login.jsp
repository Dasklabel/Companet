<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
</head>
<body>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand">Companet</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<li class="nav-item">
					<a class="nav-link" href="#">도움말</a>
				</li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="active"><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</nav>
	
	<!-- 진한색 테두리 안에 설명 넣기 -->
	<div class="container">
		<div class="col-xs-4" style="border:1.5px dashed gray">
			<table>
				<tr>
					<td><h3>소개</h3> Companet은 기업 내 인력을 타 기업과 연결해주는 서비스입니다.</td>
				</tr>
				<tr>
					<td><hr></td>
				</tr>
				<tr>
					<td>기업 내의 인력을 홍보하면  그 인력을 원하는 다른 기업이 Companet을 통해 연락을 해올 것입니다. 인력이 필요할 때도 마찬가지입니다.</td>
				</tr>
				<tr>
					<td>함께 일했던 프리랜서를 홍보하거나 필요한 프리랜서를 수급하는 것도 가능합니다.</td>
				</tr>
				<tr>
					<td><hr></td>
				</tr>
				<tr>
					<td>컴파넷과 함께라면 인력 공유가 수월해집니다!</td>
				</tr>
				<tr>
					<td><hr></td>
				</tr>
			</table>
				
		</div>
		<div class="col-xs-4"></div>
		<div class="col-xs-4"></div>
		<div class="col-xs-4"><span class="pull-right"></span>
			<div class="jumbotron" style="padding-top: 20px">
				<form method="post" action="loginAction.jsp">
					<h3 style="text-align: center">로그인</h3>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="아이디(ID)" name="userID" maxlength="20">
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호(PW)" name="userPassword" maxlength="20">
					</div>
					<input type="submit" class="btn btn-primary form-control" value="Login" style="margin-bottom:13px">
					
					<input type="button" class="btn btn-primary form-control" onclick="location.href='join.jsp';" value="회원가입">
				</form>
			</div>
		</div>
		<div class="col-lg-4"></div>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>