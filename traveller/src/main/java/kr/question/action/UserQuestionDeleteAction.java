package kr.question.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.question.dao.QuestionDAO;
import kr.question.vo.QuestionVO;
import kr.util.FileUtil;

public class UserQuestionDeleteAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		request.setCharacterEncoding("utf-8");
		
		int question_num = Integer.parseInt(request.getParameter("question_num"));
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		QuestionDAO dao = QuestionDAO.getInstance();
		QuestionVO db_question = dao.getQuestionDetail(question_num);
		
		if( db_question.getMem_num()!=0 ) { //회원글
			if(user_num==null) { //로그인 체크
				request.setAttribute("notice_msg", "로그인이 필요합니다!");
				request.setAttribute("notice_url", request.getContextPath()+"/member/loginForm.jsp");
				return "/WEB-INF/views/common/alert_singleView.jsp";
			} else if( user_num!=db_question.getMem_num()) {//작성자 체크
				request.setAttribute("notice_msg", "회원글은 작성자만 삭제 가능합니다!");
				request.setAttribute("notice_url", "/WEB-INF/question/questionDetail.do?question_num="+question_num);
				return "/WEB-INF/views/common/alert_singleView.jsp";
			}
		} else { //비회원글 - 비밀번호 체크
			request.setAttribute("question_num", question_num);
			request.setAttribute("check", "delete");
			return "/WEB-INF/views/question/userQuestionPasswd.jsp";
		}
		
		//조건체크 통과 시 삭제 가능
		dao.deleteQuestion(question_num);
		FileUtil.removeFile(request, db_question.getQuestion_photo());
		
		request.setAttribute("notice_msg", "글 삭제가 완료되었습니다!");
		request.setAttribute("notice_url", "questionList.do");
		
		return "/WEB-INF/views/common/alert_singleView.jsp";
	}
}