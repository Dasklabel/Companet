package comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com_app.Com_app;

public class C_C_A_DAO {
	private static C_C_A_DAO ccaDAO = new C_C_A_DAO();
	private C_C_A_DAO() {}
	public static C_C_A_DAO getInstance() {
		return ccaDAO;
	}
	private Connection conn; //데이터베이스에 접근하게 해주는 객체
	private ResultSet rs;
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public Comment_c_a getOne(int id) throws SQLException {
		Comment_c_a vo = new Comment_c_a();
		String sql = "select * from comment_c_a where id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, id);
		ResultSet rs = pstmt.executeQuery();
		rs.next();
		
		vo.setId(rs.getInt("id"));
		vo.setName(rs.getString("name"));
		vo.setPassword(rs.getString("password"));
		vo.setContent(rs.getString("content"));
		vo.setDate(rs.getDate("date"));
		vo.setRef(rs.getInt("ref"));
		pstmt.close();
		return vo;
	}
	
	public void update(Comment_c_a vo) throws SQLException {
		String sql = "update comment_c_a set name = ?, content = ? where id = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, vo.getName());
		pstmt.setString(2, vo.getContent());
		pstmt.setInt(3, vo.getId());
		pstmt.execute();
		pstmt.close();
	}
	
	public void delete(int id) throws SQLException {
		String sql = "delete from comment_c_a where id= ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, id);
		pstmt.execute();
		pstmt.close();
	}
	
	public void insert(Comment_c_a vo) throws SQLException {
		String sql = "insert into comment_c_a(name, password, content, ref) values (?,?,?,?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, vo.getName());
		pstmt.setString(2, vo.getPassword());
		pstmt.setString(3, vo.getContent());
		pstmt.setInt(4, vo.getRef());
		pstmt.execute();
		pstmt.close();
	}
	
	public int getCount(int id) throws SQLException {
		String sql = "select count(*) from comment_c_a where ref = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, id);
		ResultSet rs = pstmt.executeQuery();
		int cnt = 0;
		if (rs.next()) {
			cnt = rs.getInt(1);
		}
		pstmt.close();
		return cnt;
	}
	
	public ArrayList<Comment_c_a> getList(int ref) throws SQLException {
		ArrayList<Comment_c_a> list = new ArrayList<>();
		
		String sql = "select * from comment_c_a where ref = ? order by id desc";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, ref);
		ResultSet rs = pstmt.executeQuery();
		
		if(rs.next()) {
			do {
				Comment_c_a vo = new Comment_c_a();
				vo.setId(rs.getInt("id"));
				vo.setRef(rs.getInt("ref"));
				vo.setName(rs.getString("name"));
				vo.setPassword(rs.getString("password"));
				vo.setContent(rs.getString("content"));
				vo.setDate(rs.getDate("date"));
				list.add(vo);
			} while (rs.next());
		}
		pstmt.close();
		return list;
	}
	
	public Comment_c_a getC_C_A(int id) {
		String SQL = "SELECT * FROM comment_c_a WHERE ID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Comment_c_a cca = new Comment_c_a();
				cca.setId(rs.getInt(1));
				cca.setName(rs.getString(2));
				cca.setPassword(rs.getString(3));
				cca.setContent(rs.getString(4));
				cca.setDate(rs.getDate(5));
				cca.setRef(rs.getInt(6));
				return cca;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	/*
	 * https://kimhyun2017.tistory.com/113
	 */
}
