package comment;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

public class C_C_A_Service {
	private static C_C_A_Service service = new C_C_A_Service();
	private C_C_A_Service() {}
	public static C_C_A_Service getInstance() {
		return service;
	}
	
	public boolean update(Comment_c_a vo) {
		Connection conn = DBConn.getMySqlConnection();
		C_C_A_DAO ccaDAO = C_C_A_DAO.getInstance();
		ccaDAO.setConnection(conn);
		
		boolean flag = false;
		try {
			Comment_c_a res = ccaDAO.getOne(vo.getId());
			if(res.getPassword().equals(vo.getPassword())) {
				ccaDAO.update(vo);
				flag = true;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		DBConn.close(conn);
		return flag;
	}
	
	public boolean delete(int id, String password) {
		Connection conn = DBConn.getMySqlConnection();
		C_C_A_DAO ccaDAO = C_C_A_DAO.getInstance();
		ccaDAO.setConnection(conn);
		
		boolean flag = false;
		try {
			Comment_c_a res = ccaDAO.getOne(id);
			if(res.getPassword().equals(password)) {
				ccaDAO.delete(id);
				flag = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		DBConn.close(conn);
		return flag;
	}
	
	
	public void insert(Comment_c_a vo) {
		Connection conn = DBConn.getMySqlConnection();
		C_C_A_DAO ccaDAO = C_C_A_DAO.getInstance();
		ccaDAO.setConnection(conn);
		
		try {
			ccaDAO.insert(vo);
		} catch(SQLException e) {
			e.printStackTrace();
		}
		DBConn.close(conn);
	}
	
	public int getCount(int id) {
		Connection conn = DBConn.getMySqlConnection();
		C_C_A_DAO ccaDAO = C_C_A_DAO.getInstance();
		ccaDAO.setConnection(conn);
		
		int cnt = 0;
		try {
			cnt = ccaDAO.getCount(id);
		} catch(SQLException e) {
			e.printStackTrace();
		}
		DBConn.close(conn);
		return cnt;
	}
	
	public ArrayList<Comment_c_a> getList(int ref) {
		ArrayList<Comment_c_a> list = null;
		Connection conn = DBConn.getMySqlConnection();
		C_C_A_DAO ccaDAO = C_C_A_DAO.getInstance();
		ccaDAO.setConnection(conn);
		
		try {
			list = ccaDAO.getList(ref);
		} catch(SQLException e){
			e.printStackTrace();
		}
		DBConn.close(conn);
		return list;
	}
}
