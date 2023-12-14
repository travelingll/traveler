package kr.question.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import kr.question.vo.QuestionVO;
import kr.util.DBUtil;

public class QuestionDAO {
	
	private static QuestionDAO instance = new QuestionDAO();
	
	public static QuestionDAO getInstance() {
		return instance;
	}
	
	private QuestionDAO (){}
	
	//글 등록
	public void writeQuestion(QuestionVO question) throws Exception {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = null;
		String sub_sql = "";
		String sub_sql2 = "";
		int cnt = 0;
		
		try {
			
			conn = DBUtil.getConnection();
			
			if((Integer)question.getMem_num()!=0) { //로그인한 사용자의 경우 (로그인하지 않은 사용자의 mem_num은 0, 삽입x)
				sub_sql += "mem_num,";
				sub_sql2 += ",?";
			}
			
			sql = "INSERT INTO question (question_num,question_ip,"+ sub_sql
					+ "question_category,question_title,question_lock,question_passwd,"
					+ "question_photo,question_content,question_level) "
					+ "VALUES (question_seq.nextval,?,?,?,?,?,?,?,?" + sub_sql2 + ")";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(++cnt, question.getQuestion_ip());
			
			if(question.getMem_num()!=0) { //로그인한 사용자의 경우 (로그인하지 않은 사용자의 mem_num은 0, 삽입하지않고 null 처리)
				pstmt.setInt(++cnt, question.getMem_num());
			}
			pstmt.setString(++cnt, question.getQuestion_category());
			pstmt.setString(++cnt, question.getQuestion_title());
			pstmt.setInt(++cnt, question.getQuestion_lock());
			pstmt.setString(++cnt, question.getQuestion_passwd());
			pstmt.setString(++cnt, question.getQuestion_photo());
			pstmt.setString(++cnt, question.getQuestion_content());
			pstmt.setInt(++cnt, question.getQuestion_level());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(null, pstmt, conn);
		}
	}
	
	//글 갯수
	public int getQuestionCount(String keyword, String keyfield, int mem_num) throws Exception {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String sub_sql = "";
		String sub_sql2 = "";
		int count = 0;
		
		try {
			conn = DBUtil.getConnection();
			
			if(keyword!=null && !"".equals(keyword)) { //검색 처리
				if(keyfield.equals("1")) sub_sql += "WHERE question_title LIKE ?"; //제목
				else if(keyfield.equals("2")) sub_sql += "WHERE question_content LIKE ?"; //내용
			}
			if(mem_num > 0) {
				sub_sql2 += "WHERE mem_num=?";
			}
			sql = "SELECT COUNT(*) FROM question JOIN member USING(mem_num) " + sub_sql;
			
			pstmt = conn.prepareStatement(sub_sql);
			
			if(keyword!=null && !"".equals(keyword)) { //검색 처리
				if(keyfield.equals("1")) pstmt.setString(1, "%"+keyword+"%");
				else if(keyfield.equals("2")) pstmt.setString(1, "%"+keyword+"%");
			}
			if(mem_num > 0) {
				pstmt.setInt(1, mem_num);
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

	//글 목록
	public List<QuestionVO> getQuestionList(String keyword, String keyfield, int start, int end, int mem_num) throws Exception {
		//검색 처리, 페이지 처리
		
		Connection conn = null;
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		List<QuestionVO> list = null;
		String sql = null;
		String sub_sql = "";
		String sub_sql2 = "";
		int cnt = 0;
		
		try {
			conn = DBUtil.getConnection();
			
			conn.setAutoCommit(false);
			
			//sql = "SELECT mem_num FROM question";
			//pstmt1 = conn.prepareStatement(sql);
			//rs = pstmt1.executeQuery();
			
			
			
			if(keyword!=null && !"".equals(keyword)) {
				if(keyfield.equals("1")) sub_sql += "WHERE question_title LIKE ?";
				else if(keyfield.equals("2")) sub_sql += "WHERE question_content LIKE ?";
			}
			if(mem_num > 0) {
				sub_sql2 += "WHERE mem_num=?";
			}
			sql = "SELECT * FROM (SELECT a.*,rownum rnum FROM (SELECT * FROM question "
					+ sub_sql 
					+ " ORDER BY question_num DESC)a) WHERE rnum>=? AND rnum<=?";
			
			pstmt2 = conn.prepareStatement(sql);
			
			if(keyword!=null && !"".equals(keyword)) { //검색 처리
				if(keyfield.equals("1")) pstmt2.setString(++cnt, "%"+keyword+"%");
				else if(keyfield.equals("2")) pstmt2.setString(++cnt, "%"+keyword+"%");
			}
			if(mem_num > 0) {
				pstmt2.setInt(++cnt, mem_num);
			}
			pstmt2.setInt(++cnt, start);
			pstmt2.setInt(++cnt, end);
			
			rs = pstmt2.executeQuery();
			list = new ArrayList<QuestionVO>();
			
			while(rs.next()) {
				QuestionVO question = new QuestionVO();
				
				question.setQuestion_category(rs.getString("question_category"));
				question.setQuestion_title(rs.getString("question_title"));
				question.setMem_num(rs.getInt("mem_num"));
				question.setQuestion_regdate(rs.getDate("question_regdate"));
				question.setQuestion_hit(rs.getInt("question_hit"));
				
				list.add(question);
			}
			
			conn.commit();
		} catch (Exception e) {
			conn.rollback();
			throw new Exception(e);
		} finally {
			DBUtil.executeClose(null, pstmt2, null);
			DBUtil.executeClose(rs, pstmt1, conn);
		}
		return list;
	}
	
	//조회수 증가
	
	
	//글 상세
	
	
	//파일 삭제
	
	
	//글 수정
	
	
	//글 삭제
	
	
}
