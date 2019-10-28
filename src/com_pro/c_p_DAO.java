package com_pro;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com_pro.Com_pro;

public class c_p_DAO {
	
	private Connection conn; //데이터베이스에 접근하게 해주는 객체
	private ResultSet rs;
	
	public c_p_DAO() {
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
		String SQL = "SELECT com_pro_ID FROM COM_PRO ORDER BY com_pro_ID DESC";
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
	
	public int write(String com_pro_Title, String userID, String com_pro_Content) {
		String SQL = "INSERT INTO COM_PRO VALUES(?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, com_pro_Title);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, com_pro_Content);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public ArrayList<Com_pro> getList(int pageNumber) {
		String SQL = "SELECT * FROM COM_PRO WHERE com_pro_ID < ? AND com_pro_Available = 1 ORDER BY com_pro_ID DESC LIMIT 10";
		ArrayList<Com_pro> list = new ArrayList<Com_pro>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Com_pro compro = new Com_pro();
				compro.setCom_pro_ID(rs.getInt(1));
				compro.setCom_pro_Title(rs.getString(2));
				compro.setUserID(rs.getString(3));
				compro.setCom_pro_Date(rs.getString(4));
				compro.setCom_pro_Content(rs.getString(5));
				compro.setCom_pro_Available(rs.getInt(6));
				list.add(compro);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM com_pro WHERE com_pro_ID < ? AND com_pro_Available = 1";
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
	
	public Com_pro getCom_pro(int com_pro_ID) {
		String SQL = "SELECT * FROM com_pro WHERE com_pro_ID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, com_pro_ID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Com_pro compro = new Com_pro();
				compro.setCom_pro_ID(rs.getInt(1));
				compro.setCom_pro_Title(rs.getString(2));
				compro.setUserID(rs.getString(3));
				compro.setCom_pro_Date(rs.getString(4));
				compro.setCom_pro_Content(rs.getString(5));
				compro.setCom_pro_Available(rs.getInt(6));
				return compro;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int com_pro_ID, String com_pro_Title, String com_pro_Content) {
		String SQL = "UPDATE COM_PRO SET com_pro_Title = ?, com_pro_Content = ? WHERE com_pro_ID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, com_pro_Title);
			pstmt.setString(2, com_pro_Content);
			pstmt.setInt(3, com_pro_ID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public int delete(int com_pro_ID) {
		String SQL = "UPDATE COM_PRO SET com_pro_Available = 0 WHERE com_pro_ID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, com_pro_ID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
}
