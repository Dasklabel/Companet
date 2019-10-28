<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="free_pro.f_p_DAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="freepro" class="free_pro.Free_pro" scope="page"/>
<jsp:setProperty name="freepro" property="free_pro_Title"/>
<jsp:setProperty name="freepro" property="free_pro_Content"/>
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
		if (freepro.getFree_pro_Title() == null || freepro.getFree_pro_Content() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()"); //이전페이지로 복귀
			script.println("</script>");
		} else {
			f_p_DAO fpDAO = new f_p_DAO();
			int result = fpDAO.write(freepro.getFree_pro_Title(), userID, freepro.getFree_pro_Content());
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
				script.println("location.href = 'free_pro.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>