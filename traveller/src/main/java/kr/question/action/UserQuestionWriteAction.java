package kr.question.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import kr.controller.Action;
import kr.question.dao.QuestionDAO;
import kr.question.vo.QuestionVO;
import kr.util.FileUtil;

public class UserQuestionWriteAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		QuestionVO question = new QuestionVO();
		MultipartRequest multi = FileUtil.createFile(request);
		
		if(session.getAttribute("user_num")!=null) { //로그인된 사용자의 경우
			question.setMem_num((Integer)session.getAttribute("user_num"));
		} else { //로그인하지 않은 사용자의 경우 0으로 처리
			question.setMem_num(0);
		}
		
		session.removeAttribute("passwdCheck");
		
		question.setQuestion_ip(request.getRemoteAddr());
		question.setQuestion_category(Integer.parseInt(multi.getParameter("question_category")));
		question.setQuestion_title(multi.getParameter("question_title"));
		question.setQuestion_lock(Integer.parseInt(multi.getParameter("question_lock")));
		question.setQuestion_photo(multi.getFilesystemName("question_photo"));
		question.setQuestion_content(multi.getParameter("question_content"));
		question.setQuestion_level(1); //고객 문의글의 경우 답변 레벨 1
		if(multi.getParameter("question_passwd") != null) question.setQuestion_passwd(multi.getParameter("question_passwd")); //비회원 글 작성 시 비밀번호 설정
		
		QuestionDAO dao = QuestionDAO.getInstance();
		int question_num = dao.writeQuestion(question);
		
		
		request.setAttribute("notice_msg", "문의글이 등록되었습니다!");
		request.setAttribute("notice_url", "questionDetail.do?question_num="+question_num);
		session.setAttribute("passwdCheck", "success");
		
		return "/WEB-INF/views/common/alert_singleView.jsp";
	}
}