package kr.cart.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.cart.vo.CartVO;
import kr.item.vo.ItemVO;
import kr.util.DBUtil;

public class CartDAO {
	//싱글턴 패턴 작성
	private static CartDAO instance = new CartDAO();
	
	public static CartDAO getInstance() {
		return instance;
	}
	
	private CartDAO () {}
	
	//찜 등록
	public void insertCart(CartVO cart)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			
			sql = "INSERT INTO cart (cart_num,mem_num,item_num,cart_regdate,cart_count) "
				+ "VALUES (cart_seq.nextval,?,?,SYSDATE,?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cart.getMem_num());
			pstmt.setInt(2, cart.getItem_num());
			pstmt.setInt(3, cart.getCart_count());
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//찜 목록
	public List<CartVO> getListCart(int mem_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<CartVO> list = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			
			sql = "SELECT * FROM cart JOIN item USING(item_num) "
				+ "WHERE mem_num=? ORDER BY item_num ASC";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, mem_num);
			
			rs = pstmt.executeQuery();
			list = new ArrayList<CartVO>();
			while(rs.next()) {
				CartVO cart = new CartVO();
				cart.setCart_num(rs.getInt("cart_num"));
				cart.setItem_num(rs.getInt("item_num"));
				cart.setMem_num(rs.getInt("mem_num"));
				cart.setCart_count(rs.getInt("cart_count"));
				
				ItemVO item = new ItemVO();
				item.setItem_name(rs.getString("item_name"));
				item.setItem_price(rs.getInt("item_price"));
				item.setItem_img1(rs.getString("item_img1"));
				item.setItem_content(rs.getString("item_content"));
				item.setDate_start(rs.getString("date_start"));
				item.setDate_end(rs.getString("date_end"));
				
				cart.setItemVO(item);
				list.add(cart);
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return list;
	}
	
	//찜 삭제
	public void deleteCart(int cart_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			
			sql = "DELETE FROM cart WHERE cart_num=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cart_num);
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
}
