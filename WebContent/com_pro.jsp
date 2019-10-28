<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="com_pro.c_p_DAO"%>
<%@ page import="com_pro.Com_pro"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
<script type="text/javascript" src="httpRequest.js"></script>

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
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">Companet</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">인력수급<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="com_app.jsp">회사소속</a></li>
						<li><a href="free_app.jsp">프리랜서</a></li>
					</ul></li>
				<li class="active"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">인력제공<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li class="active"><a href="com_pro.jsp">회사소속</a></li>
						<li><a href="free_pro.jsp">프리랜서</a></li>
					</ul></li>
			</ul>
			<form class="form-inline my-2 my-lg-0 mr-auto" id="my_searchbar">
				<input class="form-control mr-sm-2" type="search"
					placeholder="Search" aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
			</form>

			<%
				if (userID == null) {
			%>
			<script>
				location.href = "login.jsp";
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
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">내정보<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="#">마이페이지</a></li>
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<table class="table table-hover" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						c_p_DAO cpDAO = new c_p_DAO();
						ArrayList<Com_pro> list = cpDAO.getList(pageNumber);
						for (int i = 0; i < list.size(); i++) {
					%>
					<tr>
						<td><%=list.get(i).getCom_pro_ID()%></td>
						<td><a
							href="view_c_p.jsp?com_pro_ID=<%=list.get(i).getCom_pro_ID()%>"><%=list.get(i).getCom_pro_Title().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
						.replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
						<td><%=list.get(i).getUserID()%></td>
						<td><%=list.get(i).getCom_pro_Date().substring(0, 11) + list.get(i).getCom_pro_Date().substring(11, 13)
								+ ":" + list.get(i).getCom_pro_Date().substring(14, 16)%></td>
					</tr>
					<%
						}
					%>

				</tbody>
			</table>
			<%
				if (pageNumber != 1) {
			%>
			<a href="com_pro.jsp?pageNumber=<%=pageNumber - 1%>"
				class="btn btn-success btn-arrow-left">이전</a>
			<%
				}
				if (cpDAO.nextPage(pageNumber + 1)) {
			%>
			<a href="com_pro.jsp?pageNumber=<%=pageNumber + 1%>"
				class="btn btn-success btn-arrow-right">다음</a>
			<%
				}
			%>
		<a href="write_c_p.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
		
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>
</html>