package kr.order.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.cart.dao.CartDAO;
import kr.cart.vo.CartVO;
import kr.controller.Action;
import kr.item.dao.ItemDAO;
import kr.item.vo.ItemVO;
import kr.order.dao.OrderDAO;
import kr.order.vo.OrderDetailVO;
import kr.order.vo.OrderVO;

public class UserOrderAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//로그인 조건체크
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num==null) return "redirect:/member/loginForm.do";
			
		//접근방식 조건체크
		if(request.getMethod().toUpperCase().equals("GET")) return "redirect:/item/itemList.do";
		
		request.setCharacterEncoding("utf-8");
		CartDAO dao = CartDAO.getInstance();
		
		//비정상적 주문 조건체크
		int all_total = dao.getTotalByMem_num(user_num);
		if(all_total <= 0) {
			request.setAttribute("notice_msg","정상적인 주문이 아니거나 상품의 수량이 부족합니다");
			request.setAttribute("notice_url",request.getContextPath()+"/item/itemMain.do");
			return "/WEB-INF/views/common/alert_singleView.jsp";
		}
		
		//정상적인 주문일 경우 dao 접근
		List<CartVO> cartList = dao.getListCart(user_num); //카트 내 상품 정보 반환
		
		//상품명 생성
		String item_name;
		if(cartList.size()==1) {
			item_name = cartList.get(0).getItemVO().getItem_name();
		} else {
			item_name = cartList.get(0).getItemVO().getItem_name()+" 외 "+ (cartList.size()-1)+"건";
		}
		
		//개별 상품 정보 담기
		List<OrderDetailVO> orderDetailList = new ArrayList<OrderDetailVO>();
		ItemDAO itemDAO = ItemDAO.getInstance();
		OrderDAO orderDAO = OrderDAO.getInstance();
		
		for(CartVO cart : cartList) {
			ItemVO item = itemDAO.getItem(cart.getItem_num());
			
			//상품 인원 조건 체크
			if(item.getQuantity() < orderDAO.getOrderCount(cart.getItem_num())) {
				request.setAttribute("notice_msg","["+item.getItem_name()+"] 상품은 예약이 마감되었습니다!");
				request.setAttribute("notice_url", request.getContextPath()+"/cart/list.do");
				return "/WEB-INF/views/common/alert_singleView.jsp";
			}
			
			OrderDetailVO orderDetail = new OrderDetailVO();
			
			//개별 상품 정보 저장
			orderDetail.setItem_num(cart.getItem_num());
			orderDetail.setItem_name(cart.getItemVO().getItem_name());
			orderDetail.setItem_price(cart.getItemVO().getItem_price());
			orderDetail.setOrder_quantity(cart.getOrder_quantity());
			
			orderDetailList.add(orderDetail);
		}
		
		//주문 정보 담기
		OrderVO order = new OrderVO();
		int cust_price = all_total-Integer.parseInt(request.getParameter("use_money"));
		
		order.setItem_name(item_name);
		order.setOrder_price(all_total);
		order.setOrder_custprice(cust_price);
		order.setMem_num(user_num);
		order.setNotice(request.getParameter("notice"));
		order.setPayment(Integer.parseInt(request.getParameter("payment")));
		order.setUse_money(Integer.parseInt(request.getParameter("use_money")));
		
		order.setOrder_name(request.getParameter("order_name"));
		order.setOrder_email(request.getParameter("order_email"));
		order.setOrder_phone(request.getParameter("order_phone"));
		order.setOrder_birth(request.getParameter("order_birth"));
		order.setOrder_gender(request.getParameter("order_gender"));
		
		orderDAO.insertOrder(order, orderDetailList);
		
		//주문 완료 폼에서 사용할 정보 담기 - 상세 작성해서 보내기
		
		
		return "/WEB-INF/views/order/userOrderSuccess.jsp";
	}
}