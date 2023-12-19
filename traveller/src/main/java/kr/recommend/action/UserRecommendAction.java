package kr.recommend.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.item.vo.ItemVO;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;
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
		
		//로그인이 된 경우
		MemberDAO dao = MemberDAO.getInstance();
		MemberVO member = dao.getMember(user_num);
		
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) pageNum = "1";
		
		RecommendDAO recDao = RecommendDAO.getInstance();
		int count = recDao.getRecommendCount("2");
		
		PageUtil page = new PageUtil(null,null,Integer.parseInt(pageNum),count,5,5,"userRecommend.do");
		List<ItemVO> list = null;
		if(count > 0) {
			list = recDao.getRecommendList(page.getStartRow(), page.getEndRow(), "2");
		}
		
		request.setAttribute("member", member);
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		request.setAttribute("page", page.getPage());
		
		return "/WEB-INF/views/recommend/userRecommend.jsp";
	}

}
