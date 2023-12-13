package kr.event.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.event.dao.EventDAO;
import kr.event.vo.EventReplyVO;

public class EventReplyUpdateAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		Map<String,Object> mapAjax = new HashMap<String, Object>();
		
		//로그인 체크
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		//작성자 체크용
		int event_renum = Integer.parseInt(request.getParameter("event_renum"));
		EventDAO dao = EventDAO.getInstance();
		EventReplyVO db_reply = dao.getEventReplyDetail(event_renum);
		
		if(user_num==null) { //미로그인시
			mapAjax.put("result", "logout");
		} else if(user_num!=null && db_reply.getMem_num()==user_num ) { //작성자 일치
		
			EventReplyVO reply = new EventReplyVO();
			
			reply.setEvent_reip(request.getRemoteAddr());
			reply.setEvent_renum(event_renum);
			reply.setEvent_recontent(request.getParameter("event_recontent"));
			
			dao.updateEventReply(reply);
			mapAjax.put("result", "success");
			
		} else { //작성자 불일치
			mapAjax.put("result", "wrongAccess");
		}
		
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		request.setAttribute("ajaxData", ajaxData);

		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}
}