package kr.comm.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.comm.dao.CommDAO;
import kr.comm.vo.CommVO;
import kr.controller.Action;
import kr.util.PageUtil;

public class ListAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String pageNum = request.getParameter("pageNum");
		if(pageNum == null) pageNum = "1";
		
		String keyfield = request.getParameter("keyfield");
		String keyword = request.getParameter("keyword");
		
		CommDAO dao = CommDAO.getInstance();
		int count = dao.getCommCount(keyfield, keyword, 0);
		
		//페이지 처리
		PageUtil page = new PageUtil(keyfield,keyword,Integer.parseInt(pageNum),count,20,10,"list.do");
		List<CommVO> list = null;
		if(count>0) {
			list = dao.getListComm(page.getStartRow(), page.getEndRow(), keyfield, keyword, 0);
			
		}
		request.setAttribute("count", count);
		request.setAttribute("list", list);
		request.setAttribute("page", page.getPage());
		
		//JSP 경로 반환
		return "/WEB-INF/views/comm/list.jsp";
	}

}
  