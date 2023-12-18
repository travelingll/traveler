package kr.question.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.question.dao.QuestionDAO;
import kr.question.vo.QuestionVO;

public class UserQuestionModifyFormAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int question_num = Integer.parseInt(request.getParameter("question_num"));
		HttpSession session = request.getSession();
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		QuestionDAO dao = QuestionDAO.getInstance();
		QuestionVO detail = dao.getQuestionDetail(question_num);
		
		if(session.getAttribute("user_num")==null) { //비회원 글 - 비밀번호
			
			request.setAttribute("question_num", question_num);
			request.setAttribute("check", "modify");
			
			return "/WEB-INF/views/question/userQuestionPasswd.jsp"; //비밀번호 확인페이지로
			
		} else if(user_num != detail.getMem_num()) { //회원글 - 작성자 체크
			
			request.setAttribute("notice_msg", "회원글의 경우 작성자만 수정 가능합니다!");
			request.setAttribute("notice_url", "questionDetail.do?question_num="+question_num);
			
			return "/WEB-INF/views/common/alert_singleView.jsp";
		}
		
		//조건 체크 통과 시 수정 가능
		request.setAttribute("detail", detail);
			
		return "/WEB-INF/views/question/userQuestionModifyForm.jsp";
	}
}