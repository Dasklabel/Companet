package free_pro;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import free_app.Free_app;

public class f_p_DAO {
	
	private Connection conn; //데이터베이스에 접근하게 해주는 객체
	private ResultSet rs;
	
	public f_p_DAO() {
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
		String SQL = "SELECT free_pro_ID FROM FREE_PRO ORDER BY free_pro_ID DESC";
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
	
	public int write(String free_pro_Title, String userID, String free_pro_Content) {
		String SQL = "INSERT INTO FREE_PRO VALUES(?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, free_pro_Title);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, free_pro_Content);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public ArrayList<Free_pro> getList(int pageNumber) {
		String SQL = "SELECT * FROM FREE_PRO WHERE free_pro_ID < ? AND free_pro_Available = 1 ORDER BY free_pro_ID DESC LIMIT 10";
		ArrayList<Free_pro> list = new ArrayList<Free_pro>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Free_pro freepro = new Free_pro();
				freepro.setFree_pro_ID(rs.getInt(1));
				freepro.setFree_pro_Title(rs.getString(2));
				freepro.setUserID(rs.getString(3));
				freepro.setFree_pro_Date(rs.getString(4));
				freepro.setFree_pro_Content(rs.getString(5));
				freepro.setFree_pro_Available(rs.getInt(6));
				list.add(freepro);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM FREE_PRO WHERE free_pro_ID < ? AND free_pro_Available = 1";
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
	
	public Free_pro getFree_pro(int free_pro_ID) {
		String SQL = "SELECT * FROM FREE_PRO WHERE free_pro_ID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, free_pro_ID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Free_pro freepro = new Free_pro();
				freepro.setFree_pro_ID(rs.getInt(1));
				freepro.setFree_pro_Title(rs.getString(2));
				freepro.setUserID(rs.getString(3));
				freepro.setFree_pro_Date(rs.getString(4));
				freepro.setFree_pro_Content(rs.getString(5));
				freepro.setFree_pro_Available(rs.getInt(6));
				return freepro;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int free_pro_ID, String free_pro_Title, String free_pro_Content) {
		String SQL = "UPDATE FREE_PRO SET free_pro_Title = ?, free_pro_Content = ? WHERE free_pro_ID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, free_pro_Title);
			pstmt.setString(2, free_pro_Content);
			pstmt.setInt(3, free_pro_ID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int delete(int free_pro_ID) {
		String SQL = "UPDATE FREE_PRO SET free_pro_Available = 0 WHERE free_pro_ID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, free_pro_ID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
}
