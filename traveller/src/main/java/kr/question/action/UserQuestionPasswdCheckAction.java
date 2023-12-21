package kr.question.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.question.dao.QuestionDAO;
import kr.question.vo.QuestionVO;
import kr.util.FileUtil;

public class UserQuestionPasswdCheckAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		
		int question_num = Integer.parseInt(request.getParameter("question_num"));
		String question_passwd = request.getParameter("question_passwd"); //입력받은 비밀번호
		String passCheck = request.getParameter("check"); //수정,삭제 구별용 변수
		
		QuestionDAO dao = QuestionDAO.getInstance();
		QuestionVO db_question = dao.getQuestionDetail(question_num); //접근하고자 하는 글의 정보
		
		if( !question_passwd.equals(db_question.getQuestion_passwd()) ) { //비밀번호 불일치
			request.setAttribute("notice_msg", "비밀번호가 일치하지 않습니다!");
			
			if( passCheck.equals("modify") || passCheck.equals("delete") ) {//수정,삭제 비밀번호 체크인 경우
				request.setAttribute("notice_url", "questionDetail.do?question_num="+question_num); //상세글로 돌아감
			} else{ //상세글 진입 비밀번호체크인 경우
				request.setAttribute("notice_url", "questionList.do"); //문의글 목록으로 돌아감
			}
			return "/WEB-INF/views/common/alert_singleView.jsp";
		}
		
		//비밀번호 일치할 경우
		QuestionVO detail = dao.getQuestionDetail(question_num);
		request.setAttribute("detail", detail);
		HttpSession session = request.getSession();
		session.setAttribute("passwdCheck", "success");
		
		if( passCheck.equals("modify") ) {//수정폼 비밀번호 체크인 경우
			return "/WEB-INF/views/question/userQuestionModifyForm.jsp";
		} else if( passCheck.equals("delete") ) { //삭제폼 비밀번호 체크인 경우
			dao.deleteQuestion(question_num);
			FileUtil.removeFile(request, db_question.getQuestion_photo());
			
			request.setAttribute("notice_msg", "글 삭제가 완료되었습니다!");
			request.setAttribute("notice_url", "questionList.do");
			
			return "/WEB-INF/views/common/alert_singleView.jsp";
		} else { //상세글 진입 비밀번호체크인 경우
			dao.updateHit(question_num); // 조회수 증가
			if( detail.getQuestion_renum() != 0) { //답변이 있는 경우 답변 저장
				QuestionVO answer = dao.getQuestionDetail(detail.getQuestion_renum());
				request.setAttribute("answer", answer);
			}
			return "/WEB-INF/views/question/questionDetail.jsp";
		}
	}
}
