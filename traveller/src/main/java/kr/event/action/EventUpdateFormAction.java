package kr.event.action;


import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.event.dao.EventDAO;
import kr.event.vo.EventVO;

public class EventUpdateFormAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		int user_auth = (Integer)session.getAttribute("user_auth");
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		if(user_num==null || user_auth!=9) {
			return "redirect:/member/loginForm.do";
		}
		
		int event_num = Integer.parseInt(request.getParameter("event_num"));
		
		EventDAO dao = EventDAO.getInstance();
		EventVO event = dao.getEventDetail(event_num);
		
		//sql에서 인식할 수 있도록 이벤트 시작 일자, 끝 일자 포맷 변경
		SimpleDateFormat format = new SimpleDateFormat("yy/MM/dd");
		SimpleDateFormat newformat = new SimpleDateFormat("yyyy-MM-dd");

		System.out.println(newformat.format(format.parse(event.getEvent_start())));
		
		event.setEvent_start(newformat.format(format.parse(event.getEvent_start())));
		event.setEvent_end(newformat.format(format.parse(event.getEvent_end())));
		
		request.setAttribute("event", event);
		
		return "/WEB-INF/views/event/eventModifyForm.jsp";
	}
}