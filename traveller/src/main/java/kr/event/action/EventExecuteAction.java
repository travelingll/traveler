package kr.event.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;

public class EventExecuteAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//에이젝스 통신으로 처리 예정
		
		//회원 전용 이벤트만 거치도록 로그인 체크
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		if(user_num==null) return "redirect:/member/loginForm.do";
		
		
		
		
		return "/WEB-INF/views/common/ajax_views.jsp";
	}
}