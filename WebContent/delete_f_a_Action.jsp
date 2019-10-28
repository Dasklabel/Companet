<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="free_app.Free_app" %>
<%@ page import="free_app.f_a_DAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
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
		else {
			f_a_DAO faDAO = new f_a_DAO();
			int result = faDAO.delete(Free_app_ID);
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글 삭제에 실패했습니다.')");
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