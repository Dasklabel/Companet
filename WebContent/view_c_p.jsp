<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="com_pro.Com_pro" %>
<%@ page import="com_pro.c_p_DAO" %>
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
<script type="text/javascript">
function openWin() {
	window.open("sendMessageWindow.jsp", "쪽지 보내기", "width=800, height=700, toolbar=no, menubar=no, scrollbar=no, resizable=yes");
}
</script>
</head>
<body>
	<%
    int id = 0;
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int Com_pro_ID = 0;
		if(request.getParameter("com_pro_ID") != null) {
			Com_pro_ID = Integer.parseInt(request.getParameter("com_pro_ID"));
		}
		if(Com_pro_ID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'com_pro.jsp'"); //이전페이지로 복귀
			script.println("</script>");
		}
		Com_pro compro = new c_p_DAO().getCom_pro(Com_pro_ID);
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
            <a class="nav-link dropdown-toggle active" href="#" id="dropdownId" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">인력제공</a>
            <div class="dropdown-menu" aria-labelledby="dropdownId">
              <a class="dropdown-item active" href="com_pro.jsp">회사</a>
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
	<div class="container">
		<div class="align-items-center my-5">
		<div class="row">
		<table class="table table-hover"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3"
							style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><%= compro.getCom_pro_Title().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%= compro.getUserID() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%= compro.getCom_pro_Date().substring(0, 11) + compro.getCom_pro_Date().substring(11, 13) + ":" + compro.getCom_pro_Date().substring(14, 16) %></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="min-height: 200px; text-align: left;"><%= compro.getCom_pro_Content().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
						.replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
					</tr>
				</tbody>
			</table>

				<div class="col-xs-1">
					<a href="com_pro.jsp" class="btn btn-primary" style="margin-right: 5px">목록</a>
				</div>
			<%
				if(userID != null && userID.equals(compro.getUserID())) {
			%>
				<div class="col-xs-1">
					<a href="update_c_p.jsp?com_pro_ID=<%= Com_pro_ID %>"
				class="btn btn-primary" style="margin-right: 5px" >수정</a>
				</div>
				<div class="col-xs-1">
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="delete_c_p_Action.jsp?com_pro_ID=<%= Com_pro_ID %>"
				class="btn btn-primary">삭제</a>
				</div>
				
			</div>
			
			<%
				}
			%>
		</div>
			
		</div>

  <div class="row text-center" style="width: 100%">
		<div style="width: 30%; float: none; margin: 0 auto">
			<form method="post">
				<button class="btn btn btn-success btn-lg" style="width: 100%" onclick="javascript:openWin();">쪽지 보내기</button>
			</form>
		</div>
	</div>
	  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>
</html>
