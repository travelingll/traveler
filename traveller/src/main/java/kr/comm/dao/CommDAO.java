package kr.comm.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


import kr.comm.vo.CommVO;
import kr.util.DBUtil;
import kr.util.StringUtil;

public class CommDAO {
	//싱글턴 패턴
	private static CommDAO instance = new CommDAO();
	
	public static CommDAO getInstance() {
		return instance;
	};
	
	private CommDAO() {}
	
	//글 등록
	public void insertComm(CommVO comm) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "INSERT INTO comm (comm_num, comm_title, comm_content, filename, ip, mem_num) "
					+ "VALUES (comm_seq.nextval,?,?,?,?,?)";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setString(1, comm.getComm_title());
			pstmt.setString(2, comm.getComm_content());
			pstmt.setString(3, comm.getFilename());
			pstmt.setString(4, comm.getIp());
			pstmt.setInt(5, comm.getMem_num());
			
			//SQL문 실행
			pstmt.executeUpdate();
			
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.getConnection();
		}
	}
	//전체 레코드수/검색 레코드수
	public int getCommCount(String keyfield, String keyword)throws Exception{
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		int count = 0;
		
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			
			if(keyword!=null && !"".equals(keyword)) {
				//검색 처리
				if(keyfield.equals("1")) sub_sql +="WHERE title LIKE ?";
				else if(keyfield.equals("2")) sub_sql +="WHERE id LIKE ?";
				else if(keyfield.equals("3")) sub_sql +="WHERE content LIKE ?";
			}
			//SQL문 작성
			sql = "SELECT * FROM comm JOIN member USING(mem_num) " + sub_sql;
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			if(keyword != null && !"".equals(keyword)) {
				pstmt.setString(1, "%" + keyword + "%");
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
	public List<CommVO> getListComm(int start, int end, String keyfield, String keyword) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<CommVO> list = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			
			if(keyword!=null && !"".equals(keyword)) {
				//검색 처리
				if(keyfield.equals("1")) sub_sql += "WHERE title LIKE ?";
				else if(keyfield.equals("2")) sub_sql += "WHERE id LIKE ?";
				else if(keyfield.equals("3")) sub_sql += "WHERE content LIKE ?";
			}
			//SQL문 작성
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM "
					+ "(SELECT * FROM comm JOIN member USING(mem_num)" + sub_sql
					+ " ORDER BY comm_num DESC)a) WHERE rnum>=? AND rnum <=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			if(keyword!=null && !"".equals(keyword)) {
				pstmt.setString(++cnt, "%" + keyword + "%");
			}
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);
					
			//SQL문 실행
			rs = pstmt.executeQuery();
			list = new ArrayList<CommVO>();
			while(rs.next()) {
				CommVO comm = new CommVO();
				comm.setComm_num(rs.getInt("comm_num"));
				//HTML 허용하지 않음
				comm.setComm_title(StringUtil.useBrNoHtml(rs.getString("comm_title")));
				comm.setComm_hit(rs.getInt("comm_hit"));
				comm.setReg_date(rs.getDate("reg_date"));
				comm.setId(rs.getString("id"));
				
				list.add(comm);	
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		
		return list; 
	}
	//글 상세
	public CommVO getComm(int comm_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CommVO comm = null;
		String sql = null;
		
		try {
			//커넥션풀로부터 커넥션객체 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			//(주의) 회원탈퇴하면 zmember_detail의 레코드가 존재하지 않기 때문에 외부 조인을
			//사용해서 데이터 누락 방지
			sql = "SELECT * FROM comm JOIN member USING(mem_num) "
					+ "LEFT OUTER JOIN member_detail USING(mem_num) WHERE comm_num=?";
			//preparedStatement객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, comm_num);
			//SQL문 실행
			rs = pstmt.executeQuery();
			if(rs.next()) {
				comm = new CommVO();
				comm.setComm_num(rs.getInt("comm_num"));
				comm.setComm_title(rs.getString("comm_title"));
				comm.setComm_content(rs.getString("comm_content"));
				comm.setComm_hit(rs.getInt("comm_hit"));
				comm.setReg_date(rs.getDate("reg_date"));
				comm.setModify_date(rs.getDate("modify_date"));
				comm.setFilename(rs.getString("filename"));
				comm.setMem_num(rs.getInt("mem_num"));
				comm.setId(rs.getString("id"));
				comm.setPhoto(rs.getString("photo"));
			}
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
		
		
		return comm; 
	}
	 
	//조회수 증가
	public void updateReadcount(int comm_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "UPDATE comm SET comm_hit=comm_hit+1 WHERE comm_num=?";
			//preparedStatement객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, comm_num);
			//SQL문 실행
			pstmt.executeUpdate();
			
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//파일 삭제
	public void deleteFile(int comm_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			//커넥션풀로부터 커넥션객체 할당
			conn = DBUtil.getConnection();
			//SQL문 작성
			sql = "UPDATE comm SET filename='' WHERE comm_num=?";
			//preparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setInt(1, comm_num);
			//SQL문 실행
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//글 수정
	public void updateComm(CommVO comm)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		
		try {
			//커넥션풀로부터 커넥션 객체 할당
			conn = DBUtil.getConnection();
			
			if(comm.getFilename()!=null) {
				sub_sql += ", filename=?";
			}
			//SQL문 작성
			sql = "UPDATE comm SET comm_title=?,comm_content=?,modify_date=SYSDATE,ip=? "+sub_sql+" WHERE comm_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setString(++cnt, comm.getComm_title());
			pstmt.setString(++cnt, comm.getComm_content());
			pstmt.setString(++cnt, comm.getIp());
			if(comm.getFilename()!=null) {
				pstmt.setString(++cnt, comm.getFilename());
			}
			pstmt.setInt(++cnt, comm.getComm_num());
			//SQL문 실행
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//글 삭제

	//좋아요 등록

	//좋아요 개수

	//회원번호와 게시물 번호를 이용한 좋아요 상세정보

	//좋아요 삭제
	
	//내가 선택한 좋아요 목록

	//댓글 등록

	//댓글 갯수

	//댓글 목록

	//댓글 상세(댓글 수정,삭제 시 작성자 회원번호 체크 용도로 사용)

	//댓글 수정

	//댓글 삭제

}