<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com_app.Write_c_a_DAO" %>
<%@ page import="java.io.PrintWriter" %>
<%-- <%@ page import="file.FileDAO" %>
<%@ page import="java.io.File" %> --%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="comapp" class="com_app.Com_app" scope="page"/>
<jsp:setProperty name="comapp" property="com_app_Title"/>
<jsp:setProperty name="comapp" property="com_app_Content"/>
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
		if (comapp.getCom_app_Title() == null || comapp.getCom_app_Content() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()"); //이전페이지로 복귀
			script.println("</script>");
		} else {
			Write_c_a_DAO wcaDAO = new Write_c_a_DAO();
			int result = wcaDAO.write(comapp.getCom_app_Title(), userID, comapp.getCom_app_Content());
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
				script.println("location.href = 'com_app.jsp'");
				script.println("</script>");
			}
		}
		
		/* String directory = request.getServletContext().getRealPath("/upload/");
		
		int maxsize = 100*1024*1024;
		String encoding = "UTF-8";
		
		MultipartRequest multipartRequest = new MultipartRequest(request, directory, maxsize, encoding, new DefaultFileRenamePolicy());
		
		String fileName = multipartRequest.getOriginalFileName("file");
		String fileRealName = multipartRequest.getFilesystemName("file");
		
		new FileDAO().upload(fileName, fileRealName);
		out.write("파일명: " +fileName + "<br>");
		out.write("실제 파일명: " +fileRealName + "<br>");	 */
	
	%>
</body>
</html>