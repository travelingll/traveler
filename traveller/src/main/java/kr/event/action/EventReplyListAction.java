package kr.event.action;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.event.dao.EventDAO;
import kr.event.vo.EventReplyVO;
import kr.util.PageUtil;

public class EventReplyListAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		
		String pageNum = request.getParameter("pageNum");
		if(pageNum==null) pageNum="1";
		
		EventDAO dao = EventDAO.getInstance();
		int event_num = Integer.parseInt(request.getParameter("event_num"));
		int count = dao.getEventReplyCount(event_num);
		
		String rowCount = request.getParameter("rowCount");
		if(rowCount==null) rowCount="10";
		
		PageUtil page = new PageUtil(Integer.parseInt(pageNum), count, Integer.parseInt(rowCount));
		
		List<EventReplyVO> list = null;
		
		if(count>0) {
			list = dao.getEventReplyList(page.getStartRow(), page.getEndRow(), event_num);
		} else {
			list = Collections.emptyList();
		}
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		Map<String, Object> mapAjax = new HashMap<String, Object>();
		
		mapAjax.put("list", list);
		mapAjax.put("user_num", user_num);
		mapAjax.put("count", count);
		
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		request.setAttribute("ajaxData",ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}
}