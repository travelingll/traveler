package kr.money.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import kr.money.dao.MoneyDAO;
import kr.money.vo.MoneyVO;
import kr.util.DBUtil;

public class MoneyDAO {
	//싱글턴 패턴
	private static MoneyDAO instance = new MoneyDAO();
	public static MoneyDAO getInstance() {
		return instance;
	}
	private MoneyDAO() {}
	
	public MoneyVO getMoney(int mem_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MoneyVO money = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM money WHERE mem_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mem_num);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				money = new MoneyVO();
				money.setMem_num(rs.getInt("mem_num"));
				money.setSm_num(rs.getInt("sm_num"));
				money.setSaved_money(rs.getString("saved_money"));
				money.setSm_content(rs.getString("sm_content"));
				money.setSm_date(rs.getDate("sm_date"));
			}
		}catch(Exception e){
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return money;
	}
}
