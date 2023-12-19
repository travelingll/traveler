package kr.order.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import kr.order.vo.OrderDetailVO;
import kr.order.vo.OrderVO;
import kr.util.DBUtil;

public class OrderDAO {
	
	//싱글턴 패턴
	private static OrderDAO instance = new OrderDAO();
	
	public static OrderDAO getInstance() {
		return instance;
	}
	
	private OrderDAO() {}
	
	
	/*-----사용자-----*/
	//예약하기(order,order detail insert)
	public void insertOrder(OrderVO order, List<OrderDetailVO> detailList) throws Exception {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null;
		PreparedStatement pstmt4 = null;
		PreparedStatement pstmt5 = null;
		ResultSet rs = null;
		String sql = null;
		int seq = 0;
		
		
		try {
			
			conn = DBUtil.getConnection();
			conn.setAutoCommit(false);
			
			/*-----시퀀스 생성-----*/
			sql = "SELECT order_num_seq.nextval FROM dual";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) seq = rs.getInt(1);
			
			/*-----주문 테이블 insert-----*/
			sql = "INSERT INTO order_item (order_num,item_name,order_price,"
					+ "order_custprice,mem_num,order_status,notice,payment,"
					+ "order_name,order_email,order_phone,order_birth,order_gender) "
					+ "VALUES (?,?,?,?,?,1,?,?,?,?,?,?,?)";
			
			pstmt2 = conn.prepareStatement(sql);
			
			pstmt2.setInt(1, seq);
			pstmt2.setString(2, order.getItem_name());
			pstmt2.setInt(3, order.getOrder_price());
			pstmt2.setInt(4, order.getOrder_custprice());
			pstmt2.setInt(5, order.getMem_num());
			
			pstmt2.setString(6, order.getNotice());
			pstmt2.setInt(7, order.getPayment());
			
			pstmt2.setString(8, order.getOrder_name());
			pstmt2.setString(9, order.getOrder_email());
			pstmt2.setString(10, order.getOrder_phone());
			pstmt2.setString(11, order.getOrder_birth());
			pstmt2.setString(12, order.getOrder_gender());
			
			pstmt2.executeUpdate();
			
			/*-----주문 상세 테이블 insert-----*/
			sql = "INSERT INTO order_detail (detail_num,item_num,item_name,item_price,order_num,"
					+ "order_quantity) VALUES (order_detail_seq.nextval,?,?,?,?,?)";
			pstmt3 = conn.prepareStatement(sql);
			for(int i=0 ; i<detailList.size() ; i++) {
				OrderDetailVO detail = detailList.get(i);
				pstmt3.setInt(1, detail.getItem_num());
				pstmt3.setString(2, detail.getItem_name());
				pstmt3.setInt(3, detail.getItem_price());
				pstmt3.setInt(4, seq);
				pstmt3.setInt(5, detail.getOrder_quantity());
				pstmt3.addBatch();
				
				if(i%1000 == 0) pstmt3.executeBatch();
			}
			pstmt3.executeBatch();
			
			/*------ㅡmoney 테이블에 등록------*/
			sql = "INSERT INTO money (sm_num,mem_num,saved_money,sm_content) "
					+ "VALUES (money_seq.nextval,?,?,?)";
			pstmt4 = conn.prepareStatement(sql);
			pstmt4.setInt(1, order.getMem_num());
			pstmt4.setInt(2, order.getUse_money()*(-1)); //마이너스 적립금
			pstmt4.setString(3, "여행 예약");
			
			pstmt4.executeUpdate();
			
			/*-----장바구니 테이블 delete-----*/
			sql = "DELETE FROM cart WHERE mem_num=?";
			pstmt5 = conn.prepareStatement(sql);
			pstmt5.setInt(1, order.getMem_num());
			pstmt5.executeUpdate();
			
			conn.commit();
		} catch (Exception e) {
			conn.rollback();
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(null, pstmt5, null);
			DBUtil.executeClose(null, pstmt4, null);
			DBUtil.executeClose(null, pstmt3, null);
			DBUtil.executeClose(null, pstmt2, null);
			DBUtil.executeClose(rs, pstmt, conn);
		}
	}
	
	//예약 횟수
	public int getOrderCount(int item_num) throws Exception {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT SUM(order_quantity) FROM order_detail WHERE item_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, item_num);
			rs = pstmt.executeQuery();
			if(rs.next()) count = rs.getInt(1);
		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return count;
	}
	
	//목록 카운트 검색x
	
	//예약 목록(select order) 검색x
	
	//예약 상세(select order, order detail)
	
	
	/*-----관리자-----*/
	
}
