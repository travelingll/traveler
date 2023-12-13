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

public class EventReplyWriteAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		Map<String,String> mapAjax = new HashMap<String, String>();
		
		if(user_num==null) {
			mapAjax.put("result","logout");
		} else {
			request.setCharacterEncoding("utf-8");
			EventReplyVO reply = new EventReplyVO();
			
			reply.setEvent_recontent(request.getParameter("event_recontent"));
			reply.setEvent_num( Integer.parseInt(request.getParameter("event_num")));
			reply.setEvent_reip(request.getRemoteAddr());
			reply.setMem_num(user_num);
			
			EventDAO dao = EventDAO.getInstance();
			dao.insertEventReply(reply);
			
			mapAjax.put("result","success");
		}
		
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		request.setAttribute("ajaxData",ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}
}