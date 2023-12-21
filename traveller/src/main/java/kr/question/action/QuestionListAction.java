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
		String question_category = request.getParameter("question_category"); //카테고리를 받음
		
		int category = 0; //카테고리 미선택 시 전체 출력 
		if(question_category!=null) {
			category = Integer.parseInt(question_category); //카테고리 선택 시 해당 카테고리 글만 보이도록
		} 
		
		QuestionDAO dao = QuestionDAO.getInstance();
		int count = dao.getQuestionCount(keyword, keyfield, 0, category);
		System.out.println(count);
		
		PageUtil page = new PageUtil(keyfield, keyword, Integer.parseInt(pageNum), count, 10,10,"questionList.do");
		
		List<QuestionVO> list = null;
		
		if(count>0) {
			list = dao.getQuestionList(keyword, keyfield, page.getStartRow(), page.getEndRow(),0, category); //키워드,키필드,시작,끝
		}
		
		request.setAttribute("list", list);
		request.setAttribute("count", count);
		request.setAttribute("page", page.getPage());
		request.setAttribute("category", category);
		
		return "/WEB-INF/views/question/questionList.jsp";
	}
}