package kr.order.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.order.dao.OrderDAO;


public class AdminOrderModifyStatusAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		Map<String,String> ajaxMap = new HashMap<String,String>();
		
		
		if(user_num==null) {//로그인 되지 않은 경우
			ajaxMap.put("result","logout");
		}else if(user_auth !=9) {//관리자로 로그인되지 않은 경우
			ajaxMap.put("result","logout");
		}else {
			
		System.out.println("test");
		request.setCharacterEncoding("utf-8");
		
		int order_num = Integer.parseInt(request.getParameter("order_num"));
		int order_status = Integer.parseInt(request.getParameter("orderStatus"));
		
		OrderDAO dao = OrderDAO.getInstance();
		dao.modifyOrderStatus(order_status, order_num);
		System.out.println(order_status);
		System.out.println(order_num);
		
		ajaxMap.put("result","success");
		
		}
		
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(ajaxMap);
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
