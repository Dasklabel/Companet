<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="free_pro.f_p_DAO" %>
<%@ page import="free_pro.Free_pro" %>
<%@ page import="java.util.ArrayList" %>
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
	window.open("sendMessage.jsp", "쪽지 보내기", "width=800, height=700, toolbar=no, menubar=no, scrollbar=no, resizable=yes");
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
            <a class="nav-link dropdown-toggle active" href="#" id="dropdownId" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">인력제공</a>
            <div class="dropdown-menu" aria-labelledby="dropdownId">
              <a class="dropdown-item" href="com_pro.jsp">회사</a>
              <a class="dropdown-item active" href="free_pro.jsp">프리랜서</a>
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
						f_p_DAO fpDAO = new f_p_DAO();
						ArrayList<Free_pro> list = fpDAO.getList(pageNumber);
						for(int i = 0; i < list.size(); i++) {
					%>
						<tr>
						<td><%= list.get(i).getFree_pro_ID() %></td>
						<td><a href="view_f_p.jsp?free_pro_ID=<%= list.get(i).getFree_pro_ID() %>"><%= list.get(i).getFree_pro_Title().replaceAll(" ", "&nbsp;")
						.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></a></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getFree_pro_Date().substring(0, 11) + list.get(i).getFree_pro_Date().substring(11, 13) + ":" + list.get(i).getFree_pro_Date().substring(14, 16) %></td>
					</tr>
					<%
						}
					%>
					
				</tbody>
			</table>
			<%
				if(pageNumber != 1) {
			%>
				<a href="free_pro.jsp?pageNumber=<%=pageNumber - 1 %>"
				class="btn btn-success btn-arrow-left" style="margin-right: 5px">이전</a>
			<%		
				} if(fpDAO.nextPage(pageNumber + 1)) {
			%>
				<a href="free_pro.jsp?pageNumber=<%=pageNumber + 1 %>"
				class="btn btn-success btn-arrow-right" style="margin-right: 5px">다음</a>
			<%		
				}
			%>
			<a href="write_f_p.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>
</html>