package kr.item.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import kr.item.vo.ItemVO;
import kr.util.DBUtil;

public class ItemDAO {
private static ItemDAO instance = new ItemDAO();
	
	public static ItemDAO getInstance() {
		return instance;
	}
	
	private ItemDAO(){};
	
	//관리자-상품 등록
	public ItemVO insertItem(ItemVO item)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			//커넥션풀로부터 커넥션 객체 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "INSERT INTO item ()";
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return item;
	}
	//관리자-상품 수정
	//관리자-상품 삭제
	//관리자/사용자 - 전체 상품 개수/검색 상품 개수
	//관리자/사용자 - 전체 상품 목록/검색 상품 목록
	//관리자/사용자 - 상품 상세
	
	
	
	
	
	
	
	
	
	
}
