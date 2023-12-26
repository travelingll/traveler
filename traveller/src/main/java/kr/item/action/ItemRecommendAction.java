package kr.item.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.item.dao.ItemDAO;
import kr.item.vo.ItemVO;

public class ItemRecommendAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		ItemDAO dao = ItemDAO.getInstance();
		List<ItemVO> list = dao.getItemRecommendList(10);
		
		request.setAttribute("list", list);

		return "/WEB-INF/views/recommend/adminRecommend.jsp";
		
		
	}
	
}
