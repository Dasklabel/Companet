<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="free_app.f_a_DAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="freeapp" class="free_app.Free_app" scope="page"/>
<jsp:setProperty name="freeapp" property="free_app_Title"/>
<jsp:setProperty name="freeapp" property="free_app_Content"/>
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
		if (freeapp.getFree_app_Title() == null || freeapp.getFree_app_Content() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()"); //이전페이지로 복귀
			script.println("</script>");
		} else {
			f_a_DAO faDAO = new f_a_DAO();
			int result = faDAO.write(freeapp.getFree_app_Title(), userID, freeapp.getFree_app_Content());
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패했습니다.')");
				script.println("history.back()"); //이전페이지로 복귀
				script.println("</script>");
			}
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'free_app.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>