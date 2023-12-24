package kr.order.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.order.dao.OrderDAO;
import kr.order.vo.OrderVO;

public class UserCancelAction implements Action {

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
		
		//예약 상태 체크
		int order_status = db_order.getOrder_status();
		if(order_status!=1) { //여행 전 상태를 제외한 모든 상태
			request.setAttribute("notice_msg", "여행 전의 상품만 예약을 취소할 수 있습니다!");
			request.setAttribute("notice_url", "userOrderDetail.do?order_num="+order_num);
			
			return "/WEB-INF/views/common/alert_singleView.jsp";
		}
		
		//조건체크 통과한 예약만 삭제 가능
		dao.orderCancel(order_num);
		
		request.setAttribute("notice_msg", "예약을 취소했습니다!");
		request.setAttribute("notice_url", "myOrderList.do");
		
		return "/WEB-INF/views/common/alert_singleView.jsp";
	}
}