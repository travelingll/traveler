package kr.item.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.item.dao.ItemDAO;
import kr.item.vo.ItemVO;
import kr.itemreply.dao.ItemReplyDAO;
import kr.itemreply.vo.ItemReplyVO;
import kr.order.dao.OrderDAO;

public class ItemDetailAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		int item_num = Integer.parseInt(request.getParameter("item_num"));
		
		
		ItemDAO dao = ItemDAO.getInstance();
		ItemVO item = dao.getItem(item_num);
		
		OrderDAO orderDao = OrderDAO.getInstance();
		if(user_num!=null) {
			Integer order_status = orderDao.getOrderUsed(item_num, user_num);
			request.setAttribute("order_status", order_status);
			ItemReplyDAO reDao = ItemReplyDAO.getInstance();
			Integer replyUsed = reDao.getReplyUsed(user_num, item_num);
			request.setAttribute("replyUsed", replyUsed);
			
		}
		
		String item_st1 = dao.getItem_st1(item_num);
		String item_case = dao.getItem_case(item_num);
		
		
		ItemReplyDAO reDaoo = ItemReplyDAO.getInstance();
		List<ItemReplyVO> replyList = reDaoo.getItemReply(item_st1, item_case);
		
		
		List<ItemVO> pickList = dao.getItemRecommendList(3);
		
		
		request.setAttribute("item", item);
		request.setAttribute("user_num", user_num);
		request.setAttribute("user_auth", user_auth);
		request.setAttribute("replyList", replyList);
		request.setAttribute("pickList", pickList);
		
		return "/WEB-INF/views/item/itemDetail.jsp";
		
	
	}

}
