package kr.event.action;

import java.util.HashMap;
import java.util.HashSet;
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
		EventDAO dao = EventDAO.getInstance();
		EventVO event = dao.getEventDetail(event_num);
		String event_title = event.getEvent_title();
		
		Map<String,String> mapAjax = new HashMap<String, String>();
		
		MoneyDAO moneyDAO = MoneyDAO.getInstance();
		int check = moneyDAO.checkEvent(user_num, event_title); //미참여시 0
		
		MoneyVO moneyVo = new MoneyVO();
		String money;
		
		if(user_num==null) {//로그인 조건체크
			mapAjax.put("result","logout");
		} else if(event.getEvent_count()<=0) { //종료된 이벤트
			mapAjax.put("result","end");
		} else if(check==1) { //이미 참여한 이벤트
			mapAjax.put("result","done");
		} else if(event_title.equals("랜덤 적립금 지급")) {
			moneyVo = new MoneyVO();
			money = Integer.toString((int)(Math.random()*10000)/10*10);
			
			moneyVo.setMem_num(user_num);
			moneyVo.setSaved_money(money);
			moneyVo.setSm_content(event_title);
			
			dao.updateEventCount(event_num, moneyVo);
			
			mapAjax.put("result", "success");
			mapAjax.put("money", money);
			mapAjax.put("event", event_title);
			
		} else if(event_title.equals("로또 번호 맞추기")) {
			
			String lotto_num = "";
			String user_number = request.getParameter("answer"); //user가 입력한 값
			String[] array = user_number.split(" "); //띄어쓰기를 구분자로 자른 뒤 배열에 저장
			
			boolean lotto_check=true;
			moneyVo = new MoneyVO();
			moneyVo.setMem_num(user_num);
			
			//로또 번호 생성
			HashSet<Integer> hs = new HashSet<Integer>();
			while(hs.size()<6) {
				int num = (int)(Math.random()*45)+1;
				hs.add(num);
				lotto_num += num + " ";
			}
			
			for(int i=0; i<array.length ; i++) {
				if(hs.contains(Integer.parseInt(array[i]))==false) { //로또 번호 하나라도 맞지 않으면
					moneyVo.setSaved_money("100");
					
					mapAjax.put("result", "failed"); //실패 메세지 전송
					lotto_check=false;
					break;//반복문을 빠져나감
				}
			}
			//로또 번호 전체가 일치할 경우 
			if(lotto_check==true) {
				moneyVo.setSaved_money("100000");
				
				mapAjax.put("result", "success");
				mapAjax.put("money", "100000");
			}
			
			moneyVo.setSm_content(event_title);
			dao.updateEventCount(event_num, moneyVo);
			
			mapAjax.put("event", event_title);
			mapAjax.put("num", lotto_num);
		}
		
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}
}