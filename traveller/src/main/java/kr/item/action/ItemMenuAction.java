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

public class ItemMenuAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		request.setAttribute("user_num", user_num);
		request.setAttribute("user_auth", user_auth);
		
		
		
		String list_num = request.getParameter("list_num");
		
		
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null) pageNum="1";
		
		String keyfield=request.getParameter("keyfield");
		String keyword = request.getParameter("keyword");
		
		ItemDAO dao = ItemDAO.getInstance();
		int count = dao.getItemCount(keyfield, keyword, list_num);
		
		
		PageUtil page = new PageUtil(keyfield, keyword, Integer.parseInt(pageNum),count, 3, 10, "itemMenuList.do");
		List<ItemVO> list = new ArrayList<ItemVO>();
		
		list.add(dao.getItem(100062));
		list.add(dao.getItem(100063));
		list.add(dao.getItem(100065));
		
		List<ItemVO> sampleList = dao.getItemSampleList(list_num);
		
		request.setAttribute("page", page.getPage());
		request.setAttribute("list", list);
		request.setAttribute("list_num", list_num);
		request.setAttribute("sampleList", sampleList);
		
		return "/WEB-INF/views/item/itemMenu.jsp";
	}

}
