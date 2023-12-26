package kr.question.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.member.dao.MemberDAO;
import kr.question.vo.QuestionVO;
import kr.util.DBUtil;
import kr.util.StringUtil;

public class QuestionDAO {
	
	private static QuestionDAO instance = new QuestionDAO();
	
	public static QuestionDAO getInstance() {
		return instance;
	}
	
	private QuestionDAO (){}
	
	//글 등록
	public int writeQuestion(QuestionVO question) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		String sub_sql2 = "";
		int cnt = 0;
		int question_num = 0;
		
		try {
			conn = DBUtil.getConnection();
			conn.setAutoCommit(false);
			
			/*------시퀀스 생성------*/
			sql = "SELECT question_seq.nextval FROM dual";
			pstmt1 = conn.prepareStatement(sql);
			rs = pstmt1.executeQuery();
			if(rs.next()) question_num = rs.getInt(1);
			
			/*------테이블에 데이터 삽입------*/
			if((Integer)question.getMem_num()!=0) { //로그인한 사용자의 경우 (로그인하지 않은 사용자의 mem_num은 0, 삽입x)
				sub_sql += "mem_num,";
				sub_sql2 += ",?";
			}
			sql = "INSERT INTO question (question_num,question_ip,"+ sub_sql
					+ "question_category,question_title,question_lock,question_passwd,"
					+ "question_photo,question_content,question_level) "
					+ "VALUES (?,?,?,?,?,?,?,?,?" + sub_sql2 + ")";
			
			pstmt2 = conn.prepareStatement(sql);
			
			pstmt2.setInt(++cnt, question_num);
			pstmt2.setString(++cnt, question.getQuestion_ip());
			if(question.getMem_num()!=0) { //로그인한 사용자의 경우 (로그인하지 않은 사용자의 mem_num은 0, 삽입하지않고 null 처리)
				pstmt2.setInt(++cnt, question.getMem_num());
			}
			pstmt2.setInt(++cnt, question.getQuestion_category());
			pstmt2.setString(++cnt, question.getQuestion_title());
			pstmt2.setInt(++cnt, question.getQuestion_lock());
			pstmt2.setString(++cnt, question.getQuestion_passwd());
			pstmt2.setString(++cnt, question.getQuestion_photo());
			pstmt2.setString(++cnt, question.getQuestion_content());
			pstmt2.setInt(++cnt, question.getQuestion_level());
			
			pstmt2.executeUpdate();
			
			/*------답변글: 원글에 답변글 프라이머리 키 저장------*/
			if(question.getQuestion_level()==2) {
				sql = "UPDATE question SET question_renum=? WHERE question_num=?";
				pstmt3 = conn.prepareStatement(sql);
				pstmt3.setInt(1, question_num);//답변글 프라이머리 키
				pstmt3.setInt(2, question.getQuestion_renum());//원글 프라이머리 키
				pstmt3.executeUpdate();
			}
			
			conn.commit();
		} catch (Exception e) {
			conn.rollback();
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(null, pstmt3, null);
			DBUtil.executeClose(null, pstmt2, null);
			DBUtil.executeClose(rs, pstmt1, conn);
		}
		
		return question_num;
	}
	
	//글 갯수
	public int getQuestionCount(String keyword, String keyfield, int mem_num, String category) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		String sub_sql2 = ""; //카테고리 검색용
		String sub_sql3 = ""; //mem_num 사용
		int count = 0;
		int cnt = 0;
		
		try {
			conn = DBUtil.getConnection();
			
			if(keyword!=null && !"".equals(keyword)) { //검색 시
				if(keyfield.equals("1")) sub_sql += " WHERE question_title LIKE ? "; //제목
				else if(keyfield.equals("2")) sub_sql += " WHERE question_content LIKE ? "; //내용
				
				if(category!=null && !"".equals(category)) sub_sql2 += " AND question_category=? "; //검색+카테고리
				if(mem_num > 0) sub_sql3 += " AND mem_num=? "; //검색+mem_num or 검색+카테고리+mem_num
			} else {
				if(category!=null && !"".equals(category)) { //미검색+카테고리
					sub_sql2 += " WHERE question_category=? ";
					if(mem_num > 0) sub_sql3 += " AND mem_num=? "; //미검색+카테고리+mem_num
				} else {
					if(mem_num > 0) sub_sql3 += " WHERE mem_num=? "; //미검색+mem_num
				}
			}

			sql = "SELECT COUNT(*) FROM question " + sub_sql + sub_sql2 + sub_sql3;
			
			pstmt = conn.prepareStatement(sql);
			
			if(keyword!=null && !"".equals(keyword)) pstmt.setString(++cnt, "%"+keyword+"%");
			if(category!=null) pstmt.setInt(++cnt, Integer.parseInt(category));
			if(mem_num > 0) pstmt.setInt(++cnt, mem_num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) count = rs.getInt(1);
			
		} catch (Exception e) {
			throw new Exception();
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return count;
	}

	//글 목록
	public List<QuestionVO> getQuestionList(String keyword, String keyfield, int start, int end, int mem_num, String category) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<QuestionVO> list = null;
		String sql = null;
		String sub_sql = "";
		String sub_sql2 = "";
		String sub_sql3 = "";
		int cnt = 0;
		
		try {
			conn = DBUtil.getConnection();

			if(keyword!=null && !"".equals(keyword)) { //검색 시
				if(keyfield.equals("1")) sub_sql += " WHERE question_title LIKE ? "; //제목
				else if(keyfield.equals("2")) sub_sql += " WHERE question_content LIKE ? "; //내용
				
				if(category!=null && !"".equals(category)) sub_sql2 += " AND question_category=? "; //검색+카테고리
				if(mem_num > 0) sub_sql3 += " AND mem_num=? "; //검색+mem_num or 검색+카테고리+mem_num
			} else {
				if(category!=null && !"".equals(category)) { //미검색+카테고리
					sub_sql2 += " WHERE question_category=? ";
					if(mem_num > 0) sub_sql3 += " AND mem_num=? "; //미검색+카테고리+mem_num
				} else {
					if(mem_num > 0) sub_sql3 += " WHERE mem_num=? "; //미검색+mem_num
				}
			}
			sql = "SELECT * FROM (SELECT a.*,rownum rnum FROM (SELECT * FROM question "
					+ sub_sql + sub_sql2 + sub_sql3
					+ " ORDER BY question_num DESC)a) WHERE rnum>=? AND rnum<=?";
			pstmt = conn.prepareStatement(sql);
			
			if(keyword!=null && !"".equals(keyword)) pstmt.setString(++cnt, "%"+keyword+"%");
			if(category!=null) pstmt.setInt(++cnt, Integer.parseInt(category));
			if(mem_num > 0) pstmt.setInt(++cnt, mem_num);
			pstmt.setInt(++cnt, start);
			pstmt.setInt(++cnt, end);
			
			rs = pstmt.executeQuery();
			list = new ArrayList<QuestionVO>();
			
			while(rs.next()) {
				QuestionVO question = new QuestionVO();
				
				question.setQuestion_num(rs.getInt("question_num"));
				question.setQuestion_category(rs.getInt("question_category"));
				question.setQuestion_title(StringUtil.useBrNoHtml(rs.getString("question_title")));
				if(rs.getInt("mem_num")!=0) { //mem_num이 0이 아니면 회원, 이름 얻어오기
					MemberDAO dao = MemberDAO.getInstance();
					question.setName(dao.getMember(rs.getInt("mem_num")).getName());
				}
				question.setQuestion_regdate(rs.getDate("question_regdate"));
				question.setQuestion_hit(rs.getInt("question_hit"));
				question.setQuestion_lock(rs.getInt("question_lock"));
				question.setQuestion_renum(rs.getInt("question_renum"));
				question.setQuestion_level(rs.getInt("question_level"));
				
				list.add(question);
			}
		} catch (Exception e) {

			throw new Exception(e);
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return list;
	}

	//글 상세
	public QuestionVO getQuestionDetail(int question_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		QuestionVO question = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "SELECT * FROM question WHERE question_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, question_num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				question = new QuestionVO();
				
				question.setQuestion_num(rs.getInt("question_num"));
				if(rs.getInt("mem_num")!=0) { //회원 문의글의 경우
					question.setMem_num(rs.getInt("mem_num"));
					MemberDAO dao = MemberDAO.getInstance();
					question.setName(dao.getMember(rs.getInt("mem_num")).getName());
				}
				question.setQuestion_ip(rs.getString("question_ip"));
				question.setQuestion_category(rs.getInt("question_category"));
				question.setQuestion_title(StringUtil.useBrNoHtml(rs.getString("question_title")));
				question.setQuestion_lock(rs.getInt("question_lock"));
				question.setQuestion_passwd(rs.getString("question_passwd"));
				question.setQuestion_photo(rs.getString("question_photo"));
				question.setQuestion_content(StringUtil.useBrNoHtml(rs.getString("question_content")));
				question.setQuestion_regdate(rs.getDate("question_regdate"));
				question.setQuestion_modifydate(rs.getDate("question_modifydate"));
				question.setQuestion_level(rs.getInt("question_level"));
				question.setQuestion_hit(rs.getInt("question_hit"));
				question.setQuestion_renum(rs.getInt("question_renum"));
			}
		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
		return question;
	}
	
	//조회수 증가
	public void updateHit(int question_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "UPDATE question SET question_hit=question_hit+1 WHERE question_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, question_num);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(rs, pstmt, conn);
		}
	}
	
	//파일 삭제
	public void deleteQuestionPhoto(int question_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "UPDATE question SET question_photo='' WHERE question_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, question_num);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//글 수정
	public void modifyQuestion(QuestionVO question) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		String sub_sql = "";
		int cnt = 0;
		
		try {
			conn = DBUtil.getConnection();
			
			if(question.getQuestion_photo()!=null) sub_sql += ",question_photo=?";
			sql = "UPDATE question SET question_ip=?,question_title=?,"
					+ "question_content=?,question_modifydate=SYSDATE,question_category=?"
					+sub_sql + " WHERE question_num=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(++cnt, question.getQuestion_ip());
			pstmt.setString(++cnt, question.getQuestion_title());
			pstmt.setString(++cnt, question.getQuestion_content());
			pstmt.setInt(++cnt, question.getQuestion_category());
			if(question.getQuestion_photo()!=null) {
				pstmt.setString(++cnt, question.getQuestion_photo());
			}
			pstmt.setInt(++cnt, question.getQuestion_num());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//글 삭제
	public void deleteQuestion(int question_num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		
		try {
			conn = DBUtil.getConnection();
			sql = "DELETE FROM question WHERE question_num=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, question_num);
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
}