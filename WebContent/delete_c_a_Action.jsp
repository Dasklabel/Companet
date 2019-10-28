<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com_app.Com_app" %>
<%@ page import="com_app.Write_c_a_DAO" %>
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
		if(!userID.equals(comapp.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'com_app.jsp'"); //이전페이지로 복귀
			script.println("</script>");
		}
		else {
			Write_c_a_DAO wcaDAO = new Write_c_a_DAO();
			int result = wcaDAO.delete(Com_app_ID);
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
				script.println("location.href = 'com_app.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>