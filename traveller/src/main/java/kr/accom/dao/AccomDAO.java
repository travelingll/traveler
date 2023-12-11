package kr.accom.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.accom.vo.AccomVO;
import kr.util.DBUtil;
import kr.util.StringUtil;

public class AccomDAO {
	//싱글턴 패턴 작성
	private static AccomDAO instance = new AccomDAO();
	
	public static AccomDAO getInstance() {
		return instance;
	}
	
	private AccomDAO() {}
	
	//글 등록
	public void insertAccom(AccomVO accom) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "INSERT INTO accom(accom_num, accom_status, accom_title, accom_content"
					+ "accom_quantity, accom_expense, accom_filename, accom_start, accom_end"
					+ "ip, mem_num) VALUES (accom_seq.nextval, "
					+ "?,?,?,?,?,?,?,?,?,?)";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, accom.getAccom_status());
			pstmt.setString(2, accom.getAccom_title());
			pstmt.setString(3, accom.getAccom_content());
			pstmt.setInt(4, accom.getAccom_quantity());
			pstmt.setInt(5, accom.getAccom_expense());
			pstmt.setString(6, accom.getAccom_filename());
			pstmt.setString(7, accom.getAccom_start());
			pstmt.setString(8, accom.getAccom_end());
			pstmt.setString(9, accom.getIp());
			pstmt.setInt(10, accom.getMem_num());
			//SQL문 실행
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//전체 레코드 수/검색 레코드 수
	public int getAccomCount(String keyfield, String keyword)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql="";
		int count = 0;
		
		try {
			//커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();
			
			if(keyword!=null &&"".equals(keyword)) {
				//검색 처리
				if(keyfield.equals("1")) sub_sql += "WHERE accom_title LIKE ?";
				else if (keyfield.equals("2")) sub_sql += "WHERE id LIKE ?";
				else if (keyfield.equals("3")) sub_sql += "WHERE accom_content LIKE ?";
			}
			//SQL문 작성
			sql = "SELECT COUNT (*) FROM accom JOIN member USING(mem_num) " + sub_sql;
			//PrepardStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			if(keyword != null && !"".equals(keyword)) {
				pstmt.setString(1, "%"+keyword+"%");
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
	//전체 글/검색 글 목록
	public List<AccomVO> getListAccom(int start, int end, String keyfield, String keyword) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<AccomVO> list = null;
		String sub_sql = "";
		String sql = null;
		int cnt = 0;
		
		try {
			//커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();
			
			if(keyword!=null &&"".equals(keyword)) {
				//검색 처리
				if(keyfield.equals("1")) sub_sql += "WHERE accom_title LIKE ?";
				else if (keyfield.equals("2")) sub_sql += "WHERE id LIKE ?";
				else if (keyfield.equals("3")) sub_sql += "WHERE accom_content LIKE ?";
			}
			
			//SQL문 작성
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM "
					+ "(SELECT * FROM accom JOIN member USING(mem_num) " + sub_sql
					+ "ORDER BY accom_num_ DESC)a) WHERE rnum >= ? AND rnum <= ?";
			//PrepardStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			if(keyword != null && !"".equals(keyword)) {
				pstmt.setString(++cnt, "%"+keyword+"%");
			}
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);
			
			//SQL문 실행
			rs = pstmt.executeQuery();
			list = new ArrayList<AccomVO>();
			while(rs.next()) {
				AccomVO accom = new AccomVO();
				accom.setAccom_num(rs.getInt("accom_num"));
				accom.setAccom_status(rs.getInt("accom_status"));
				//HTML을 허용하지 않음
				accom.setAccom_title(StringUtil.useNoHtml("accom_title"));
				accom.setId(rs.getString("id"));
				accom.setAccom_regdate(rs.getDate("accom_regdate"));
				accom.setAccom_quantity(rs.getInt("accom_quantity"));
				accom.setAccom_hit(rs.getInt("accom_hit"));
				
				list.add(accom);
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		
		
		return list;
	}
	//글 상세
	//조회 수 증가
	//파일 삭제
	//글 수정
	//글 삭제
	//좋아요 등록
	//좋아요 개수
	//회원 번호와 게시물 번호를 이용한 좋아요 정보(좋아요 선택 여부)
	//내가 선택한 좋아요 목록
	//댓글 등록
	//댓글 개수
	//댓글 목록
	//댓글 상세(댓글 수정, 삭제 시 작성자 회원번호 체크 용도로 사용)
	//댓글 수정
	//댓글 삭제
	
}