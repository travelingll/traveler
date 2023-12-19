package kr.cart.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.cart.dao.CartDAO;
import kr.cart.vo.CartVO;
import kr.controller.Action;
import kr.item.dao.ItemDAO;
import kr.item.vo.ItemVO;

public class ModifyCartAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String,String> mapAjax = new HashMap<String,String>();
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {
			mapAjax.put("result", "logout");
		}else {
			request.setCharacterEncoding("utf-8");
			
			int item_num = Integer.parseInt(request.getParameter("item_num"));
			int item_quantity = Integer.parseInt(request.getParameter("order_quantity"));
			
			ItemDAO itemDao = ItemDAO.getInstance();
			ItemVO item = itemDao.getItem(item_num);
			if(item.getQuantity() < item_quantity) {
				mapAjax.put("result", "noQuantity");
			}else {
				CartVO cart = new CartVO();
				cart.setCart_num(Integer.parseInt(request.getParameter("cart_num")));
				cart.setOrder_quantity(item_quantity);
				
				CartDAO cartDao = CartDAO.getInstance();
				cartDao.updateCart(cart);
				
				mapAjax.put("result", "success");
			}
		}
		//JSON 문자열 처리
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
				
		request.setAttribute("ajaxData", ajaxData);
				
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
