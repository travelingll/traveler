package kr.question.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import kr.controller.Action;
import kr.question.dao.QuestionDAO;
import kr.question.vo.QuestionVO;
import kr.util.FileUtil;

public class UserQuestionModifyAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		MultipartRequest multi = FileUtil.createFile(request);
		
		int question_num = Integer.parseInt(multi.getParameter("question_num"));
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		QuestionDAO dao = QuestionDAO.getInstance();
		QuestionVO db_question = dao.getQuestionDetail(question_num); //원글 정보 읽어오기
		
		//회원글 조건 체크
		if( db_question.getMem_num()!=0 && user_num==null) { //미로그인 시
			request.setAttribute("notice_msg", "로그인이 필요합니다!");
			request.setAttribute("notice_url", request.getContextPath()+"/member/loginForm.jsp");
			return "/WEB-INF/views/common/alert_singleView.jsp";
		} else if(db_question.getMem_num()!=0 && user_num!=db_question.getMem_num()) { //작성자 불일치
			request.setAttribute("notice_msg", "회원글은 작성자만 수정 가능합니다!");
			request.setAttribute("notice_url", "/WEB-INF/question/questionDetail.do?question_num="+question_num);
			return "/WEB-INF/views/common/alert_singleView.jsp";
		}
		
		//비회원 글의 경우 비밀번호 미체크 시 체크 페이지로
		String passwdCheck = (String)session.getAttribute("passwdCheck");
		if(passwdCheck==null && db_question.getQuestion_passwd()!=null) {
			request.setAttribute("question_num", question_num); //확인을 위해 문의글 primary key 저장
			return "/WEB-INF/views/question/userQuestionPasswd.jsp"; //비밀번호 확인페이지로
		}
		
		QuestionVO question = new QuestionVO();
		
		question.setQuestion_ip(request.getRemoteAddr());
		question.setQuestion_category(Integer.parseInt(multi.getParameter("question_category")));
		question.setQuestion_title(multi.getParameter("question_title"));
		question.setQuestion_photo(multi.getFilesystemName("question_photo"));
		question.setQuestion_content(multi.getParameter("question_content"));
		question.setQuestion_num(question_num);
		
		dao.modifyQuestion(question);
		
		if(multi.getFilesystemName("question_photo")!=null) FileUtil.removeFile(request, db_question.getQuestion_photo());
		
		request.setAttribute("notice_msg", "글 수정이 완료되었습니다!");
		request.setAttribute("notice_url", "questionDetail.do?question_num="+question_num);
		session.setAttribute("passwdCheck", "success");
		
		return "/WEB-INF/views/common/alert_singleView.jsp";
	}
}