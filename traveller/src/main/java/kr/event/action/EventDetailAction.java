package kr.event.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.event.dao.EventDAO;
import kr.event.vo.EventVO;
import kr.money.dao.MoneyDAO;
import kr.util.StringUtil;

public class EventDetailAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		int event_num = Integer.parseInt(request.getParameter("event_num"));
		
		EventDAO dao = EventDAO.getInstance();
		dao.updateEventHit(event_num);
		EventVO event = dao.getEventDetail(event_num);
		
		MoneyDAO moneyDAO = MoneyDAO.getInstance();
		String sm_coment = "랜덤 적립금 이벤트 참여"; //이벤트 참여 여부 체크
		boolean check = moneyDAO.checkEvent(event_num, sm_coment); //이벤트 참여 여부 체크
		
		event.setEvent_title(StringUtil.useBrNoHtml(event.getEvent_title()));
		event.setEvent_content(StringUtil.useBrNoHtml(event.getEvent_content()));
		
		request.setAttribute("event", event);
		
		return "/WEB-INF/views/event/eventDetail.jsp";
	}
}