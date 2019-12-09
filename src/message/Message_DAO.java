package message;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import message.Message;
import user.User;

public class Message_DAO {
	private Connection conn; //데이터베이스에 접근하게 해주는 객체
	private ResultSet rs;
	
	public Message_DAO() {
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
		String SQL = "SELECT ID FROM MESSAGE ORDER BY ID DESC";
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
	
	public String getReceiveID() { //다음글 번호
		String SQL = "SELECT userID FROM com_app WHERE com_app_id = ?";
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
	
	public int write(String title, String userID, String content, String receiveID) {
		String SQL = "INSERT INTO MESSAGE VALUES(?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, title);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, content);
			pstmt.setString(6, receiveID);
			pstmt.setInt(7, 1);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public ArrayList<Message> getReceive_List(int pageNumber) {
		String SQL = "SELECT * FROM MESSAGE WHERE ID < ? AND Available = 1 ORDER BY ID DESC LIMIT 10";
		ArrayList<Message> list = new ArrayList<Message>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Message message = new Message();
				message.setID(rs.getInt(1));
				message.setTitle(rs.getString(2));
				message.setUserID(rs.getString(3));
				message.setDate(rs.getString(4));
				message.setContent(rs.getString(5));
				message.setReceiveID(rs.getString(6));
				message.setAvailable(rs.getInt(7));
				list.add(message);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Message> getSend_List(int pageNumber) {
		String SQL = "SELECT * FROM MESSAGE WHERE ID < ? AND Available = 1 ORDER BY ID DESC LIMIT 10";
		ArrayList<Message> list = new ArrayList<Message>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Message message = new Message();
				message.setID(rs.getInt(1));
				message.setTitle(rs.getString(2));
				message.setUserID(rs.getString(3));
				message.setDate(rs.getString(4));
				message.setContent(rs.getString(5));
				message.setReceiveID(rs.getString(6));
				message.setAvailable(rs.getInt(7));
				list.add(message);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Message> getS_List(int pageNumber) {
		String SQL = "SELECT id, Title, userID, date, Content, ReceiveID FROM user u, message m WHERE u.userID = m.userID DESC LIMIT 10";
		ArrayList<Message> list = new ArrayList<Message>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Message message = new Message();
				message.setID(rs.getInt(1));
				message.setTitle(rs.getString(2));
				message.setUserID(rs.getString(3));
				message.setDate(rs.getString(4));
				message.setContent(rs.getString(5));
				message.setReceiveID(rs.getString(6));
				message.setAvailable(rs.getInt(7));
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserPassword(rs.getString(2));
				user.setUserName(rs.getString(3));
				user.setUserCompany(rs.getString(4));
				user.setUserEmail(rs.getString(5));
				user.setUserPhone(rs.getString(6));
				list.add(message);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM MESSAGE WHERE ID < ? AND Available = 1";
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
	
	public Message getMessage(int ID) {
		String SQL = "SELECT * FROM MESSAGE WHERE ID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, ID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Message message = new Message();
				message.setID(rs.getInt(1));
				message.setTitle(rs.getString(2));
				message.setUserID(rs.getString(3));
				message.setDate(rs.getString(4));
				message.setContent(rs.getString(5));
				message.setReceiveID(rs.getString(6));
				message.setAvailable(rs.getInt(7));
				return message;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int delete(int ID) {
		String SQL = "UPDATE MESSAGE SET Available = 0 WHERE ID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, ID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
}
