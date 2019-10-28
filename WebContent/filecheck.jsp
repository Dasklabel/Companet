<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("utf-8");
	String filename1 = request.getParameter("filename1");
	String filename2 = request.getParameter("filename2");
	String filename3 = request.getParameter("filename3");
%>
<body>
	<a href="download.jsp?fileName=<%=filename1%>"><%=filename1%></a><br/>
	<a href="download.jsp?fileName=<%=filename2%>"><%=filename2%></a><br/>
	<a href="download.jsp?fileName=<%=filename3%>"><%=filename3%></a><br/>
</body>
</html>