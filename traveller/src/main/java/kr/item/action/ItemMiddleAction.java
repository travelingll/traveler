package kr.item.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.item.dao.ItemDAO;
import kr.item.vo.ItemVO;
import kr.util.PageUtil;

public class ItemMiddleAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String pageNum = request.getParameter("pageNum");
		if(pageNum==null) pageNum="1";
		
		String list_num=request.getParameter("list_num");
		ItemDAO dao = ItemDAO.getInstance();
		int count = dao.getItemCount(null, null, list_num);
		
		//페이지 처리
		PageUtil page = new PageUtil(null,null,Integer.parseInt(pageNum),count,20,10,"/item/itemMiddle.do");
		
	
		List<ItemVO> itemList = new ArrayList<ItemVO>();
		
		if(count >0) {
			itemList = dao.getItemList(page.getStartRow(),page.getEndRow(), null, null, "2", list_num);
		}
		
		request.setAttribute("count", count);
		request.setAttribute("itemList", itemList);
		request.setAttribute("page", page.getPage());
		
		
		return "/WEB-INF/views/item/itemMiddle.jsp"; 
		
	}

}
