package kr.comm.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.comm.vo.CommFavVO;
import kr.comm.vo.CommReplyVO;
import kr.comm.vo.CommVO;
import kr.util.DBUtil;
import kr.util.DurationFromNow;
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
			sql = "INSERT INTO comm (comm_num, comm_title, comm_content, filename1, filename2, filename3, ip, mem_num, "
					+ "category, tag) "
					+ "VALUES (comm_seq.nextval,?,?,?,?,?,?,?,?,?)";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setString(1, comm.getComm_title());
			pstmt.setString(2, comm.getComm_content());
			pstmt.setString(3, comm.getFilename1());
			pstmt.setString(4, comm.getFilename2());
			pstmt.setString(5, comm.getFilename3());
			pstmt.setString(6, comm.getIp());
			pstmt.setInt(7, comm.getMem_num());
			pstmt.setInt(8, comm.getCategory());
			pstmt.setString(9, comm.getTag());
			
			//SQL문 실행
			pstmt.executeUpdate();
			
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.getConnection();
		}
	}  
	//전체 레코드수/검색 레코드수
	public int getCommCount(String keyfield, String keyword,int mem_num)throws Exception{
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		String sub_sql2 = "";
		int count = 0;
		
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			
			if(keyword!=null && !"".equals(keyword)) {
				//검색 처리
				if(keyfield.equals("1")) sub_sql +="WHERE comm_title LIKE ?";
				else if(keyfield.equals("2")) sub_sql +="WHERE id LIKE ?";
				else if(keyfield.equals("3")) sub_sql +="WHERE comm_content LIKE ?";
			}
			if(mem_num > 0) {
				sub_sql2 += "WHERE mem_num=?";
			}
			//SQL문 작성
			sql = "SELECT * FROM comm JOIN member USING(mem_num) " + sub_sql + sub_sql2;
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			if(keyword != null && !"".equals(keyword)) {
				pstmt.setString(1, "%" + keyword + "%");
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
	public List<CommVO> getListComm(int start, int end, String keyfield, String keyword,int mem_num) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<CommVO> list = null;
		String sql = null;
		String sub_sql = "";
		String sub_sql2 = "";
		int cnt = 0;
		
		try {
			//커넥션풀로부터 커넥션 할당
			conn = DBUtil.getConnection();
			
			if(keyword!=null && !"".equals(keyword)) {
				//검색 처리
				if(keyfield.equals("1")) sub_sql += "WHERE comm_title LIKE ?";
				else if(keyfield.equals("2")) sub_sql += "WHERE id LIKE ?";
				else if(keyfield.equals("3")) sub_sql += "WHERE comm_content LIKE ?";
			}
			if(mem_num > 0) {
				sub_sql2 += "WHERE mem_num=?";
			}
			//SQL문 작성
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM "
					+ "(SELECT * FROM comm JOIN member USING(mem_num) " + sub_sql + sub_sql2
					+ " ORDER BY comm_num DESC)a) WHERE rnum>=? AND rnum <=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			if(keyword!=null && !"".equals(keyword)) {
				pstmt.setString(++cnt, "%" + keyword + "%");
			}
			if(mem_num > 0) {
				pstmt.setInt(++cnt, mem_num);
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
				comm.setCategory(rs.getInt("category"));
				
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
				comm.setFilename1(rs.getString("filename1"));
				comm.setFilename2(rs.getString("filename2"));
				comm.setFilename3(rs.getString("filename3"));
				comm.setMem_num(rs.getInt("mem_num"));
				comm.setId(rs.getString("id"));
				comm.setPhoto(rs.getString("photo"));
				comm.setCategory(rs.getInt("category"));
				comm.setTag(rs.getString("tag"));
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
	public void deleteFile(int comm_num, int filename)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		String sub_sql2 = "";
		String sub_sql3 = "";
		
		
		try {
			
			
			//커넥션풀로부터 커넥션객체 할당
			conn = DBUtil.getConnection();
			
			if(filename == 2) {
				sub_sql2 += " filename2=''";
			}
			if(filename == 3) {
				sub_sql3 += " filename3=''";
			}
			//SQL문 작성
			sql = "UPDATE comm SET " + sub_sql2 + sub_sql3 +" WHERE comm_num=?";
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
		String sub_sql1 = "";
		String sub_sql2 = "";
		String sub_sql3 = "";
		int cnt = 0;
		
		try {
			//커넥션풀로부터 커넥션 객체 할당
			conn = DBUtil.getConnection();
			
			if(comm.getFilename1()!=null) {
				sub_sql1 += ", filename1=?";
			}
			if(comm.getFilename2()!=null) {
				sub_sql2 += ", filename2=?";
			}
			if(comm.getFilename3()!=null) {
				sub_sql3 += ", filename3=?";
			}
			//SQL문 작성
			sql = "UPDATE comm SET comm_title=?,comm_content=?,modify_date=SYSDATE,ip=?,category=?,tag=? "+sub_sql1+sub_sql2+sub_sql3+" WHERE comm_num=?";
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			//?에 데이터 바인딩
			pstmt.setString(++cnt, comm.getComm_title());
			pstmt.setString(++cnt, comm.getComm_content());
			pstmt.setString(++cnt, comm.getIp());
			pstmt.setInt(++cnt, comm.getCategory());
			pstmt.setString(++cnt, comm.getTag());
			
			if(comm.getFilename1()!=null) {
				pstmt.setString(++cnt, comm.getFilename1());
			}
			if(comm.getFilename2()!=null) {
				pstmt.setString(++cnt, comm.getFilename2());
			}
			if(comm.getFilename3()!=null) {
				pstmt.setString(++cnt, comm.getFilename3());
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
	public void deleteComm(int comm_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null;
		String sql = null;
		try {
			//커넥션풀로부터 커넥션 객체 할당
			conn = DBUtil.getConnection();
			//오토커밋 해제
			conn.setAutoCommit(false);
			
			//좋아요 삭제
			sql="DELETE FROM comm_fav WHERE comm_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, comm_num);
			pstmt.executeUpdate();
			//댓글 삭제
			sql = "DELETE FROM comm_reply WHERE comm_num=?";
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, comm_num);
			pstmt2.executeUpdate();
			//부모글 삭제
			sql = "DELETE FROM comm WHERE comm_num=?";
			pstmt3 = conn.prepareStatement(sql);
			pstmt3.setInt(1,comm_num);
			pstmt3.executeUpdate();
			
			conn.commit();
		}catch(Exception e) {
			//하나라도 SQL문이 실패하면
			conn.rollback();
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt3, null);
			DBUtil.executeClose(null, pstmt2, null);
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//좋아요 등록
	public void insertFav(CommFavVO favVO)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			conn = DBUtil.getConnection();
			 
			sql="INSERT INTO comm_fav (comm_num,mem_num) "
					+ "VALUES (?,?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, favVO.getComm_num());
			pstmt.setInt(2, favVO.getMem_num());
		
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	//좋아요 개수
	public int selectFavCount(int comm_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		
		try {
			conn = DBUtil.getConnection();
			
			sql="SELECT COUNT(*) FROM comm_fav WHERE comm_num=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, comm_num);
			
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
	//회원번호와 게시물 번호를 이용한 좋아요 상세정보
	public CommFavVO selectFav(CommFavVO favVO)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CommFavVO fav =null;
		String sql = null;
		
		try {
			//커넥션풀로부터 커넥션을 할당
			conn =  DBUtil.getConnection();
			
			sql = "SELECT * FROM comm_fav WHERE comm_num=? AND mem_num=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, favVO.getComm_num());
			pstmt.setInt(2, favVO.getMem_num());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				fav = new CommFavVO();
				fav.setComm_num(rs.getInt("comm_num"));
				fav.setMem_num(rs.getInt("mem_num"));
			}
			  
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs,pstmt,conn);
		}
		return fav;
	}
	//좋아요 삭제
	public void deleteFav(CommFavVO favVO)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			//커넥션풀로부터 커넥션을 할당
			conn =  DBUtil.getConnection();
			
			sql="DELETE FROM comm_fav WHERE comm_num=? AND mem_num=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, favVO.getComm_num());
			pstmt.setInt(2, favVO.getMem_num());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null,pstmt,conn);
		}
	}
	//내가 선택한 좋아요 목록
	public List<CommVO> getListCommFav(int start, int end, int mem_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<CommVO> list = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM "
					+ "JOIN comm_fav f USING(comm_num) WHERE f.mem_num=? "
					+ "ORDER BY comm_num DESC)a) WHERE rnum >= ? AND rnum <=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, mem_num);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs=pstmt.executeQuery();
			list = new ArrayList<CommVO>();
			while(rs.next()) {
				CommVO comm = new CommVO();
				comm.setComm_num(rs.getInt("comm_num"));
				comm.setComm_title(rs.getString("comm_title"));
				comm.setReg_date(rs.getDate("reg_date"));
				comm.setId(rs.getString("id"));
				
				list.add(comm);
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null,pstmt,conn);
		}
		return list;
	}
	//댓글 등록
	public void insertReplyComm(CommReplyVO commReply)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn =  DBUtil.getConnection();
		
			sql = "INSERT INTO comm_reply (comm_renum,comm_recontent,"
				+ "comm_reip,mem_num,comm_num) VALUES (comm_reply_seq.nextval,?,?,?,?)";
	
			//PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
		
			pstmt.setString(1, commReply.getComm_recontent());
			pstmt.setString(2, commReply.getComm_reip());
			pstmt.setInt(3, commReply.getMem_num());
			pstmt.setInt(4, commReply.getComm_num());
		
			pstmt.executeUpdate();
		
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null,pstmt,conn);
		}
	}
	
	//댓글 갯수
	public int getReplyCommCount(int comm_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		
		
				
		try {
			conn =  DBUtil.getConnection();
			
			sql = "SELECT COUNT(*) FROM comm_reply JOIN member "
					+ "USING(mem_num) WHERE comm_num=?";		
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, comm_num);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		}catch(Exception e) {			
			throw new Exception(e);
		}finally {	
			DBUtil.executeClose(rs,pstmt,conn);
		}
						
		
		return count;
	}
	//댓글 목록
	public List<CommReplyVO> getListReplyComm(int start, int end, int comm_num)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<CommReplyVO> list = null;
		String sql = null;
		
		try {
			conn =  DBUtil.getConnection();
			
			sql = "SELECT * FROM (SELECT a.*, rownum rnum FROM "
					+ "(SELECT * FROM comm_reply JOIN member "
					+ "USING(mem_num) WHERE comm_num=? "
					+ "ORDER BY comm_renum DESC)a) WHERE rnum >= ? AND rnum <= ?";		
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, comm_num);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			
			rs = pstmt.executeQuery();
			list = new ArrayList<CommReplyVO>();
			while(rs.next()) {
				CommReplyVO reply = new CommReplyVO();
				reply.setComm_renum(rs.getInt("comm_renum"));
				reply.setComm_redate(DurationFromNow.getTimeDiffLabel(rs.getString("comm_redate")));
				if(rs.getString("comm_remodifydate")!=null) {
					reply.setComm_remodifydate(DurationFromNow.getTimeDiffLabel(rs.getString("comm_remodifydate")));
				}
				reply.setComm_recontent(StringUtil.useBrNoHtml(rs.getString("Comm_recontent")));
				reply.setComm_num(rs.getInt("comm_num"));
				reply.setMem_num(rs.getInt("mem_num"));
				reply.setId(rs.getString("id"));
				
				list.add(reply);
			}
			
		}catch(Exception e) {			
			throw new Exception(e);
		}finally {	
			DBUtil.executeClose(rs,pstmt,conn);
		}
		
		return list;
	}
	//댓글 상세(댓글 수정,삭제 시 작성자 회원번호 체크 용도로 사용)
	public CommReplyVO getReplyComm(int comm_renum)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CommReplyVO reply = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			
			sql = "SELECT * FROM comm_reply WHERE comm_renum=?";
			
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setInt(1,comm_renum);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				reply = new CommReplyVO();
				reply.setComm_renum(rs.getInt("comm_renum"));
				reply.setMem_num(rs.getInt("mem_num"));
			}
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(rs,pstmt,conn);
		}
		
		return reply;
	}
	public void updateReplyComm(CommReplyVO reply)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			
			sql = "UPDATE comm_reply SET comm_recontent=?, "
					+ "comm_remodifydate=SYSDATE, comm_reip=? WHERE comm_renum=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, reply.getComm_recontent());
			pstmt.setString(2, reply.getComm_reip());
			pstmt.setInt(3, reply.getComm_renum());
			
			pstmt.executeUpdate();
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null,pstmt,conn);
		}
	}
	//댓글 삭제
	public void deleteReplyComm(int comm_renum)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			
			sql = "DELETE FROM comm_reply WHERE comm_renum=?";
			
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setInt(1,comm_renum);
			
			pstmt.executeUpdate();
			
			
		}catch(Exception e) {
			throw new Exception(e);
		}finally {
			DBUtil.executeClose(null,pstmt,conn);
		}
		
		return ;
	
	}
	
}


