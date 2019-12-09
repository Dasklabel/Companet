<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="message.Message_DAO" %>
<%@ page import="com_app.Com_app"%>
<%@ page import="com_app.Write_c_a_DAO"%>

<%-- <jsp:useBean id="comapp" class="com_app.Com_app" scope="page"/>
<jsp:setProperty name="comapp" property="userID"/> --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
</head>
<body>
	<%
		int id = 0;
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int Com_app_ID = 0;
		if(request.getParameter("com_app_ID") != null) {
			Com_app_ID = Integer.parseInt(request.getParameter("com_app_ID"));
		}
		
		Com_app comapp = new Write_c_a_DAO().getCom_app(Com_app_ID);
	%>
	<!-- <nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">Companet</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
			<li><a href="main.jsp">메인</a></li>
			<li class="active">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">인력수급<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="active"><a href="com_app.jsp">회사소속</a></li>
						<li><a href="free_app.jsp">프리랜서</a></li>
					</ul>
			</li>
			<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">인력제공<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="com_pro.jsp">회사소속</a></li>
						<li><a href="free_pro.jsp">프리랜서</a></li>
					</ul>
			</li>
			</ul>
			<form class="form-inline my-2 my-lg-0 mr-auto" id="my_searchbar">
				<input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
			</form> -->
			
			<%
				if (userID == null) {
			%>
			<script>
				location.href="login.jsp";
			</script>
				<!-- <ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul> -->
			<%
				} else {
			%>
				<!-- <ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">내정보<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="#">마이페이지</a></li>
							<li><a href="logoutAction.jsp">로그아웃</a></li>
						</ul>
					</li>
				</ul> -->
			<%
				}
			%>
		<!-- </div>
	</nav> -->
	<div class="container">
		<div class="row">
		<form method="post" action="sendMessageAction.jsp">
			<table class="table table-hover" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2" style="background-color: #eeeeee; text-align: center;">쪽지 보내기</th>					
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" class="form-control" placeholder="제목" name="title" maxlength="50"></td>
					</tr>
					<tr>
						<td><input type="text" class="form-control" placeholder="받는 사람" name="receiveID" maxlength="50"></td>
						<%-- <td>받는 사람: <%= comapp.getUserID()%></td> --%>
					</tr>
				</tbody>
			</table>
			<table class="table table-hover" style="text-align: center; border: 1px solid #dddddd">
					<tbody>
					<tr>
						<td><textarea class="form-control" placeholder="내용" name="content" maxlength="3000" style="height: 350px;"></textarea></td>
					</tr>
				</tbody>
			</table>
			<input type="submit" class="btn btn-primary pull-right" value="보내기">
		</form>
		<!-- <form method="post" action="upload.jsp" enctype="multipart/form-data">
				<table class="table table-hover" style="text-align: left; border: 1px solid #dddddd">
					<tr>
						<td><input type="file" name="file"></td>
					</tr>
				</table>
			<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
		</form>  -->
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>
</html>