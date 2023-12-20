package kr.order.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.order.dao.OrderDAO;
import kr.order.vo.OrderVO;

public class MyOrderListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {
			return "redirect:/member/loginForm.do";
		}
		
		OrderDAO dao = OrderDAO.getInstance();
		int count = dao.getOrderCount(null, null, user_num);
		List<OrderVO> list = null;
		if(count > 0) {
			list = dao.getOrderList(1, 10, null, null, user_num);
		}
		
		
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		
		return "/WEB-INF/views/order/myOrderList.jsp";
	}

}
