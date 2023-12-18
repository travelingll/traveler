package kr.recommend.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.item.vo.ItemVO;
import kr.util.DBUtil;

public class RecommendDAO {
private static RecommendDAO instance = new RecommendDAO();
	
	public static RecommendDAO getInstance() {
		return instance;
	}
	
	private RecommendDAO(){};
	
	public int getRecommendCount(String item_st1)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		
		try {
			conn = DBUtil.getConnection();
			
			sql = "SELECT COUNT(*) FROM item WHERE item_st1=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, item_st1);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally{
			DBUtil.getConnection();
		}
		
		return count;
	}
	
	public List<ItemVO> getRecommendList(int start,int end,String item_st1)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		List<ItemVO> list = null;
		
		try {
			conn = DBUtil.getConnection();
			
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM "
				+ "(SELECT * FROM item WHERE item_st1=? "
				+ "ORDER BY item_num ASC)a) WHERE rnum>=? AND rnum <=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, item_st1);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			list = new ArrayList<ItemVO>();
			while(rs.next()) {
				ItemVO item = new ItemVO();
				item.setItem_num(rs.getInt("item_num"));
				item.setItem_name(rs.getString("item_name"));
				item.setItem_content(rs.getString("item_content"));
				item.setItem_price(rs.getInt("item_price"));
				item.setItem_img1(rs.getString("item_img1"));
				item.setItem_img2(rs.getString("item_img2"));
				item.setItem_img3(rs.getString("item_img3"));
				item.setItem_img4(rs.getString("item_img4"));
				item.setItem_img5(rs.getString("item_img5"));
				item.setItem_img6(rs.getString("item_img6"));
				item.setItem_st1(rs.getString("item_st1"));
				item.setItem_st2(rs.getString("item_st2"));
				item.setItem_st3(rs.getString("item_st3"));
				item.setStatus(rs.getString("status"));
				item.setDate_start(rs.getString("date_start"));
				item.setDate_end(rs.getString("date_end"));
				item.setReg_date(rs.getDate("reg_date"));
				item.setQuantity(rs.getInt("quantity"));
				item.setItem_case(rs.getString("item_case"));
				
				list.add(item);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return list;
	}
}
