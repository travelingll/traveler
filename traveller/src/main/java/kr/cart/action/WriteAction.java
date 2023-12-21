package kr.cart.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.cart.dao.CartDAO;
import kr.cart.vo.CartVO;
import kr.controller.Action;

public class WriteAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		//문자 인코딩 처리
		request.setCharacterEncoding("utf-8");
		
		if(user_num==null) {
			return "redirect:/member/loginForm.do";
		}else{

			int item_num = Integer.parseInt(request.getParameter("item_num"));
			int item_price = Integer.parseInt(request.getParameter("item_price"));
			int quantity = Integer.parseInt(request.getParameter("quantity"));
			int order_quantity = Integer.parseInt(request.getParameter("order_quantity"));
		
			/*
			 * System.out.println(item_num);
			System.out.println(item_price);
			System.out.println(quantity);
			System.out.println(order_quantity);
			 */
			
			
			CartDAO dao = CartDAO.getInstance();
			CartVO cart = new CartVO();
			cart.setItem_num(item_num);
			cart.setMem_num(user_num);
			cart.setOrder_quantity(order_quantity);
			
			CartVO db_cart = dao.getCart(cart);
			
			if(db_cart==null) {
				dao.insertCart(cart);
				
				response.addHeader("Refresh", "2;url="+request.getContextPath()+"/item/itemDetail.do?item_num="+item_num);
				request.setAttribute("notice_msg", "장바구니에 담았습니다.");
				request.setAttribute("notice_url", request.getContextPath()+"/item/itemDetail.do?item_num="+item_num);
				
				return "/WEB-INF/views/common/alert_singleView.jsp";

			}else{
				int ordertotal_quantity = cart.getOrder_quantity() + db_cart.getOrder_quantity();
				if(ordertotal_quantity > quantity) {
					
					request.setAttribute("notice_msg", "구매 가능 수량을 초과하였습니다.");
					request.setAttribute("notice_url", "adminItemList.do");
					
					return "/WEB-INF/views/common/notice.jsp"; 
				}else {
					cart.setOrder_quantity(ordertotal_quantity);
					dao.updateCartByItem_num(cart);
					
					response.addHeader("Refresh", "2;url="+request.getContextPath()+"/item/itemDetail.do?item_num="+item_num);
					request.setAttribute("notice_msg", "장바구니에 담았습니다.");
					request.setAttribute("notice_url", request.getContextPath()+"/item/itemDetail.do?item_num="+item_num);
					
					return "/WEB-INF/views/common/alert_singleView.jsp";
				}
			}	
		}
	}

}
