package kr.item.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.item.dao.ItemDAO;
import kr.item.vo.ItemVO;
import kr.util.PageUtil;

public class ItemInsertAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ItemDAO dao = ItemDAO.getInstance();
		
		int count = dao.getItemCount(null, null, null);
		
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null) pageNum="1";
		
		PageUtil page = new PageUtil(Integer.parseInt(pageNum), count, 20);
		List<ItemVO> list = null;
		
		if(count>0) {
			list = dao.getItemList(page.getStartRow(), page.getEndRow(), null, null, null, null);
		}
		
		
		
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		request.setAttribute("page", page.getPage());
		
		return "/WEB-INF/views/item/itemInsertForm.jsp";
	}

}
