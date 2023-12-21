package kr.accom.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.accom.dao.AccomDAO;
import kr.accom.vo.AccomInfoVO;
import kr.controller.Action;

public class ApplyForAccomAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num==null) {//로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		//로그인 된 경우
		int accom_num = Integer.parseInt(request.getParameter("accom_num"));

		AccomDAO dao = AccomDAO.getInstance();
		AccomInfoVO db_vo = dao.getAccomInfo(accom_num, user_num);
		if(db_vo != null && db_vo.getMem_num() == user_num) {
			request.setAttribute("notice_msg", "이미 동행 신청을 하셨습니다.");
			request.setAttribute("notice_url", request.getContextPath()+"/accom/detail.do?accom_num="+accom_num);
			return "/WEB-INF/views/common/alert_singleView.jsp";
		}
		dao.applyForAccom(accom_num, user_num);
		
		return "/WEB-INF/views/accom/applyAccomList.jsp";
		
	}
}
