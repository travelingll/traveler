package kr.item.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.item.dao.ItemDAO;
import kr.item.vo.ItemVO;
import kr.order.dao.OrderDAO;
import kr.util.PageUtil;

public class AdminItemListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		
		if(user_num==null) {//로그인 되지 않은 경우
			return "redirect:/member/login.do";
		}
		
		if(user_auth !=9) {//관리자로 로그인되지 않은 경우
			return "redirect:/";
		}
		
		//전송된 데이터 인코딩 처리
		request.setCharacterEncoding("utf-8");
		
		//여행상품의 상태
		String status = request.getParameter("status");
		
		
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null) pageNum="1";
		
		String keyfield = request.getParameter("keyfield");
		String keyword = request.getParameter("keyword");
		String st1 = request.getParameter("st1");
		
		ItemDAO dao = ItemDAO.getInstance();
		int count = dao.getItemCount(keyfield, keyword, st1);
		
		//페이지 처리
		PageUtil page = new PageUtil(keyfield,keyword,Integer.parseInt(pageNum),count,20,10,request.getContextPath()+"/admin/adminItemList.do");
	
		List<ItemVO> itemList = null;
		
		
		if(count >0) {
			itemList = dao.getItemList(page.getStartRow(),page.getEndRow(), keyfield, keyword, status, st1);
		}
		
		OrderDAO orderDao = OrderDAO.getInstance();
		
		
		request.setAttribute("count", count);
		request.setAttribute("itemList", itemList);
		request.setAttribute("page", page.getPage());
		request.setAttribute("st1", st1);
		
		
		return "/WEB-INF/views/item/adminItemList.jsp"; 
	}

}
