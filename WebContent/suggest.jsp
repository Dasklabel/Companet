<%@page import="java.util.Iterator" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.Collections" %>
<%@page import="java.util.List" %>
<%@page contentType = "text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	//데이터베이스에 등록된 인기 연관 검색어라는 가정(실제로 쓸 땐 DB연동)
	String[] keywords = {"ajax", "Ajax", "Ajax 실전 프로그래밍", "AZA", "AZERA", "자수", "자전거",
						"자바 프로그래밍", "ABC마트", "APPLE"};

	//사용자가 입력한 단어의 연관 제시어 검색해 리스트 반환
	public List<String> search(String userKeyword) {
		if(userKeyword == null || userKeyword.equals("")) {
			return null;
		}
		List<String> lists = new ArrayList<String>();
		for(int i = 0; i < keywords.length; i++) {
			if(keywords[i].startsWith(userKeyword)) {
				lists.add(keywords[i]);
			}
		}
		return lists;
	}
%>
<%
	//파라미터를 읽어온 뒤 연관제시어 찾기
	String userKeyword = request.getParameter("userKeyword");
	List<String> keywordList = search(userKeyword);
	
	//키워드 갯수와 키워드 단어들을 |로 구분
	out.print(keywordList.size());
	out.print("|");
	Iterator<String> lt = keywordList.iterator();
	while(lt.hasNext()) {
		String value = (String)lt.next();
		out.print(value);
		if(keywordList.size() - 1 > 0) {
			out.print(";");
		}
	}
%>