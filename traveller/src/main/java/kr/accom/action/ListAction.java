package kr.accom.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.accom.dao.AccomDAO;
import kr.accom.vo.AccomVO;
import kr.controller.Action;
import kr.util.PageUtil;

public class ListAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) pageNum = "1";
		
		String keyfield = request.getParameter("keyfield");
		String keyword = request.getParameter("keyword");
		
		AccomDAO dao = AccomDAO.getInstance();
		int count = dao.getAccomCount(keyfield, keyword,0);
		
		//페이지 처리
		PageUtil page = new PageUtil(keyfield, keyword,Integer.parseInt(pageNum),count,20,10,"list.do");
		
		List<AccomVO> list = null;
		if(count > 0) {
			list = dao.getListAccom(page.getStartRow(),page.getEndRow(),keyfield,keyword,0);
		}
		
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		request.setAttribute("page", page.getPage());
		
		//JSP 경로 반환
		return "/WEB-INF/views/accom/list.jsp";
	}	
}  
