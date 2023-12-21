package kr.recommend.action;

import java.util.ArrayList;
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
		
	    String[] style1Values = recDao.getStyleArray("style1", user_num);
		String[] style2Values = recDao.getStyleArray("style2", user_num);
		String[] style3Values = recDao.getStyleArray("style3", user_num);
		
		// 추천 상품 리스트 초기화
		List<ItemVO> itemList = new ArrayList<>();

		// 대표 상품 가져오기 (최근 날짜 순으로 정렬)
		ItemVO representativeItem1 = recDao.getRepresentativeItemByStyle(style1Values);
		ItemVO representativeItem2 = recDao.getRepresentativeItemByStyle(style2Values);
		ItemVO representativeItem3 = recDao.getRepresentativeItemByStyle(style3Values);

		// 대표 상품을 리스트에 추가
		if (representativeItem1 != null) {
		    itemList.add(representativeItem1);
		}
		if (representativeItem2 != null) {
		    itemList.add(representativeItem2);
		}
		if (representativeItem3 != null) {
		    itemList.add(representativeItem3);
		}
		
		PageUtil page = new PageUtil(null, null, Integer.parseInt(pageNum), itemList.size(), 10, 10, "userRecommend.do");
		
		request.setAttribute("itemList", itemList);
		request.setAttribute("page", page.getPage());

		return "/WEB-INF/views/recommend/userRecommend.jsp";
	}

}
		
