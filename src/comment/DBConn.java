package comment;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConn {
	public static Connection getMySqlConnection() {
		Connection conn = null;

		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "gkdl486";
			Class.forName("com.mysql.jdbc.Driver"); // mysql�� ������ �� �ְ� ���ִ� �Ű�ü ���̺귯��
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	public static void close(Connection conn) {
		try {
			if(conn != null)
				conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
}
