<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="message.Message"%>
<%@ page import="message.Message_DAO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
</script>
</head>
<body>
	<%
		int id = 0;
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int ID = 0;
		if(request.getParameter("ID") != null) {
			ID = Integer.parseInt(request.getParameter("ID"));
		}
		if(ID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 쪽지입니다.')");
			script.println("location.href = 'receiveMessage.jsp'"); //이전페이지로 복귀
			script.println("</script>");
		}
		Message message = new Message_DAO().getMessage(ID);
	%>
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
			<%
				}
			%>

	<div class="container">
		<div class="row">
			<table class="table table-hover"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3"
							style="background-color: #eeeeee; text-align: center;">쪽지</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><%= message.getTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
					<tr>
						<td>보낸 사람</td>
						<td colspan="2"><%= message.getUserID() %></td>
					</tr>
					<tr>
						<td>보낸 날짜</td>
						<td colspan="2"><%= message.getDate().substring(0, 11) + message.getDate().substring(11, 13) + ":" + message.getDate().substring(14, 16) %></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="min-height: 200px; text-align: left;"><%= message.getContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
						.replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
				</tbody>
			</table>

			<a href="receiveMessage.jsp" class="btn btn-primary">목록</a>

			<%
				if(userID != null && userID.equals(message.getUserID())) {
			%>
				<a onclick="return confirm('정말로 삭제하시겠습니까?')"
				href="delete_receiveMessage.jsp?ID=<%= ID %>"
				class="btn btn-primary">삭제</a>
			<%
				}
			%>
		</div>
	</div>

	<!-- <div class="container">
		<div class="row">
			<form method="post" action="comment_c_a_Action.jsp">
			<table class="table table-hover" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">댓글</th>						
					</tr>
				</thead>
				<tbody>
					<tr>
						<td width="100">패스워드</td>
						<td width="150" style="text-align: left"><input type="password" name="password"></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><textarea class="form-control" name="content" maxlength="3000" style="height: 100px;"></textarea></td>
					</tr>
				</tbody>
			</table>
			<input type="submit" class="btn btn-primary pull-right" value="댓글 작성">
			</form> 
		</div>
	</div> -->


	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>
</html>