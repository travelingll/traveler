package kr.order.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.order.dao.OrderDAO;
import kr.order.vo.OrderDetailVO;
import kr.order.vo.OrderVO;

public class UserOrderDetailAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//로그인 체크
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num==null) return "redirect:/member/loginForm.do";
		
		//회원 정보 일치 체크
		int order_num = Integer.parseInt(request.getParameter("order_num"));
		OrderDAO dao = OrderDAO.getInstance();
		OrderVO db_order = dao.getOrder(order_num, user_num); //
		if(db_order.getMem_num()!=user_num) return "redirect:/main/main.do";
		
		//상세 정보 얻어오기
		List<OrderDetailVO> detailList = dao.getListOrderDetailVO(order_num);
		
		//상세 정보 넘겨주기
		request.setAttribute("detail", detailList);
		request.setAttribute("order", db_order);
		
		return "/WEB-INF/views/order/userOrderDetail.jsp";
	}
}