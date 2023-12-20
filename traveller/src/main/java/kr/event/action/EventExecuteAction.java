package kr.event.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.event.dao.EventDAO;
import kr.event.vo.EventVO;
import kr.money.dao.MoneyDAO;
import kr.money.vo.MoneyVO;

public class EventExecuteAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		
		//회원 전용 이벤트만 거치도록 로그인 체크
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		int event_num = Integer.parseInt(request.getParameter("event_num"));
		
		request.setCharacterEncoding("utf-8");
		
		Map<String,String> mapAjax = new HashMap<String, String>();
		EventDAO dao = EventDAO.getInstance();
		EventVO event = dao.getEventDetail(event_num);

		MoneyDAO moneyDAO = MoneyDAO.getInstance();
		boolean check = moneyDAO.checkEvent(user_num, "랜덤 적립금 이벤트 참여");
		
		if(user_num==null) {//로그인 조건체크
			mapAjax.put("result","logout");
		} else if(event.getEvent_count()<=0) {
			mapAjax.put("result","end");
		} else if(check==true) { //이미 참여한 이벤트의 경우
			mapAjax.put("result","done");
		} else {
			MoneyVO moneyVo = new MoneyVO();
			
			String money = Integer.toString((int)(Math.random()*10000)/10*10);
			
			moneyVo.setMem_num(user_num);
			moneyVo.setSaved_money(money);
			moneyVo.setSm_content("랜덤 적립금 이벤트 참여");
			
			dao.updateEventCount(event_num, moneyVo);
			
			mapAjax.put("result", "success");
			mapAjax.put("money", money);
		}
		
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}
}