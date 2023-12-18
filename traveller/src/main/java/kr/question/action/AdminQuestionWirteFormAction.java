package kr.question.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.question.dao.QuestionDAO;
import kr.question.vo.QuestionVO;

public class AdminQuestionWirteFormAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		int user_auth = (Integer)session.getAttribute("user_auth");
		
		if(user_auth!=9) 
			return "redirect:/question/questionList.do";
		
		//원글 내용 불러오기
		QuestionDAO dao = QuestionDAO.getInstance();
		int question_num = Integer.parseInt(request.getParameter("question_num"));
		QuestionVO question = dao.getQuestionDetail(question_num);
		
		request.setAttribute("question", question);
		
		return "/WEB-INF/views/question/adminQuestionWriteForm.jsp";
	}
}