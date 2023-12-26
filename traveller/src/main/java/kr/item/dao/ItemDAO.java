package kr.item.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.item.vo.ItemVO;
import kr.order.dao.OrderDAO;
import kr.util.DBUtil;

public class ItemDAO {
private static ItemDAO instance = new ItemDAO();
	
	public static ItemDAO getInstance() {
		return instance;
	}
	
	private ItemDAO(){};
	
	//관리자-상품 등록
	public void insertItem(ItemVO item)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			//커넥션풀로부터 커넥션 객체 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "INSERT INTO item (item_num, item_name, item_content, item_price, "
					+ "item_img1, item_img2, item_img3, item_img4, item_img5, item_img6, "
					+ "item_st1, item_st2, item_st3, date_start, date_end, status,quantity,item_case)  "
					+ "VALUES(item_seq.nextval, ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setString(1,item.getItem_name());
			pstmt.setString(2,item.getItem_content());
			pstmt.setInt(3,item.getItem_price());
			pstmt.setString(4,item.getItem_img1());
			pstmt.setString(5,item.getItem_img2());
			pstmt.setString(6,item.getItem_img3());
			pstmt.setString(7,item.getItem_img4());
			pstmt.setString(8,item.getItem_img5());
			pstmt.setString(9,item.getItem_img6());
			pstmt.setString(10,item.getItem_st1());
			pstmt.setString(11,item.getItem_st2());
			pstmt.setString(12,item.getItem_st3());
			pstmt.setString(13,item.getDate_start());
			pstmt.setString(14,item.getDate_end());
			pstmt.setString(15,item.getStatus());
			pstmt.setInt(16,item.getQuantity());
			pstmt.setString(17, item.getItem_case());			
			//SQL문 실행
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
	}
	//관리자-상품 수정
	public void modifyItem(ItemVO item)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		
		try {
			//커넥션 풀로부터 커넥션 객체 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "UPDATE item SET item_name=?, item_content=?, item_price=?, item_img1=?, item_img2=?,"
					+ " item_img3=?, item_img4=?, item_img5=?, item_img6=?, item_st1=?, item_st2=?, item_st3=?,"
					+ " date_start=?, date_end=?, status=?, quantity=?, item_case=? WHERE item_num=?";
			
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			
			//?에 데이터 바인딩
			pstmt.setString(1,item.getItem_name());
			pstmt.setString(2,item.getItem_content());
			pstmt.setInt(3,item.getItem_price());
			pstmt.setString(4,item.getItem_img1());
			pstmt.setString(5,item.getItem_img2());
			pstmt.setString(6,item.getItem_img3());
			pstmt.setString(7,item.getItem_img4());
			pstmt.setString(8,item.getItem_img5());
			pstmt.setString(9,item.getItem_img6());
			pstmt.setString(10,item.getItem_st1());
			pstmt.setString(11,item.getItem_st2());
			pstmt.setString(12,item.getItem_st3());
			pstmt.setString(13,item.getDate_start());
			pstmt.setString(14,item.getDate_end());
			pstmt.setString(15,item.getStatus());
			pstmt.setInt(16,item.getQuantity());
			pstmt.setString(17,item.getItem_case());
			pstmt.setInt(18,item.getItem_num());
			
			//SQL문 실행
			pstmt.executeUpdate();
			//System.out.println(item.toString());
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
		
		
	
	}
	
	
	//관리자-상품 삭제
	//관리자/사용자 - 전체 상품 개수/검색 상품 개수
	public int getItemCount(String keyfield, String keyword, String list_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		String sub_sql2 =""; 
		int cnt = 0;
		int count = 0;
		
		try {
			//커넥션풀로부터 커넥션 객체 할당
			conn = DBUtil.getConnection();
			
			if(keyword!=null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql = " WHERE item_name LIKE ?";
				else if(keyfield.equals("2")) sub_sql = " WHERE item_content LIKE ?";
			
				if(list_num!=null && !"".equals(list_num)) {
					sub_sql2 = " AND item_st1 = ?";
				}
			}
			
			if(list_num!=null && !"".equals(list_num)) {
				sub_sql2 = " WHERE item_st1 = ?";
			}
			
			//SQL문 작성
			sql = "SELECT COUNT(*) FROM item" + sub_sql + sub_sql2;
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			if(keyword!=null && !"".equals(keyword)) {
				pstmt.setString(++cnt, "%" + keyword + "%");
				if(list_num!=null && !"".equals(list_num)) {
					pstmt.setString(++cnt, list_num);
				}
			}
			if(list_num!=null && !"".equals(list_num)) {
				pstmt.setString(++cnt, list_num);
			}
			//SQL문 실행
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return count;
				
	}
	
	//관리자/사용자 - 전체 상품 목록/검색 상품 목록
	public List<ItemVO> getItemList(int start, int end, String keyfield, String keyword, String status, String list_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		String sub_sql2 = "";
		String sub_sql3 = "";
		int cnt = 0;
		List<ItemVO> list = null;
		
		try {
			//커넥션풀로부터 커넥션객체 할당
			conn = DBUtil.getConnection();
			
			if(keyword!=null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql = " WHERE item_name LIKE ? ";
				if(keyfield.equals("2")) sub_sql = " WHERE item_content LIKE ? ";
				
				if(list_num!=null && !"".equals(list_num)) {
					sub_sql2 = " AND item_st1 = ?";
				}
			}
			if(list_num!=null && !"".equals(list_num)) {
				sub_sql2 = " WHERE item_st1 = ?";
			}
			
			if(status!=null && !"".equals(status)) {
				if(keyword!=null && !"".equals(keyword) || list_num!=null && !"".equals(list_num)) {
					sub_sql3 = " AND status =?";
				}else {
					sub_sql3 = " WHERE status=?";
				}
			}
			
			
			
			//SQL문 작성
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM (SELECT * FROM item  "  + sub_sql +sub_sql2 +sub_sql3
					+ " ORDER BY item_num ASC)a) WHERE rnum>=? AND rnum<=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			
			if(keyword!=null && !"".equals(keyword)) {
				pstmt.setString(++cnt, "%" + keyword + "%");
				if(list_num!=null && !"".equals(list_num)) {
					pstmt.setString(++cnt, list_num);
				}
			}
			if(list_num!=null && !"".equals(list_num)) {
				pstmt.setString(++cnt, list_num);
			}
			if(status!=null && !"".equals(status)) {
				pstmt.setString(++cnt, status);
			}
	
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);
			//SQL문 실행
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
				
				OrderDAO dao = OrderDAO.getInstance();
				item.setOrderCount(dao.getOrderItemCount(rs.getInt("item_num")));
				
				
				list.add(item);
				
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return list;
	}
	//관리자/사용자 - 상품 상세
	public ItemVO getItem(int item_num)throws Exception{
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ItemVO vo = null;
		
		try {
			//커넥션풀로부터 커넥션 객체 할당
			conn = DBUtil.getConnection();
			//SQL문 실행
			sql = "SELECT * FROM item WHERE item_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, item_num);
			//SQL문 실행
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				vo = new ItemVO();
				vo.setItem_num(rs.getInt("item_num"));
				vo.setItem_name(rs.getString("item_name"));
				vo.setItem_content(rs.getString("item_content"));
				vo.setItem_price(rs.getInt("item_price"));
				vo.setItem_img1(rs.getString("item_img1"));
				vo.setItem_img2(rs.getString("item_img2"));
				vo.setItem_img3(rs.getString("item_img3"));
				vo.setItem_img4(rs.getString("item_img4"));
				vo.setItem_img5(rs.getString("item_img5"));
				vo.setItem_img6(rs.getString("item_img6"));
				vo.setItem_st1(rs.getString("item_st1"));
				vo.setItem_st2(rs.getString("item_st2"));
				vo.setItem_st3(rs.getString("item_st3"));
				vo.setDate_start(rs.getString("date_start"));
				vo.setDate_end(rs.getString("date_end"));
				vo.setStatus(rs.getString("status"));
				vo.setReg_date(rs.getDate("reg_date"));
				vo.setModifydate(rs.getDate("modify_date"));
				vo.setQuantity(rs.getInt("quantity"));	
				vo.setItem_case(rs.getString("item_case"));
				
				OrderDAO dao = OrderDAO.getInstance();
				vo.setOrderCount(dao.getOrderItemCount(rs.getInt("item_num")));
				
			}	
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}	
		return vo;
	}
	//동행 신청 내역 본인	
	//상품 표시상태 변경
	public void modifyItemStatus(String status,int item_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			//커넥션풀로부터 커넥션 객체 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "UPDATE item SET status=? WHERE item_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			if(status.equals("1") || status.equals("2") || status.equals("3")) {
				pstmt.setString(1, status);
			}
			pstmt.setInt(2, item_num);
			//SQL문 실행
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
		
	//여행지역별 대표상품 추출
	public int getItemSampleCount(String keyfield, String keyword, String list_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		String sub_sql2 =""; 
		int cnt = 0;
		int count = 0;
		
		try {
			//커넥션풀로부터 커넥션 객체 할당
			conn = DBUtil.getConnection();
			
			if(keyword!=null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql = " WHERE item_name LIKE ?";
				else if(keyfield.equals("2")) sub_sql = " WHERE item_content LIKE ?";
			
				if(list_num!=null && !"".equals(list_num)) {
					sub_sql2 = " AND item_st1 = ?";
				}
			}
			
			if(list_num!=null && !"".equals(list_num)) {
				sub_sql2 = " WHERE item_st1 = ?";
			}
			
			//SQL문 작성
			sql = "SELECT COUNT(*) FROM item" + sub_sql + sub_sql2+" GROUP BY (item_st1,item_case)";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			if(keyword!=null && !"".equals(keyword)) {
				pstmt.setString(++cnt, "%" + keyword + "%");
				if(list_num!=null && !"".equals(list_num)) {
					pstmt.setString(++cnt, list_num);
				}
			}
			if(list_num!=null && !"".equals(list_num)) {
				pstmt.setString(++cnt, list_num);
			}
			//SQL문 실행
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return count;
	}
	public List<ItemVO> getItemSampleList(String item_st1) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		List<ItemVO> list = null;
		
		try {
			//커넥션풀로부터 커넥션객체 할당
			conn = DBUtil.getConnection();
			
			//SQL문 작성
			sql = "WITH RankedItems AS ("
					+ "  SELECT"
					+ "    item_num,item_name,item_content,item_price,"
					+ "    item_img1,item_img2,item_img3,item_img4,item_img5,item_img6,"
					+ "    item_st1,item_st2,item_st3,date_start,date_end,status,reg_date,"
					+ "    modify_date,quantity,item_case,"
					+ "    ROW_NUMBER() OVER (PARTITION BY item_st1, item_case ORDER BY reg_date DESC, item_num DESC) AS row_num"
					+ "  FROM"
					+ "    item"
					+ "  WHERE "
					+ "    item_st1 = ?"
					+ "  )"
					+ "  SELECT"
					+ "  item_num,item_name,item_content,item_price,"
					+ "  item_img1,item_img2,item_img3,item_img4,item_img5,item_img6,"
					+ "  item_st1,item_st2,item_st3,date_start,date_end,status,reg_date,"
					+ "  modify_date,quantity,item_case"
					+ "  FROM"
					+ "  RankedItems"
					+ "  WHERE"
					+ "  row_num = 1";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setString(1, item_st1);
			
			//SQL문 실행
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
				
				OrderDAO dao = OrderDAO.getInstance();
				item.setOrderCount(dao.getOrderItemCount(rs.getInt("item_num")));
				
				
				list.add(item);
				
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return list;
	}
	//item_st1반환
	public String getItem_st1(int item_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String item_st1=null;
		
		try {
			//커넥션풀로부터 커넥션 객체 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "SELECT item_st1 FROM item WHERE item_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, item_num);
			//SQL문 실행
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				item_st1 = rs.getString("item_st1");
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return item_st1;
	}
	//item_case반환
	public String getItem_case(int item_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String item_case=null;
		
		try {
			//커넥션풀로부터 커넥션 객체 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "SELECT item_case FROM item WHERE item_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, item_num);
			//SQL문 실행
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				item_case = rs.getString("item_case");
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return item_case;
	}
	public List<ItemVO> getItemRecommendList(Integer sum) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		
		List<ItemVO> list = null;
		
		try {
			//커넥션풀로부터 커넥션객체 할당
			conn = DBUtil.getConnection();
			if(sum!=null) {
				sub_sql+="WHERE ROWNUM <= + ?";
			}
			//SQL문 작성
			sql = "SELECT * FROM ( SELECT * FROM item "
						+"    WHERE TO_DATE(DATE_START, 'YYYY-MM-DD') >= TRUNC(SYSDATE) "
						+"    ORDER BY TO_DATE(DATE_START, 'YYYY-MM-DD') ASC )"
						+sub_sql;
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			if(sum!=null) {
				pstmt.setInt(1, sum);
			}
			//SQL문 실행
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
				
				OrderDAO dao = OrderDAO.getInstance();
				item.setOrderCount(dao.getOrderItemCount(rs.getInt("item_num")));
				
				
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
