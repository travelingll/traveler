package kr.question.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.question.dao.QuestionDAO;
import kr.question.vo.QuestionVO;

public class QuestionDetailAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//get방식으로 넘어온 question_num으로 문의글 lock 여부 알아내기
		HttpSession session = request.getSession();
		QuestionDAO dao = QuestionDAO.getInstance();
		
		int question_num = Integer.parseInt(request.getParameter("question_num"));
		String passwdCheck = (String)session.getAttribute("passwdCheck"); //이미 비밀번호를 체크한 비회원은 다시 체크할 필요 없도록
		QuestionVO db_question = dao.getQuestionDetail(question_num);
		
		//관리자는 바로 진입 가능하도록 등급 체크
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		if(user_auth==null) user_auth=0;
		
		//문의글 상세 저장
		dao.updateHit(question_num);
		QuestionVO detail = dao.getQuestionDetail(question_num);
		Integer question_renum = detail.getQuestion_renum();
		
		 //비밀글의 경우 조건체크
		if( user_auth!=9 && db_question.getQuestion_lock()==2 && passwdCheck==null ) { //관리자, 공개글, 이미 비밀번호를 체크한 경우 제외
			
			Integer user_num = (Integer)session.getAttribute("user_num");
			
			if( db_question.getMem_num()==0 ) {
				
				//비회원글의 경우 비회원/회원 상관없이 비밀번호 확인
				request.setAttribute("question_num", question_num);
				return "/WEB-INF/views/question/userQuestionPasswd.jsp"; //비밀번호 확인페이지로
				
			} else if( user_num==null || db_question.getMem_num()!=user_num ) { 
				//회원 글의 경우 미로그인 혹은 작성자 불일치 시 경고창
				request.setAttribute("notice_msg", "회원 비밀글의 경우 작성자만 볼 수 있습니다!");
				request.setAttribute("notice_url", "questionList.do");
				
				return "/WEB-INF/views/common/alert_singleView.jsp"; //경고창 페이지로
			}
		}
		
		session.removeAttribute("passwdCheck"); //추후 다른 페이지에서 진입할 경우 비밀번호 다시 체크하도록

		//조건체크를 통과할 경우 문의글 상세 볼 수 있음		
		//답변 번호 저장되어있을 경우 답변 정보도 전송
		if(question_renum != null) { 
			QuestionVO answer = dao.getQuestionDetail(detail.getQuestion_renum());
			request.setAttribute("answer", answer);
		}
		request.setAttribute("detail", detail);
		
		return "/WEB-INF/views/question/questionDetail.jsp";
	}
}