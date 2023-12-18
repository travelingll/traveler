package kr.faq.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.faq.vo.FaqVO;
import kr.util.DBUtil;



public class FaqDAO {
	//싱글턴 패턴
		private static FaqDAO instance = new FaqDAO();
		
		public static FaqDAO getInstance() {
			return instance;
		};
		
		private FaqDAO() {}
		
		//글 등록
		public void insertFaq(FaqVO faq) throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			String sql = null;
			
			try {
				//커넥션풀로부터 커넥션 할당
				conn = DBUtil.getConnection();
				//SQL문 작성
				sql = "INSERT INTO faq (faq_num, faq_title, faq_content, faq_category) VALUES (faq_seq.nextval,?,?,?)";
				//PreparedStatement 객체 생성
				pstmt = conn.prepareStatement(sql);
				//?에 데이터 바인딩
				pstmt.setString(1, faq.getFaq_title());
				pstmt.setString(2, faq.getFaq_content());
				pstmt.setInt(3, faq.getFaq_category());
				
				//SQL문 실행
				pstmt.executeUpdate();
				
			}catch(Exception e) {
				throw new Exception(e);
			}finally {
				DBUtil.getConnection();
			}
		}
		//전체 레코드수/검색 레코드수
		public int getFaqCount(String keyfield,String keyword)throws Exception{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			String sub_sql = "";
			int count = 0;
			
			try {
				conn = DBUtil.getConnection();
				
				if(keyword!=null && !"".equals(keyword)) {
					if(keyfield.equals("1")) sub_sql += "WHERE faq_title LIKE ?";
					else if(keyfield.equals("2")) sub_sql += "WHERE faq_content LIKE ?";
					else if(keyfield.equals("3")) sub_sql += "WHERE faq_category LIKE ?";
				}
				sql = "SELECT COUNT(*) FROM faq " + sub_sql;
				
				pstmt = conn.prepareStatement(sql);
				if(keyword != null && !"".equals(keyword)) {
					pstmt.setString(1, "%" + keyword + "%");
				}
				
				rs = pstmt.executeQuery();
				if (rs.next()) {
					count = rs.getInt(1);
				}
			} catch (Exception e) {
				throw new Exception(e);
			}finally {
				DBUtil.executeClose(rs, pstmt, conn);
			}
			return count;
		}
		//전체 글/검색 글 목록
		public List<FaqVO> getListFaq(int start, int end, String keyfield, String keyword)throws Exception{
			Connection conn= null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<FaqVO> list = null;
			String sql = null;
			String sub_sql = "";
			int cnt = 0;
			
			try {
				conn = DBUtil.getConnection();
				
				if(keyword !=null && !"".equals(keyword)) {
					if(keyfield.equals("1")) sub_sql += "WHERE faq_title LIKE ?";
					else if(keyfield.equals("2")) sub_sql += "WHERE faq_content LIKE ?";
					else if(keyfield.equals("3")) sub_sql += "WHERE faq_category LIKE ?";
				}
				sql = "SELECT * FROM(SELECT a.*, rownum rnum FROM "
						+ "(SELECT * FROM faq " + sub_sql
						+ ")a) WHERE rnum>=? AND rnum <=?"; 
				pstmt = conn.prepareStatement(sql);
				if(keyword!=null && !"".equals(keyword)) {
					pstmt.setString(++cnt, "%" + keyword + "%");
				}		
				pstmt.setInt(++cnt, start);
				pstmt.setInt(++cnt, end);		
				
				rs = pstmt.executeQuery();
				list = new ArrayList<FaqVO>();
				while(rs.next()) {
					FaqVO faq = new FaqVO();
					faq.setFaq_title(rs.getString("faq_title"));
					faq.setFaq_content(rs.getString("faq_content"));
					faq.setFaq_category(rs.getInt("faq_category"));
					
					list.add(faq);
				}
			}catch (Exception e) {
				throw new Exception(e);
			}finally {
				DBUtil.executeClose(rs, pstmt, conn);
			}
			
			return list;
		}
		//글 수정
		
}
