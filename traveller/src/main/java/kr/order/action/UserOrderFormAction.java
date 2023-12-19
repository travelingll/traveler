package kr.order.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.cart.dao.CartDAO;
import kr.cart.vo.CartVO;
import kr.controller.Action;
import kr.item.dao.ItemDAO;
import kr.item.vo.ItemVO;
import kr.money.dao.MoneyDAO;
import kr.order.dao.OrderDAO;
import kr.order.vo.OrderVO;

public class UserOrderFormAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//로그인 조건 체크
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num==null) return "redirect:/member/loginForm.do";
		
		//post 조건 체크
		if(request.getMethod().toUpperCase().equals("GET")) return "redirect:/cart/list.do";
		
		CartDAO cartDAO = CartDAO.getInstance();
		int order_total = cartDAO.getTotalByMem_num(user_num);

		//잘못된 주문 조건 체크
		if(order_total <= 0) {
			request.setAttribute("notice_msg","정상적인 주문이 아니거나 상품의 수량이 부족합니다");
			request.setAttribute("notice_url",request.getContextPath()+"/cart/list.do");
			return "/WEB-INF/views/common/alert_singleView.jsp";
		}
		
		List<CartVO> cartList = cartDAO.getListCart(user_num);
		ItemDAO itemDAO = ItemDAO.getInstance();
		OrderDAO orderDAO = OrderDAO.getInstance();
		
		//동시 작업 조건 체크
		for(CartVO cart : cartList) {
			ItemVO item = itemDAO.getItem(cart.getItem_num());
			//카드에 담긴 여행상품의 인원수가 다 찬 경우
			if(item.getQuantity() < orderDAO.getOrderCount(cart.getItem_num())) {
				request.setAttribute("notice_msg","["+item.getItem_name()+"] 상품은 예약이 마감되었습니다!");
				request.setAttribute("notice_url", request.getContextPath()+"/cart/list.do");
				return "/WEB-INF/views/common/alert_singleView.jsp";
			}
			//종료된 상품의 경우 장바구니로 돌아가기
			//여행 상품 기간이 겹치는 경우
		}
		
		MoneyDAO moneyDAO = MoneyDAO.getInstance();
		int user_money = moneyDAO.getTotalByMem_num(user_num); //사용자의 총 적립금
		
		request.setAttribute("user_money", user_money);
		request.setAttribute("order_total", order_total);
		
		return "/WEB-INF/views/order/userOrderForm.jsp";
	}
}