package free_app;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import free_app.Free_app;

public class f_a_DAO {
	
	private Connection conn; //데이터베이스에 접근하게 해주는 객체
	private ResultSet rs;
	
	public f_a_DAO() {
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
	
	public int getNext() {
		String SQL = "SELECT free_app_ID FROM FREE_APP ORDER BY free_app_ID DESC";
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
	
	public int write(String free_app_Title, String userID, String free_app_Content) {
		String SQL = "INSERT INTO FREE_APP VALUES(?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, free_app_Title);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, free_app_Content);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public ArrayList<Free_app> getList(int pageNumber) {
		String SQL = "SELECT * FROM FREE_APP WHERE free_app_ID < ? AND free_app_Available = 1 ORDER BY free_app_ID DESC LIMIT 10";
		ArrayList<Free_app> list = new ArrayList<Free_app>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Free_app freeapp = new Free_app();
				freeapp.setFree_app_ID(rs.getInt(1));
				freeapp.setFree_app_Title(rs.getString(2));
				freeapp.setUserID(rs.getString(3));
				freeapp.setFree_app_Date(rs.getString(4));
				freeapp.setFree_app_Content(rs.getString(5));
				freeapp.setFree_app_Available(rs.getInt(6));
				list.add(freeapp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM free_app WHERE free_app_ID < ? AND free_app_Available = 1";
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
	
	public Free_app getFree_app(int free_app_ID) {
		String SQL = "SELECT * FROM free_app WHERE free_app_ID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, free_app_ID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Free_app freeapp = new Free_app();
				freeapp.setFree_app_ID(rs.getInt(1));
				freeapp.setFree_app_Title(rs.getString(2));
				freeapp.setUserID(rs.getString(3));
				freeapp.setFree_app_Date(rs.getString(4));
				freeapp.setFree_app_Content(rs.getString(5));
				freeapp.setFree_app_Available(rs.getInt(6));
				return freeapp;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int free_app_ID, String free_app_Title, String free_app_Content) {
		String SQL = "UPDATE FREE_APP SET free_app_Title = ?, free_app_Content = ? WHERE free_app_ID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, free_app_Title);
			pstmt.setString(2, free_app_Content);
			pstmt.setInt(3, free_app_ID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int delete(int free_app_ID) {
		String SQL = "UPDATE FREE_APP SET free_app_Available = 0 WHERE free_app_ID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, free_app_ID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
}
