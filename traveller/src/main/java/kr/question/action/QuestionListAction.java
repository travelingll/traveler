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

		String pageNum = request.getParameter("pageNum");
		if(pageNum==null) pageNum = "1";
		
		String keyword = request.getParameter("keyword");
		String keyfield = request.getParameter("keyfield");
		
		QuestionDAO dao = QuestionDAO.getInstance();
		int count = dao.getQuestionCount(keyword, keyfield, 0);
		
		PageUtil page = new PageUtil(keyfield, keyword, Integer.parseInt(pageNum), count, 10,10,"questionList.do");

		List<QuestionVO> list = null;
		
		if(count>0) {
			list = dao.getQuestionList(keyword, keyfield, page.getStartRow(), page.getEndRow(),0); //키워드,키필드,시작,끝
		}
		
		request.setAttribute("list", list);
		request.setAttribute("count", count);
		request.setAttribute("page", page.getPage());
		
		return "/WEB-INF/views/question/questionList.jsp";
	}
}