<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="free_app.Free_app" %>
<%@ page import="free_app.f_a_DAO" %>
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
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
			script.println("location.href = 'login.jsp'"); //이전페이지로 복귀
			script.println("</script>");
		}
		int Free_app_ID = 0;
		if(request.getParameter("free_app_ID") != null) {
			Free_app_ID = Integer.parseInt(request.getParameter("free_app_ID"));
		}
		if(Free_app_ID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'free_app.jsp'"); //이전페이지로 복귀
			script.println("</script>");
		}
		Free_app freeapp = new f_a_DAO().getFree_app(Free_app_ID);
		if(!userID.equals(freeapp.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'free_app.jsp'"); //이전페이지로 복귀
			script.println("</script>");
		}
	%>
	<nav class="navbar navbar-default">
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
						<li><a href="com_app.jsp">회사소속</a></li>
						<li class="active"><a href="free_app.jsp">프리랜서</a></li>
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
			</form>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle"
							data-toggle="dropdown" role="button" aria-haspopup="true"
							aria-expanded="false">내정보<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="#">마이페이지</a></li>
							<li><a href="logoutAction.jsp">로그아웃</a></li>
						</ul>
					</li>
				</ul>
		</div>
	</nav>
	<div class="container">
		<div class="row">
		<form method="post" action="update_f_a_Action.jsp?free_app_ID=<%= Free_app_ID %>">
			<table class="table table-hover" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2" style="background-color: #eeeeee; text-align: center;">글 수정</th>						
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" class="form-control" placeholder="제목" name="free_app_Title" maxlength="50" value="<%= freeapp.getFree_app_Title()%>"></td>
					</tr>
					<tr>
						<td><textarea class="form-control" placeholder="내용" name="free_app_Content" maxlength="3000" style="height: 350px;"><%= freeapp.getFree_app_Content()%></textarea></td>
					</tr>
				</tbody>
			</table>
			<input type="submit" class="btn btn-primary pull-right" value="글수정">
		</form>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>
</html>