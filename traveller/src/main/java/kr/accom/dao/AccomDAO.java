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
			sql = "INSERT INTO accom(accom_num, accom_status, accom_title, accom_content,"
					+ "accom_quantity, accom_expense, accom_filename, accom_start, accom_end,"
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
	public int getAccomCount(String keyfield, String keyword,int mem_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql="";
		String sub_sql2="";
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
			if(mem_num > 0) {
				sub_sql2 += "WHERE mem_num=?";
			}
			//SQL문 작성
			sql = "SELECT COUNT (*) FROM accom JOIN member USING(mem_num) " + sub_sql + sub_sql2;
			//PrepardStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			if(keyword != null && !"".equals(keyword)) {
				pstmt.setString(1, "%"+keyword+"%");
			}
			if(mem_num > 0) {
				pstmt.setInt(1, mem_num);
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
	public List<AccomVO> getListAccom(int start, int end, String keyfield, String keyword,int mem_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<AccomVO> list = null;
		String sub_sql = "";
		String sub_sql2 = "";
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
			if(mem_num > 0) {
				sub_sql2 += "WHERE mem_num=?";
			}
			//SQL문 작성
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM "
					+ "(SELECT * FROM accom JOIN member USING(mem_num) " + sub_sql + sub_sql2
					+ "ORDER BY accom_num_ DESC)a) WHERE rnum >= ? AND rnum <= ?";
			//PrepardStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			if(keyword != null && !"".equals(keyword)) {
				pstmt.setString(++cnt, "%"+keyword+"%");
			}
			if(mem_num > 0) {
				pstmt.setInt(++cnt, mem_num);
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
				accom.setAccom_title(StringUtil.useNoHtml(rs.getString("accom_title")));
				accom.setId(rs.getString("id"));
				accom.setAccom_regdate(rs.getDate("accom_regdate"));
				accom.setAccom_quantity(rs.getInt("accom_quantity"));
				accom.setAccom_hit(rs.getInt("accom_hit"));
				// 추천수
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
	public AccomVO getAccom(int accom_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		AccomVO accom = null;
		String sql = null;
		
		try {
			//커넥션풀로부터 커넥션을 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			//(주의)회원 탈퇴하면 member_detail에 레코드가 존재하지 않기 때문에 외부조인을 사용해서 데이터 누락을 방지함
			sql = "SELECT * FROM accom JOIN member USING(mem_num) "
					+ "LEFT OUTER JOIN member_detail USING(mem_num) "
					+ "WHERE accom_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, accom_num);
			//SQL문 실행
			if(rs.next()) {
				accom = new AccomVO();
				accom.setAccom_num(rs.getInt("accom_num"));
				accom.setAccom_status(rs.getInt("accom_status"));
				accom.setAccom_title(rs.getString("accom_title"));
				accom.setAccom_content(rs.getString("accom_content"));
				accom.setAccom_hit(rs.getInt("accom_hit"));
				accom.setAccom_regdate(rs.getDate("accom_regdate"));
				accom.setAccom_modifydate(rs.getDate("accom_modifydate"));
				accom.setAccom_quantity(rs.getInt("accom_quantity"));
				accom.setAccom_expense(rs.getInt("accom_expense"));
				accom.setAccom_filename(rs.getString("accom_filename"));
				accom.setAccom_start(rs.getString("accom_start"));
				accom.setAccom_end(rs.getString("accom_end"));
				accom.setMem_num(rs.getInt("mem_num"));
				accom.setId(rs.getString("id"));
				accom.setPhoto(rs.getString("photo"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return accom;
	}
	//조회 수 증가
	public void updateReadCount(int accom_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "UPDATE accom SET accom_hit=accom_hit+1 WHERE accom_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, accom_num);
			//SQL문 실행
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//파일 삭제
	public void deleteAccom(int accom_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "UPDATE accom SET filename='' WHERE accom_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, accom_num);
			//SQL문 실행
			pstmt.executeUpdate();
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
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
	}  