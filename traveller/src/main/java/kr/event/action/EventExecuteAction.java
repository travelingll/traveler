package kr.event.action;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
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
		int check = moneyDAO.checkEvent(user_num, event_num); //미참여시 0
		
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
			String[] array = request.getParameter("answer").split(" "); //사용자가 입력한 값을 잘라서 배열에 저장
			
			int lotto_check=0;
			moneyVo = new MoneyVO();
			moneyVo.setMem_num(user_num);
			
			//로또 번호 생성
			HashSet<Integer> hs = new HashSet<Integer>();
			while(hs.size()<6) {
				int num = (int)(Math.random()*45)+1;
				hs.add(num);
			}
			
			hs.stream().sorted(); //작은 숫자부터 정렬
			
			//일치 여부 확인
			Iterator<Integer> it = hs.iterator();
	        while(it.hasNext()) {
	        	int i = 0;
	        	if( hs.contains(Integer.parseInt(array[i])) ) {
					lotto_check++;
				}
				lotto_num += it.next()+" ";
				i++;
	        }
			
			//로또 번호 전체가 일치할 경우 
			if(lotto_check==6) {
				moneyVo.setSaved_money("100000");
				moneyVo.setSm_content(event_title);
				
				mapAjax.put("result", "success");
				mapAjax.put("money", "100000");
			} else {
				moneyVo.setSaved_money("100");
				moneyVo.setSm_content("로또 번호 맞추기 실패! 위로금 지급");
				
				mapAjax.put("result", "failed"); //실패 메세지 전송
			}
			
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