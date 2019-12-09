<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="message.Message_DAO"%>
<%@ page import="message.Message"%>
<%@ page import="java.util.ArrayList"%>
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
		int ID = 0;
		if(request.getParameter("ID") != null) {
			ID = Integer.parseInt(request.getParameter("ID"));
		}
		if(ID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 쪽지입니다.')");
			script.println("location.href = receiveMessage.jsp'"); //이전페이지로 복귀
			script.println("</script>");
		}
		 Message message = new Message_DAO().getMessage(ID);
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

	<div class="container">
		<div class="row">
			<div class="col-xs-1" style="margin-right: 50px; margin-top:20px; margin-bottom:20px">
				<a href="sendMessage.jsp"><button class="btn btn-default">보낸 쪽지함</button></a>
			</div>
			<div class="col-xs-1"style="margin-top:20px; margin-bottom:20px">
				<a href="receiveMessage.jsp"><button class="btn btn-warning">받은 쪽지함</button></a>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<table class="table table-hover" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">받는 사람</th>
						<th style="background-color: #eeeeee; text-align: center;">보낸 날짜</th>
					</tr>
				</thead>
				<tbody>
					<%
						Message_DAO messageDAO = new Message_DAO();
						ArrayList<Message> list = messageDAO.getReceive_List(pageNumber);
						for (int i = 0; i < list.size(); i++) {
							 /* if(userID == list.get(i).getUserID()) { */
					%>
						<tr>
						<td><%=list.get(i).getID()%></td>
						<td>
						<a
							href="view_receiveMessage.jsp?ID=<%=list.get(i).getID()%>"><%=list.get(i).getTitle().replaceAll(" ", "&nbsp;")
							.replaceAll("<", "&lt;")
						.replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
						<td><%=list.get(i).getReceiveID()%></td>
						<td><%=list.get(i).getDate().substring(0, 11) + list.get(i).getDate().substring(11, 13)
								+ ":" + list.get(i).getDate().substring(14, 16)%></td>
					</tr>
					<%
							}
						
					%>
					
					<%-- <%
						}
					%> --%>
				</tbody>
			</table>
			<%
				if (pageNumber != 1) {
			%>
			<a href="receiveMessage.jsp?pageNumber=<%=pageNumber - 1%>"
				class="btn btn-success btn-arrow-left">이전</a>
			<%
				}
				if (messageDAO.nextPage(pageNumber + 1)) {
			%>
			<a href="receiveMessage.jsp?pageNumber=<%=pageNumber + 1%>"
				class="btn btn-success btn-arrow-right">다음</a>
			<%
				}
			%>
		</div>
		
	</div>
  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>
</html>