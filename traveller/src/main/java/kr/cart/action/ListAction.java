package kr.cart.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.cart.dao.CartDAO;
import kr.cart.vo.CartVO;
import kr.controller.Action;

public class ListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {
			return "redirect:/member/loginForm.do";
		}
		
		CartDAO dao = CartDAO.getInstance();
		int count = dao.getCountCart(user_num);
		
		List<CartVO> list = null;
		if(count > 0) {
			list = dao.getListCart(user_num);
		}
		
		request.setAttribute("count", count);
		request.setAttribute("list", list);
				
		return "/WEB-INF/views/cart/list.jsp";
	}

}
