package kr.member.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.comm.dao.CommDAO;
import kr.comm.vo.CommVO;
import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;

public class MyWriteCommAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) { //로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		//로그인 된 경우
		MemberDAO dao = MemberDAO.getInstance();
		MemberVO member = dao.getMember(user_num);
		
		CommDAO commDao = CommDAO.getInstance();
		int count = commDao.getCommCount(null, null, user_num);
		List<CommVO> commList = null;
		if(count > 0) {
			commList = commDao.getListComm(1, 5, null, null, user_num);
		}
		
		request.setAttribute("count", count);
		request.setAttribute("member", member);
		request.setAttribute("commList", commList);
		
		//JSP 경로 반환
		return "/WEB-INF/views/member/myWriteComm.jsp";
	}

}