package kr.question.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.question.dao.QuestionDAO;
import kr.question.vo.QuestionVO;

public class AdminQuestionModifyFormAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		int user_auth = (Integer)session.getAttribute("user_auth");
		
		if(user_auth!=9) //관리자 외 출입금지
			return "redirect:/question/questionList.do";
		
		QuestionDAO dao = QuestionDAO.getInstance();
		
		int question_num = Integer.parseInt(request.getParameter("question_num")); //원글 번호를 받음
		QuestionVO question = dao.getQuestionDetail(question_num); //원글 정보를 받음
		QuestionVO re_question = dao.getQuestionDetail(question.getQuestion_renum()); //답변글 정보를 받음
		
		request.setAttribute("re_question", re_question); //답변글 정보를 넘겨줌
		request.setAttribute("question", question); //원글 정보를 넘겨줌
		
		return "/WEB-INF/views/question/adminQuestionModifyForm.jsp";
	}
}