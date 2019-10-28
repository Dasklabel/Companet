<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com_app.Com_app" %>
<%@ page import="com_app.Write_c_a_DAO" %>
<%@ page import="comment.Comment_c_a" %>
<%@ page import="comment.C_C_A_DAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
<script type="text/javascript"></script>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int Com_app_ID = 0;
		if(request.getParameter("com_app_ID") != null) {
			Com_app_ID = Integer.parseInt(request.getParameter("com_app_ID"));
		}
		if(Com_app_ID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'com_app.jsp'"); //이전페이지로 복귀
			script.println("</script>");
		}
		Com_app comapp = new Write_c_a_DAO().getCom_app(Com_app_ID);
		Comment_c_a cca = new C_C_A_DAO().getC_C_A(id);
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
			</form>
			
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
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>						
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><%= comapp.getCom_app_Title().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%= comapp.getUserID() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%= comapp.getCom_app_Date().substring(0, 11) + comapp.getCom_app_Date().substring(11, 13) + ":" + comapp.getCom_app_Date().substring(14, 16) %></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="min-height: 200px; text-align: left;"><%= comapp.getCom_app_Content().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
				</tbody>
			</table>
			
			<table>
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">댓글</th>						
					</tr>
				</thead>
				<tbody>
					<tr>
						<td width="100">이름</td>
						<td width="150"><input type="text" name="name"></td>
						<td width="100">패스워드</td>
						<td width="150"><input type="password" name="password"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="3"><%= comapp.getUserID() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%= comapp.getCom_app_Date().substring(0, 11) + comapp.getCom_app_Date().substring(11, 13) + ":" + comapp.getCom_app_Date().substring(14, 16) %></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="min-height: 200px; text-align: left;"><%= comapp.getCom_app_Content().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
				</tbody>
			</table>
			
			
			<a href="com_app.jsp" class="btn btn-primary">목록</a>
			<%
				if(userID != null && userID.equals(comapp.getUserID())) {
			%>
					<a href="update_c_a.jsp?com_app_ID=<%= Com_app_ID %>" class="btn btn-primary">수정</a>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="delete_c_a_Action.jsp?com_app_ID=<%= Com_app_ID %>" class="btn btn-primary">삭제</a>
			<%
				}
			%>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>
</html>