package kr.money.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.money.dao.MoneyDAO;
import kr.money.vo.MoneyVO;
import kr.util.DBUtil;
import oracle.net.aso.l;

public class MoneyDAO {
	//싱글턴 패턴
	private static MoneyDAO instance = new MoneyDAO();
	public static MoneyDAO getInstance() {
		return instance;
	}
	private MoneyDAO() {}
	
	public List<MoneyVO> getMoney(int mem_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<MoneyVO> list = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM money WHERE mem_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mem_num);
			rs = pstmt.executeQuery();
			list = new ArrayList<MoneyVO>();
			while(rs.next()) {
				MoneyVO money = new MoneyVO();
				money.setMem_num(rs.getInt("mem_num"));
				money.setSm_num(rs.getInt("sm_num"));
				money.setSaved_money(rs.getString("saved_money"));
				money.setSm_content(rs.getString("sm_content"));
				money.setSm_date(rs.getDate("sm_date"));
				
				list.add(money);
			}
		}catch(Exception e){
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return list;
	}
	public int getMoneyCount(int mem_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		
		try {
			//커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "SELECT COUNT (*) FROM money JOIN member USING(mem_num) WHERE mem_num=?";
			//PrepardStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mem_num);
			//SQL문 실행
			rs = pstmt.executeQuery();
			while(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return count;
	}
	
	public int getTotalByMem_num(int mem_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int total = 0;
		
		try {
			conn = DBUtil.getConnection();
			
			sql = "SELECT SUM(saved_money) FROM money WHERE mem_num=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mem_num);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				total = rs.getInt(1);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return total;
	}
	
	//이벤트 참여 체크 메서드
	public boolean checkEvent(int mem_num, String sm_content) throws Exception {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean check = false; //이벤트 미참여시 false
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM money WHERE mem_num=? AND sm_content=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mem_num);
			pstmt.setString(2, sm_content);
			rs = pstmt.executeQuery();
			
			if(rs.next()) check=true; //이벤트를 참여했을 경우 true
			
		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return check;
	}

}
