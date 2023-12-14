package kr.question.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import kr.controller.Action;
import kr.question.dao.QuestionDAO;
import kr.question.vo.QuestionVO;
import kr.util.FileUtil;

public class QuestionWriteAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		QuestionVO question = new QuestionVO();
		MultipartRequest multi = FileUtil.createFile(request);
		
		if(session.getAttribute("user_num")!=null) { //로그인된 사용자의 경우
			question.setMem_num((Integer)session.getAttribute("user_num"));
		} else { //로그인하지 않은 사용자의 경우
			question.setMem_num(0);
		}
		question.setQuestion_ip(request.getRemoteAddr()); 
		question.setQuestion_category(multi.getParameter("question_category"));
		question.setQuestion_title(multi.getParameter("question_title"));
		question.setQuestion_lock(Integer.parseInt(multi.getParameter("question_lock")));
		if(multi.getParameter("question_passwd") != null) { //비회원 글 작성 시 비밀번호 설정
			question.setQuestion_passwd(multi.getParameter("question_passwd"));
		}
		question.setQuestion_photo(multi.getFilesystemName("question_photo"));
		question.setQuestion_content(multi.getParameter("question_content"));
		if( session.getAttribute("user_num")!=null && (int)session.getAttribute("user_num")==9) question.setQuestion_level(2); //관리자의 경우 답변 레벨 2
		else question.setQuestion_level(1); //관리자 외 회원 진입 시 답변 레벨 1
		
		
		QuestionDAO dao = QuestionDAO.getInstance();
		dao.writeQuestion(question);
		
		return "/WEB-INF/views/question/questionWrite.jsp";
	}
}