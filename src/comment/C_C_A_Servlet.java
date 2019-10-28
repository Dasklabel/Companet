package comment;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/comment.do")
public class C_C_A_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public C_C_A_Servlet() {
		super();
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); // 사용자 입력문자 인코딩
		
		response.setContentType("text/html; charset=UTF-8"); //사용자 응답 웹페이지 문자 인코딩
		PrintWriter out = response.getWriter();
		
		int exe = Integer.parseInt(request.getParameter("exe"));
		int id = Integer.parseInt(request.getParameter("id"));
		int ref = Integer.parseInt(request.getParameter("ref"));
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		String content = request.getParameter("content");
		
		int currentPage = Integer.parseInt(request.getParameter("page"));
		Comment_c_a vo = new Comment_c_a();
		vo.setId(id);
		vo.setRef(ref);
		vo.setContent(content);
		vo.setName(name);
		vo.setPassword(password);
		
		C_C_A_Service comment = C_C_A_Service.getInstance();
		
		out.print("<script>");
		if(exe == 1) { //댓글 새로 추가
			comment.insert(vo);
		} else if(exe == 2) { //댓글 수정
			boolean res = comment.update(vo);
			if(res) {
				out.print("alert('댓글 수정 완료')");
			} else {
				out.print("alert('글 비밀번호 오류')");
			}
		} else { //댓글 삭제(exe == 3)
			boolean res = comment.delete(id, password);
			if(res) {
				out.print("alert('댓글 삭제 완료')");
			} else {
				out.print("alert('글 비밀번호 오류')");
			}
		}
		
		out.print("location.href='select.do?id=" + ref + "&page=" + currentPage + "&exec=comment'");
		out.print("</script>");
	}
}
