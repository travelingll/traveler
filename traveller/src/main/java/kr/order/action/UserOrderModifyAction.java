package kr.order.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.order.dao.OrderDAO;
import kr.order.vo.OrderVO;

public class UserOrderModifyAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		
		//로그인 체크
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num==null) return "redirect:/member/loginForm.do";
		
		//고객 일치 체크
		int order_num = Integer.parseInt(request.getParameter("order_num"));
		OrderDAO dao = OrderDAO.getInstance();
		OrderVO db_order = dao.getOrder(order_num, user_num);
		if(db_order.getMem_num()!=user_num) return "redirect:/main/main.do";
		
		OrderVO order = new OrderVO();
		
		order.setOrder_num(order_num);
		order.setOrder_name(request.getParameter("order_name"));
		order.setOrder_email(request.getParameter("order_email"));
		order.setOrder_gender(request.getParameter("order_gender"));
		order.setOrder_phone(request.getParameter("order_phone"));
		order.setOrder_birth(request.getParameter("order_birth"));
		order.setNotice(request.getParameter("order_num"));
		
		dao.userOrderModify(order);
		
		request.setAttribute("notice_msg", "예약자 정보를 수정했습니다!");
		request.setAttribute("notice_url", "userOrderDetail.do?order_num="+order_num);
		
		return "/WEB-INF/views/common/alert_singleView.jsp";
	}
}