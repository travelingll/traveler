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
	
	//개수
	public int getRecommendCount(int mem_num) throws Exception {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;
	    int count = 0;
	    int cnt = 0;

	    try {
	        conn = DBUtil.getConnection();

	        // Get style values from the member_detail table
	        String[] style1 = getStyleArray("style1", mem_num);
	        String[] style2 = getStyleArray("style2", mem_num);
	        String[] style3 = getStyleArray("style3", mem_num);

	        // Construct SQL query to get recommended items count
	        sql = "SELECT COUNT(*) FROM item WHERE ";
	        
	        for (int i = 0; i < style1.length; i++) {
	            sql += "item_st1=? OR ";
	        }
	        for (int i = 0; i < style2.length; i++) {
	            sql += "item_st2=? OR ";
	        }
	        for (int i = 0; i < style3.length - 1; i++) {
	        	sql += "item_st3=? OR ";
	        }
	        sql += "item_st3=?";

	        pstmt = conn.prepareStatement(sql);
	        
	        for (String style : style1) {
	            pstmt.setString(++cnt, style);
	        }
	        for (String style : style2) {
	            pstmt.setString(++cnt, style);
	        }
	        for (String style : style3) {
	            pstmt.setString(++cnt, style);
	        }

	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            count = rs.getInt(1);
	        }
	    } catch (Exception e) {
	        throw new Exception(e);
	    } finally {
	        DBUtil.executeClose(rs, pstmt, conn);
	    }

	    return count;
	}

	
	public int getRecommendCount(String item_st1,String item_st2,String item_st3)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		
		try {
			conn = DBUtil.getConnection();
			
			sql = "SELECT COUNT(*) FROM item WHERE item_st1=? OR item_st2=? OR item_st3=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, item_st1);
			pstmt.setString(2, item_st2);
			pstmt.setString(3, item_st3);
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
	
	public List<ItemVO> getRecommendList(int start,int end,String item_st1,String item_st2,String item_st3)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		List<ItemVO> list = null;
		
		try {
			conn = DBUtil.getConnection();
			
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM "
				+ "(SELECT * FROM item WHERE item_st1=? or item_st2=? or item_st3=? "
				+ "ORDER BY item_num ASC)a) WHERE rnum>=? AND rnum <=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, item_st1);
			pstmt.setString(2, item_st2);
			pstmt.setString(3, item_st3);
			pstmt.setInt(4, start);
			pstmt.setInt(5, end);
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
	
	public String[] getStyleArray(String styleColumn,int mem_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String[] styles = null;
		
		try {
			conn = DBUtil.getConnection();
			
			sql = "SELECT " + styleColumn + " FROM member_detail WHERE mem_num=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mem_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String styleValues = rs.getString(styleColumn);
				if(styleValues != null && !styleValues.isEmpty()) {
					styles = styleValues.split(",");
				}
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return styles;
	}
	
	//아이템 추천 메서드
	public List<ItemVO> getRecommendedItems(int start, int end, int mem_num) throws Exception {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;
	    List<ItemVO> list = null;
	    int cnt = 0;

	    try {
	        conn = DBUtil.getConnection();

	        String[] style1 = getStyleArray("style1", mem_num);
	        String[] style2 = getStyleArray("style2", mem_num);
	        String[] style3 = getStyleArray("style3", mem_num);

	        sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM "
	            + "(SELECT * FROM item WHERE ";

	        for (int i = 0; i < style1.length; i++) {
	            sql += "item_st1=? OR ";
	        }
	        for (int i = 0; i < style2.length; i++) {
	            sql += "item_st2=? OR ";
	        }
	        for (int i = 0; i < style3.length - 1; i++) {
	            sql += "item_st3=? OR ";
	        }
	        sql += "item_st3=? ORDER BY item_num ASC)a) WHERE rnum>=? AND rnum <=?";

	        pstmt = conn.prepareStatement(sql);
	        
	        for (String style : style1) {
	            pstmt.setString(++cnt, style);
	        }
	        for (String style : style2) {
	            pstmt.setString(++cnt, style);
	        }
	        for (String style : style3) {
	            pstmt.setString(++cnt, style);
	        }
	        pstmt.setInt(++cnt, start);
	        pstmt.setInt(++cnt, end);

	        rs = pstmt.executeQuery();
	        list = new ArrayList<>();

	        while (rs.next()) {
	            ItemVO item = new ItemVO();
	            item.setItem_num(rs.getInt("item_num"));
				item.setItem_name(rs.getString("item_name"));
				item.setItem_content(rs.getString("item_content"));
				item.setItem_price(rs.getInt("item_price"));
				item.setItem_img1(rs.getString("item_img1"));
				item.setDate_start(rs.getString("date_start"));
				item.setDate_end(rs.getString("date_end"));
				item.setReg_date(rs.getDate("reg_date"));
				item.setQuantity(rs.getInt("quantity"));
				item.setItem_st1(rs.getString("item_st1"));
				item.setItem_st2(rs.getString("item_st2"));
				item.setItem_st3(rs.getString("item_st3"));

	            list.add(item);
	        }
	    } catch (Exception e) {
	        throw new Exception(e);
	    } finally {
	        DBUtil.executeClose(rs, pstmt, conn);
	    }

	    return list;
	}
	
	// RecommendDAO 클래스에 메서드 추가
	public ItemVO getRepresentativeItemByStyle(String[] styleValues) throws Exception {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    String sql = null;
	    ItemVO item = null;
	    int cnt = 0;

	    try {
	        conn = DBUtil.getConnection();

	    	sql = "SELECT * FROM item WHERE (";
	    	
	        for (int i = 0; i < styleValues.length; i++) {
	            sql += "item_st1 LIKE ? OR item_st2 LIKE ? OR item_st3 LIKE ?";
	            if (i < styleValues.length - 1) {
	              sql += " OR ";
	            }
	        }
	      	sql += ") ORDER BY item_price DESC";
	      	
	        pstmt = conn.prepareStatement(sql);

	        for (String style : styleValues) {
	            pstmt.setString(++cnt, "%" + style + "%");
	            pstmt.setString(++cnt, "%" + style + "%");
	            pstmt.setString(++cnt, "%" + style + "%");
	        }

	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	            item = new ItemVO();
	            item.setItem_num(rs.getInt("item_num"));
				item.setItem_name(rs.getString("item_name"));
				item.setItem_content(rs.getString("item_content"));
				item.setItem_price(rs.getInt("item_price"));
				item.setItem_img1(rs.getString("item_img1"));
				item.setDate_start(rs.getString("date_start"));
				item.setDate_end(rs.getString("date_end"));
				item.setReg_date(rs.getDate("reg_date"));
				item.setQuantity(rs.getInt("quantity"));
				item.setItem_st1(rs.getString("item_st1"));
				item.setItem_st2(rs.getString("item_st2"));
				item.setItem_st3(rs.getString("item_st3"));
	        }
	    } catch (Exception e) {
	        throw new Exception(e);
	    } finally {
	        DBUtil.executeClose(rs, pstmt, conn);
	    }

	    return item;
	}

}


