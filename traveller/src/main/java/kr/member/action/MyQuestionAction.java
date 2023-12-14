package kr.member.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;
import kr.question.dao.QuestionDAO;
import kr.question.vo.QuestionVO;

public class MyQuestionAction implements Action{

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
		
		QuestionDAO qdao = QuestionDAO.getInstance();
		int count = qdao.getQuestionCount(null, null, user_num);
		List<QuestionVO> questionList = null;
		if(count > 0) {
			questionList = qdao.getQuestionList(null, null, 1, 5, user_num);
		}
		
		request.setAttribute("count", count);
		request.setAttribute("member", member);
		request.setAttribute("questionList", questionList);
		
		return "/WEB-INF/views/member/myQuestion.jsp";
	}

}
