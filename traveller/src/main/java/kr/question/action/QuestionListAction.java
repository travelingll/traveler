package kr.question.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.question.dao.QuestionDAO;
import kr.question.vo.QuestionVO;

public class QuestionListAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		QuestionDAO dao = QuestionDAO.getInstance();
		List<QuestionVO> list = dao.getQuestionList(null, null, 1, 10,0); //키워드,키필드,시작,끝
		
		request.setAttribute("list", list);
		
		return "/WEB-INF/views/question/questionList.jsp";
	}
}