package kr.item.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.item.dao.ItemDAO;
import kr.item.vo.ItemVO;
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
		Integer order_status = orderDao.getOrderUsed(item_num, user_num);
		
		request.setAttribute("item", item);
		request.setAttribute("user_num", user_num);
		request.setAttribute("user_auth", user_auth);
		request.setAttribute("order_status", order_status);
		
		
		
		return "/WEB-INF/views/item/itemDetail.jsp";
		
	
	}

}
