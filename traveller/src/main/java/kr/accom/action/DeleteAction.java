package kr.accom.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.accom.dao.AccomDAO;
import kr.accom.vo.AccomVO;
import kr.controller.Action;
import kr.util.FileUtil;

public class DeleteAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {
			return "redirect:/member/loginForm.do";			
		}
		
		int accom_num = Integer.parseInt(request.getParameter("accom_num"));
		
		AccomDAO dao = AccomDAO.getInstance();
		AccomVO db_accom = dao.getAccom(accom_num);
		
		if(user_num != db_accom.getMem_num()) {
			//로그인한 회원번호와 작성자 회원번호가 불일치
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		//로그인한 회원번호와 작성자 회원번호가 불일치
		dao.deleteAccom(accom_num);
		//파일 삭제
		FileUtil.removeFile(request, db_accom.getAccom_filename());
		
		return "redirect:/accom/list.do";
	}	
}

