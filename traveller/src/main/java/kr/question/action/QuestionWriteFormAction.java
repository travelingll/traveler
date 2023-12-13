package kr.question.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;

public class QuestionWriteFormAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		int user_num = (Integer)session.getAttribute("user_num");
		
		request.setAttribute("user_num", user_num);
		
		return "/WEB-INF/views/question/questionWriteForm.jsp";
	}
}