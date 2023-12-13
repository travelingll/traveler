package kr.event.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.event.dao.EventDAO;
import kr.event.vo.EventVO;
import kr.util.PageUtil;

public class EventListAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//페이징 처리
		String pageNum = request.getParameter("pageNum");
		
		if(pageNum==null) pageNum="1";
		
		String keyfield = request.getParameter("keyfield");
		String keyword = request.getParameter("keyword");
		
		EventDAO dao = EventDAO.getInstance();
		
		//카테고리 처리
		String event_category = request.getParameter("event_category");
		int category = 0;
		if(event_category!=null) category = Integer.parseInt(event_category);

		int count = dao.getEventCount(keyfield, keyword, category);
		PageUtil page = new PageUtil(keyfield, keyword, Integer.parseInt(pageNum), count, 6, 10, "list.do");
		
		//이벤트 목록 얻어오기
		List<EventVO> list = null;
		
		if(count > 0)
			list = dao.getEventList(page.getStartRow(), page.getEndRow(), keyfield, keyword, category);
		
		request.setAttribute("count", count);
		request.setAttribute("page", page.getPage());
		request.setAttribute("list", list);
		request.setAttribute("category", category);
		
		return "/WEB-INF/views/event/eventList.jsp";
	}
}