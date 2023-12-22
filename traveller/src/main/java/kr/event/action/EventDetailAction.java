package kr.event.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.event.dao.EventDAO;
import kr.event.vo.EventVO;
import kr.money.dao.MoneyDAO;
import kr.util.StringUtil;

public class EventDetailAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		
		int event_num = Integer.parseInt(request.getParameter("event_num"));
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		EventDAO dao = EventDAO.getInstance();
		dao.updateEventHit(event_num);
		EventVO event = dao.getEventDetail(event_num);
		
		MoneyDAO moneyDAO = MoneyDAO.getInstance();
		int check = moneyDAO.checkEvent(user_num, event.getEvent_title()); //이벤트 참여 여부 체크
		
		event.setEvent_title(StringUtil.useBrNoHtml(event.getEvent_title()));
		event.setEvent_content(StringUtil.useBrNoHtml(event.getEvent_content()));
		
		request.setAttribute("event", event);
		request.setAttribute("check", check);
		
		return "/WEB-INF/views/event/eventDetail.jsp";
	}
}