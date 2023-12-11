package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;

public class FindPasswordAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//전송된 데이터 인코딩 처리
		request.setCharacterEncoding("utf-8");
		//전송된 데이터 반환
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		
		MemberDAO dao = MemberDAO.getInstance();
		MemberVO member = dao.findPassword(id, name, email);
		if(member == null) {
			request.setAttribute("notice_msg", "회원정보가 존재하지 않습니다.");
			request.setAttribute("notice_url", request.getContextPath()+"/member/findPasswordForm.do");
			
			return "/WEB-INF/views/common/alert_singleView.jsp";
		}
		
		request.setAttribute("member", member);
		
		return "/WEB-INF/views/member/findPassword.jsp";
		
	}

}
