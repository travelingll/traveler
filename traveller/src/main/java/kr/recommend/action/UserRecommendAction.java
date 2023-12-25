package kr.recommend.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.item.vo.ItemVO;
import kr.recommend.dao.RecommendDAO;
import kr.util.PageUtil;

public class UserRecommendAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) { //로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) pageNum = "1";
		
		RecommendDAO recDao = RecommendDAO.getInstance();
		int count = recDao.getRecommendCount(user_num);
		PageUtil page = new PageUtil(null,null,Integer.parseInt(pageNum),count,10,10,request.getContextPath()+"/recommend/userRecommend.do");
		List<ItemVO> list = recDao.getRecommendedItems(page.getStartRow(), page.getEndRow(), user_num);
		
		request.setAttribute("count", count);
		request.setAttribute("page", page.getPage());
		request.setAttribute("list", list);

		return "/WEB-INF/views/recommend/userRecommend.jsp";
	}

}
		
