package kr.question.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.question.dao.QuestionDAO;
import kr.question.vo.QuestionVO;

public class AdminQuestionWrtieAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//관리자 체크
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		if(user_num==null || user_auth!=9) return "redirect:/question/questionList.do";
		
		request.setCharacterEncoding("utf-8");
		int question_num = Integer.parseInt(request.getParameter("question_num"));
		int question_category = Integer.parseInt(request.getParameter("question_category"));
		
		QuestionDAO dao = QuestionDAO.getInstance();
		QuestionVO user_question = dao.getQuestionDetail(question_num); //원글 정보
		QuestionVO question = new QuestionVO(); //답변글 정보 저장용
		
		//데이터 받기
		question.setMem_num(user_num);
		question.setQuestion_ip(request.getRemoteAddr());
		question.setQuestion_category(question_category); //관리자 답변글의 경우 문의글 카테고리와 같게 설정
		question.setQuestion_title(request.getParameter("question_title"));
		question.setQuestion_lock(user_question.getQuestion_lock()); //잠금 유무는 원글 설정에 따름
		question.setQuestion_content(request.getParameter("question_content"));
		question.setQuestion_level(2); //관리자 답변의 경우 답변 깊이 2
		question.setQuestion_renum(question_num); //원글 번호 저장
		
		dao.writeQuestion(question); //테이블에 insert
		
		request.setAttribute("notice_msg", "답변 작성 완료");
		request.setAttribute("notice_url", "questionDetail.do?question_num="+question_num); //완료 후 상세로 보내기

		return "/WEB-INF/views/common/alert_singleView.jsp";
	}
}