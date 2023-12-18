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
		
		//관리자 체크
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		if(user_num==null && user_auth!=9) { //관리자 외 출입 금지
			return "redirect:/question/questionList.do";
		}
	
		request.setCharacterEncoding("utf-8");
		int requestion_num = Integer.parseInt(request.getParameter("requestion_num")); //답변글 번호
		int question_num = Integer.parseInt(request.getParameter("question_num"));
		
		QuestionDAO dao = QuestionDAO.getInstance();
		QuestionVO requestion = new QuestionVO(); //답변글 정보 저장용
		
		requestion.setQuestion_num(requestion_num);
		requestion.setQuestion_category("0"); //dao에서 관리자 답변 식별용
		requestion.setQuestion_ip(request.getRemoteAddr());
		requestion.setQuestion_title(request.getParameter("requestion_title"));
		requestion.setQuestion_content(request.getParameter("requestion_content"));
		
		dao.modifyQuestion(requestion);
		
		request.setAttribute("notice_msg", "답변 수정을 완료했습니다!");
		request.setAttribute("notice_url", "questionDetail.do?question_num="+question_num); //원글 정보로 돌아가야함
		session.setAttribute("passwdCheck", "success");
		
		return "/WEB-INF/views/common/alert_singleView.jsp";
	}
}