package comment;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import comment.Comment_c_a;

public class C_C_A_DAO {
	
	private Connection conn; //데이터베이스에 접근하게 해주는 객체
	private ResultSet rs;

	public C_C_A_DAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "gkdl486";
			Class.forName("com.mysql.jdbc.Driver"); //mysql에 접속할 수 있게 해주는 매개체 라이브러리
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	public int getNext() { //다음글 번호
		String SQL = "SELECT id FROM Comment_c_a ORDER BY id DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; //현재가 첫번째 게시물인경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	public int write(String password, String content) {
		String SQL = "INSERT INTO comment_c_a VALUES(?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			/* pstmt.setString(2, name); */
			pstmt.setString(2, password);
			pstmt.setString(3, content);
			pstmt.setString(4, getDate());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	public ArrayList<Comment_c_a> getList(int pageNumber) {
		String SQL = "SELECT * FROM Comment_c_a WHERE id < ? ORDER BY id DESC LIMIT 10";
		ArrayList<Comment_c_a> list = new ArrayList<Comment_c_a>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Comment_c_a cca = new Comment_c_a();
				cca.setId(rs.getInt(1));
				cca.setName(rs.getString(2));
				cca.setPassword(rs.getString(3));
				cca.setContent(rs.getString(4));
				cca.setDate(rs.getString(5));
				cca.setRef(rs.getInt(6));
				list.add(cca);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM Comment_c_a WHERE id < ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public Comment_c_a getC_C_A(int id) {
		String sql = "select * from Comment_c_a where id = ?";
		try{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			if(rs.next()) {
				Comment_c_a cca = new Comment_c_a();
				cca.setId(rs.getInt(1));
				cca.setName(rs.getString(2));
				cca.setPassword(rs.getString(3));
				cca.setContent(rs.getString(4));
				cca.setDate(rs.getString(5));
				cca.setRef(rs.getInt(6));
				return cca;
			}		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public int update(String name, String password, String content) {
		String sql = "update comment_c_a set name = ?, content = ? where id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setString(2, password);
			pstmt.setString(3, content);
			return pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}

	public int delete(int id) {
		String SQL = "UPDATE Comment_c_a WHERE id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, id);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	/*
	 * https://kimhyun2017.tistory.com/113
	 */
}
