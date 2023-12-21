package kr.question.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.question.dao.QuestionDAO;
import kr.question.vo.QuestionVO;

public class AdminQuestionModifyAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//로그인, 관리자 체크
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		if(user_num==null || user_auth!=9) return "redirect:/question/questionList.do";
	
		request.setCharacterEncoding("utf-8");
		int requestion_num = Integer.parseInt(request.getParameter("requestion_num")); //답변글 번호
		int question_num = Integer.parseInt(request.getParameter("question_num"));
		
		QuestionDAO dao = QuestionDAO.getInstance();
		QuestionVO requestion = new QuestionVO(); //답변글 정보 저장용
		
		requestion.setQuestion_num(requestion_num);
		requestion.setQuestion_ip(request.getRemoteAddr());
		requestion.setQuestion_title(request.getParameter("requestion_title"));
		requestion.setQuestion_content(request.getParameter("requestion_content"));
		
		dao.modifyQuestion(requestion);
		
		request.setAttribute("notice_msg", "답변 수정을 완료했습니다!");
		request.setAttribute("notice_url", "questionDetail.do?question_num="+question_num); //원글 상세로
		session.setAttribute("passwdCheck", "success"); //관리자는 비밀번호 입력x
		
		return "/WEB-INF/views/common/alert_singleView.jsp";
	}
}