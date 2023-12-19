package kr.cart.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.cart.dao.CartDAO;
import kr.controller.Action;

public class DeleteCartAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String,String> mapAjax = new HashMap<String,String>();
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) { //로그인이 되지 않은 경우
			mapAjax.put("result", "logout");
		}else { //로그인 된 경우
			//전송된 데이터 인코딩 처리
			request.setCharacterEncoding("utf-8");
			
			CartDAO dao = CartDAO.getInstance();
			dao.deleteCart(Integer.parseInt(request.getParameter("cart_num")));
			mapAjax.put("result", "success");
		}
		//JSON 문자열 처리
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}
}
