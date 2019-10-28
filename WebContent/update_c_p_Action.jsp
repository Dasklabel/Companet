<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com_pro.Com_pro" %>
<%@ page import="com_pro.c_p_DAO" %>
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
		if(!userID.equals(compro.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'com_pro.jsp'"); //이전페이지로 복귀
			script.println("</script>");
		}
		else {
			if (request.getParameter("com_pro_Title") == null || request.getParameter("com_pro_Content") == null
					|| request.getParameter("com_pro_Title").equals("") || request.getParameter("com_pro_Content").equals("")) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()"); //이전페이지로 복귀
				script.println("</script>");
			} else {
				c_p_DAO cpDAO = new c_p_DAO();
				int result = cpDAO.update(Com_pro_ID, request.getParameter("com_pro_Title"), request.getParameter("com_pro_Content"));
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글수정에 실패했습니다.')");
					script.println("history.back()"); //이전페이지로 복귀
					script.println("</script>");
				}
				else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'com_pro.jsp'");
					script.println("</script>");
				}
			}
		}
		
		
	%>
</body>
</html>