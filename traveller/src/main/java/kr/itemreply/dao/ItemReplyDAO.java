package kr.itemreply.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.itemreply.vo.ItemReplyVO;
import kr.util.DBUtil;
import oracle.jdbc.proxy.annotation.Pre;

public class ItemReplyDAO {
	
	//싱글턴 패턴
		private static ItemReplyDAO instance = new ItemReplyDAO();
		public static ItemReplyDAO getInstance() {
			return instance;
		}
		private ItemReplyDAO() {}
	
	
	
	
	
	public void insertReply(ItemReplyVO vo)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			//커넥션풀로부터 커넥션 객체 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "INSERT INTO item_reply (item_renum, item_num, mem_num, item_recontent, item_redate, item_reip, item_st1, item_case, user_id) "
					+ " VALUES(item_renum_seq.nextval, ?, ?, ?,SYSDATE, ?, ?, ?,?)";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, vo.getItem_num());
			pstmt.setInt(2, vo.getMem_num());
			pstmt.setString(3, vo.getItem_recontent());
			pstmt.setString(4, vo.getItem_reip());
			pstmt.setString(5, vo.getItem_st1());
			pstmt.setString(6, vo.getItem_case());
			pstmt.setString(7, vo.getUser_id());
			//SQL문 실행
			pstmt.executeUpdate();
			
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
	}
	public List<ItemReplyVO> getItemReply(String item_st1, String item_case) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		List<ItemReplyVO> list = null;
		
		try {
			//커넥션풀로부터 커넥션 객체 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "SELECT * FROM item_reply WHERE item_st1=? AND item_case=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setString(1, item_st1);
			pstmt.setString(2, item_case);
			//SQL문 실행
			rs = pstmt.executeQuery();
			while(rs.next()) {
				list = new ArrayList<ItemReplyVO>();
				ItemReplyVO vo = new ItemReplyVO();
				vo.setItem_renum(rs.getInt("item_renum"));
				vo.setItem_num(rs.getInt("item_num"));
				vo.setMem_num(rs.getInt("mem_num"));
				vo.setItem_recontent(rs.getString("item_recontent"));
				vo.setItem_redate(rs.getDate("item_redate"));
				vo.setItem_reip(rs.getString("item_reip"));
				vo.setItem_st1(rs.getString("item_st1"));
				vo.setItem_case(rs.getString("item_case"));
				vo.setUser_id(rs.getString("user_id"));
				
				list.add(vo);
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return list;
	}
	public int getReplyUsed(int mem_num, int item_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		ResultSet rs = null;
		int result = 0;
		
		try {
			//커넥션 풀로부터 커넥션 객체 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "SELECT * FROM item_reply WHERE mem_num=? AND item_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, mem_num);
			pstmt.setInt(2, item_num);
			//SQL문 실행
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result=1;
			}
		
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return result;
	}
	
	//후기글 개수 검색
	public int getItemReplyCount(String user_id)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		
		try {
			conn = DBUtil.getConnection();
			
			sql = "SELECT COUNT(*) FROM item_reply WHERE user_id=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return count;
	}
	
	//후기글 불러오기
	public List<ItemReplyVO> getMyItemReply(String user_id)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ItemReplyVO> list = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			
			sql = "SELECT * FROM item_reply WHERE user_id=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, user_id);
			rs = pstmt.executeQuery();
			list = new ArrayList<ItemReplyVO>();
			while(rs.next()) {
				ItemReplyVO ireply = new ItemReplyVO();
				ireply.setItem_num(rs.getInt("item_num"));
				ireply.setItem_recontent(rs.getString("item_recontent"));
				ireply.setItem_redate(rs.getDate("item_redate"));
				ireply.setItem_num(rs.getInt("item_num"));
				ireply.setItem_renum(rs.getInt("item_renum"));
				
				list.add(ireply);
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return list;
	}
}
