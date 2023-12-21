package kr.order.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.order.dao.OrderDAO;
import kr.order.vo.OrderVO;
import kr.util.PageUtil;

public class AdminOrderListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		
		if(user_num==null) {//로그인 되지 않은 경우
			return "redirect:/member/login.do";
		}
		
		if(user_auth !=9) {//관리자로 로그인되지 않은 경우
			return "redirect:/member/login.do";
		}
		
		String keyfield= request.getParameter("keyfield");
		String keyword= request.getParameter("keyword");
		
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null) pageNum ="1";
		
		OrderDAO dao = OrderDAO.getInstance();
		int count = dao.getOrderCount(keyfield, keyword, 0);
		
		PageUtil page = new PageUtil(keyword,keyfield,Integer.parseInt(pageNum),count,20,10,"adminOrderList.do");
		
		List<OrderVO> list = null;
		
		if(count>0) {
			list = dao.getOrderList(page.getStartRow(),page.getEndRow(), keyword, keyfield, 0);
		}
				
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		request.setAttribute("page", page.getPage());
		
		
		
		return "/WEB-INF/views/order/adminOrderList.jsp";
	}

}
