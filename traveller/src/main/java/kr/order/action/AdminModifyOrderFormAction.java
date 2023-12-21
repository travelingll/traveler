package kr.order.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.order.dao.OrderDAO;
import kr.order.vo.OrderDetailVO;
import kr.order.vo.OrderVO;

public class AdminModifyOrderFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		
		if(user_num==null) {//로그인 되지 않은 경우
			return "redirect:/member/login.do";
		}
		
		if(user_auth !=9) {//관리자로 로그인되지 않은 경우
			return "redirect:/member/login.do";
		}
		
		int order_num = Integer.parseInt(request.getParameter("order_num"));
		
		OrderDAO dao = OrderDAO.getInstance();
		OrderVO vo = dao.getOrder(order_num, 0);
		
		List<OrderDetailVO> detailList = null;
		
		
		
		
		return "/WEB-INF/views/admin/adminModifyOrderForm.jsp";
	}

}
