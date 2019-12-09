<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="user.UserDAO" %>
<%@ page import="message.Message_DAO" %>
<%@ page import="com_app.Com_app"%>
<%@ page import="com_app.Write_c_a_DAO"%>
<jsp:useBean id="comapp" class="com_app.Com_app" scope="page"/>
<jsp:setProperty name="comapp" property="userID"/>

<jsp:useBean id="message" class="message.Message" scope="page"/>
<jsp:setProperty name="message" property="title"/>
<jsp:setProperty name="message" property="content"/>
<jsp:setProperty name="message" property="receiveID"/>
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
		if (message.getTitle() == null || message.getContent() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()"); //이전페이지로 복귀
			script.println("</script>");
		} else {
			Message_DAO messageDAO = new Message_DAO();
			int result = messageDAO.write(message.getTitle(), userID, message.getContent(), message.getReceiveID());
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('쪽지를 보내지 못했습니다.')");
				script.println("history.back()"); //이전페이지로 복귀
				script.println("</script>");
			}
			else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'sendMessage.jsp'");
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