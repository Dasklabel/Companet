package pay;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import pay.Pay;

public class payDAO {
	private Connection conn; //�����ͺ��̽��� �����ϰ� ���ִ� ��ü
	private ResultSet rs;
	
	public payDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "gkdl486";
			Class.forName("com.mysql.jdbc.Driver"); //mysql�� ������ �� �ְ� ���ִ� �Ű�ü ���̺귯��
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int write(String name, String email, int tel, String addr, String postcode) {
		String SQL = "INSERT INTO pay VALUES(?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, name);
			pstmt.setString(2, email);
			pstmt.setInt(3, tel);
			pstmt.setString(4, addr);
			pstmt.setString(5, postcode);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
	
	public Pay getPay(String postcode) {
		String SQL = "SELECT * FROM pay WHERE postcode = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, postcode);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Pay pay = new Pay();
				pay.setName(rs.getString(1));
				pay.setEmail(rs.getString(2));
				pay.setTel(rs.getInt(3));
				pay.setAddr(rs.getString(4));
				pay.setPostcode(rs.getString(5));
				return pay;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
