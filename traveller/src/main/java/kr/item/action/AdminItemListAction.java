package kr.item.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.item.dao.ItemDAO;
import kr.item.vo.ItemVO;
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
		
		//여행상품의 상태
		String status = request.getParameter("status");
		
		
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null) pageNum="1";
		
		String keyfield = request.getParameter("keyfield");
		String keyword = request.getParameter("keyword");
		
		ItemDAO dao = ItemDAO.getInstance();
		int count = dao.getItemCount(keyfield, keyword, null);
		
		//페이지 처리
		PageUtil page = new PageUtil(keyfield,keyword,Integer.parseInt(pageNum),count,20,10,"/item/list.do");
	
		List<ItemVO> itemList = new ArrayList<ItemVO>();
		
		if(count >0) {
			itemList = dao.getItemList(page.getStartRow(),page.getEndRow(), keyfield, keyword, status, null);
		}
		
		request.setAttribute("count", count);
		request.setAttribute("itemList", itemList);
		request.setAttribute("page", page.getPage());
		
		
		return "/WEB-INF/views/item/adminItemList.jsp"; 
	}

}
