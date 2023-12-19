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
import kr.money.vo.MoneyVO;

public class EventExecuteAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		
		//회원 전용 이벤트만 거치도록 로그인 체크
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		int event_num = Integer.parseInt(request.getParameter("event_num"));
		
		Map<String,String> mapAjax = new HashMap<String, String>();
		EventDAO dao = EventDAO.getInstance();
		EventVO event = dao.getEventDetail(event_num);
		MoneyVO db_moneyVo = new MoneyVO();
		
		//이벤트 종류 체크 - 변수
		//이미 이벤트를 참여한 고객의 경우 막기 - 머니dao에 디테일 메서드 추가 > sm_content가 "랜덤 적립금 이벤트 참여", mem_num이 있으면 참여 불가
		
		if(user_num==null) {//로그인 조건체크
			mapAjax.put("result","logout");
		} else if(event.getEvent_count()<=0) {
			mapAjax.put("result","end");
		} else {
			request.setCharacterEncoding("utf-8");
			
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