package kr.question.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.question.dao.QuestionDAO;
import kr.question.vo.QuestionVO;
import kr.util.FileUtil;

public class UserQuestionPasswdCheckAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");

		int question_num = Integer.parseInt(request.getParameter("question_num"));
		String question_passwd = request.getParameter("question_passwd");
		String check = request.getParameter("check");
		
		QuestionDAO dao = QuestionDAO.getInstance();
		QuestionVO db_question = dao.getQuestionDetail(question_num);
		
		if( !question_passwd.equals(db_question.getQuestion_passwd()) ) { //비밀번호 불일치
			
			request.setAttribute("notice_msg", "비밀번호가 일치하지 않습니다!");
			
			if( check.equals("modify") ) {//수정폼 비밀번호 체크인 경우
				request.setAttribute("notice_url", "questionDetail.do?question_num="+question_num);
				request.getSession().setAttribute("passwdCheck", "success");
			} else if( check.equals("delete") ) { //삭제폼 비밀번호 체크인 경우
				request.setAttribute("notice_url", "questionDetail.do?question_num="+question_num);
				request.getSession().setAttribute("passwdCheck", "success");
			} else{ //상세글 진입 비밀번호체크인 경우
				request.setAttribute("notice_url", "questionList.do");
			}
			return "/WEB-INF/views/common/alert_singleView.jsp";
		}
		
		//비밀번호 일치할 경우
		
		dao.updateHit(question_num);
		QuestionVO detail = dao.getQuestionDetail(question_num);
		request.setAttribute("detail", detail);
		
		if( check.equals("modify") ) {//수정폼 비밀번호 체크인 경우
			return "/WEB-INF/views/question/userQuestionModifyForm.jsp";
		} else if( check.equals("delete") ) { //삭제폼 비밀번호 체크인 경우
			
			dao.deleteQuestion(question_num);
			FileUtil.removeFile(request, db_question.getQuestion_photo());
			
			request.setAttribute("notice_msg", "글 삭제가 완료되었습니다!");
			request.setAttribute("notice_url", "questionList.do");
			
			return "/WEB-INF/views/common/alert_singleView.jsp";
			
		} else { //상세글 진입 비밀번호체크인 경우
			if( detail.getQuestion_renum() != 0) { //답변이 있는 경우 답변 저장
				QuestionVO answer = dao.getQuestionDetail(detail.getQuestion_renum());
				request.setAttribute("answer", answer);
			}
			return "/WEB-INF/views/question/questionDetail.jsp";
		}
	}
}
