package kr.order.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
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
	
	//개별 아이템의 예약 횟수 - 예약한 인원 수
	public int getOrderItemCount(int item_num) throws Exception {
		
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
	
	//목록 갯수
	public int getOrderCount(String keyword, String keyfield) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		int count = 0;
		
		try {
			conn = DBUtil.getConnection();
			
			if(keyword!=null && !"".equals(keyword)) {
				//검색어 sql 문장 작성 필요
				if(keyfield.equals("1")) sub_sql += "";
			}
			sql = "SELECT COUNT(*) FROM order_item " +sub_sql;
			
			pstmt = conn.prepareStatement(sql);
			
			if(keyword!=null && !"".equals(keyword)) {
				//검색어 데이터 바인딩 필요
			}
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) count = rs.getInt(1);
			
		} catch (Exception e) {
			throw new Exception();
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return count;
	}
	
	//예약 list
	public List<OrderVO> getOrderList(int start, int end, String keyword, String keyfield, int mem_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<OrderVO> list = null;
		String sql = null;
		String sub_sql = "";
		String sub_sql2 = "";
		int cnt = 0;
		
		try {
			conn = DBUtil.getConnection();
			
			if(keyword!=null && !"".equals(keyword)) { //검색어 입력 시
				//검색어 sql 문장 작성 필요
			}
			if(mem_num!=0) sub_sql2 += " WHERE mem_num=? "; //mem_num 입력 시
			
			sql = "SELECT * FROM (SELECT a.*,rownum rnum FROM (SELECT * FROM order_item "
					+ sub_sql + sub_sql2
					+ " ORDER BY order_num DESC)a) WHERE rnum>=? AND rnum<=?";
			
			pstmt = conn.prepareStatement(sql);
			
			if(keyword!=null && !"".equals(keyword)) {
				//검색어 데이터 바인딩 필요
			}
			if(mem_num!=0) pstmt.setInt(++cnt, mem_num); //mem_num 입력 시
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);
			
			rs = pstmt.executeQuery();
			list = new ArrayList<OrderVO>();
			
			while(rs.next()) {
				OrderVO order = new OrderVO();
				
				order.setOrder_num(rs.getInt("order_num"));
				order.setItem_name(rs.getString("item_name"));
				order.setOrder_price(rs.getInt("order_price"));
				order.setOrder_custprice(rs.getInt("order_custprice"));
				order.setMem_num(rs.getInt("mem_num"));
				order.setOrder_status(rs.getInt("order_status"));
				order.setOrder_date(rs.getDate("order_date"));
				order.setOrder_date(rs.getDate("order_modate"));
				order.setOrder_num(rs.getInt("order_num"));
				order.setNotice(rs.getString("notice"));
				order.setPayment(rs.getInt("payment"));
				order.setOrder_name(rs.getString("order_name"));
				order.setOrder_email(rs.getString("order_email"));
				order.setOrder_phone(rs.getString("order_phone"));
				order.setOrder_birth(rs.getString("order_birth"));
				order.setOrder_gender(rs.getString("order_gender"));
				
				list.add(order);
			}
		} catch (Exception e) {
			throw new Exception();
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}
	
	//예약 order_item 상세
	public OrderVO getOrder(int order_num, int mem_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		OrderVO order = null;
		String sql = null;
		String sub_sql = "";
		
		try {
			conn = DBUtil.getConnection();
			
			if(order_num!=0) sub_sql += "order_num=?"; //관리자 페이지에서 사용
			else sub_sql += "mem_num=?"; //마이페이지에서 사용
			sql = "SELECT * FROM order_item WHERE " + sub_sql;
			
			pstmt = conn.prepareStatement(sql);
			
			if(order_num!=0) pstmt.setInt(1, order_num); //관리자 페이지에서 사용
			else pstmt.setInt(1, mem_num); //마이페이지에서 사용
			
			rs = pstmt.executeQuery();
			order = new OrderVO();
			
			if(rs.next()) {
				order.setOrder_num(rs.getInt(order_num));
				order.setItem_name(rs.getString("item_name"));
				order.setOrder_price(rs.getInt("order_price"));
				order.setOrder_custprice(rs.getInt("order_custprice"));
				order.setMem_num(rs.getInt("mem_num"));
				order.setOrder_status(rs.getInt("order_status"));
				order.setOrder_date(rs.getDate("order_date"));
				order.setOrder_date(rs.getDate("order_modate"));
				order.setOrder_num(rs.getInt("order_num"));
				order.setNotice(rs.getString("notice"));
				order.setPayment(rs.getInt("payment"));
				order.setOrder_name(rs.getString("order_name"));
				order.setOrder_email(rs.getString("order_email"));
				order.setOrder_phone(rs.getString("order_phone"));
				order.setOrder_birth(rs.getString("order_birth"));
				order.setOrder_gender(rs.getString("order_gender"));
			}
		} catch (Exception e) {
			throw new Exception();
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return order;
	}
	
	//예약 order_detail 상세
	public OrderDetailVO getOrderDetail(int order_num, int mem_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		OrderDetailVO orderDetail = null;
		String sql = null;
		String sub_sql = "";
		
		try {
			conn = DBUtil.getConnection();
			
			if(order_num!=0) sub_sql += "order_num=?"; //관리자 페이지에서 사용
			else sub_sql += "mem_num=?"; //마이페이지에서 사용
			sql = "SELECT * FROM order_detail WHERE " + sub_sql;
			
			pstmt = conn.prepareStatement(sql);
			
			if(order_num!=0) pstmt.setInt(1, order_num); //관리자 페이지에서 사용
			else pstmt.setInt(1, mem_num); //마이페이지에서 사용			
			
			rs = pstmt.executeQuery();
			orderDetail = new OrderDetailVO();
			
			if(rs.next()) {
				orderDetail.setDetail_num(rs.getInt("detail_num"));
				orderDetail.setItem_num(rs.getInt("item_num"));
				orderDetail.setItem_name(rs.getString("item_name"));
				orderDetail.setItem_price(rs.getInt("item_price"));
				orderDetail.setOrder_num(rs.getInt("order_num"));
				orderDetail.setOrder_quantity(rs.getInt("order_quantity"));
			}
		} catch (Exception e) {
			throw new Exception();
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return orderDetail;
	}
	
	
	/*-----관리자-----*/
	
}
