<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userCompany" />
<jsp:setProperty name="user" property="userEmail" />
<jsp:setProperty name="user" property="userPhone" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
/* 		if(userID != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어 있습니다.')");
			script.println("location.href = 'main.jsp'"); //이전페이지로 복귀
			script.println("</script>");
		} */
		if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null
			|| user.getUserCompany() == null || user.getUserEmail() == null || user.getUserPhone() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()"); //이전페이지로 복귀
			script.println("</script>");
		}
		else if (user.getUserPassword().length() < 8 || user.getUserPassword().length() > 20){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('8~20자 이내의 패스워드를 입력해주세요.')");
				script.println("history.back()"); //이전페이지로 복귀
				script.println("</script>");
		}
		/* else if (!user.getUserPassword().matches("*")){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('특수문자가 포함되어야 합니다.')");
			script.println("history.back()"); //이전페이지로 복귀
			script.println("</script>");
		} */
		else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다.')");
				script.println("history.back()"); //이전페이지로 복귀
				script.println("</script>");
			}
			else {
					session.setAttribute("userID", user.getUserID());
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('회원가입이 완료되었습니다.')");
					script.println("location.href = 'login.jsp'");
					script.println("</script>");
			}
		}
	%>
</body>
</html>