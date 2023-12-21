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

public class EventReplyDeleteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		
		Map<String, String> mapAjax = new HashMap<String, String>();
		
		//로그인 체크
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		EventDAO dao = EventDAO.getInstance();
		int event_renum = Integer.parseInt(request.getParameter("event_renum"));
		EventReplyVO db_reply = dao.getEventReplyDetail(event_renum);
		
		if(user_num==null) { //미로그인 시
			mapAjax.put("result", "logout");
		} else if(user_num!=null && user_num==db_reply.getMem_num()) { //로그인 && 작성자 일치
			dao.deleteEventReply(event_renum);
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