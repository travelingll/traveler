package kr.question.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.question.dao.QuestionDAO;
import kr.question.vo.QuestionVO;
import kr.util.PageUtil;

public class QuestionListAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("utf-8");
		
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null) pageNum = "1";
		
		String keyword = request.getParameter("keyword");
		String keyfield = request.getParameter("keyfield");
		String question_category = request.getParameter("question_category");

		QuestionDAO dao = QuestionDAO.getInstance();
		int count = dao.getQuestionCount(keyword, keyfield, 0, question_category);
		
		PageUtil page = new PageUtil(keyfield, keyword, Integer.parseInt(pageNum), count, 10,10,"questionList.do");
		
		List<QuestionVO> list = null;
		
		if(count>0) list = dao.getQuestionList(keyword, keyfield, page.getStartRow(), page.getEndRow(),0, question_category);
		
		request.setAttribute("list", list);
		request.setAttribute("count", count);
		request.setAttribute("page", page.getPage());
		request.setAttribute("category", question_category);
		
		return "/WEB-INF/views/question/questionList.jsp";
	}
}