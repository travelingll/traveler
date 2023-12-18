package kr.question.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;

public class AdminQuestionWirteFormAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		int user_auth = (Integer)session.getAttribute("user_auth");
		
		if(user_auth!=9) 
			return "redirect:/question/questionList.do";
		
		//question_num 얻어서 보내주기
		int question_num = Integer.parseInt(request.getParameter("question_num"));
		request.setAttribute("question_num", question_num);
		
		return "/WEB-INF/views/question/adminQuestionWriteForm.jsp";
	}
}