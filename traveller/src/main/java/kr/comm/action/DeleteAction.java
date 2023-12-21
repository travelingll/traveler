package kr.comm.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.comm.dao.CommDAO;
import kr.comm.vo.CommVO;
import kr.controller.Action;
import kr.util.FileUtil;

public class DeleteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {
			return "redirect:/member/loginForm.do";
		}
		  
		int comm_num = Integer.parseInt(request.getParameter("comm_num"));
		
		CommDAO dao = CommDAO.getInstance();
		CommVO db_comm = dao.getComm(comm_num);
		
		if(user_num != db_comm.getMem_num()) {
			//로그인한 회원번호와 작성자 회원번호가 불일치
			return "/WEB-INF/views/common/notice.jsp";
			
		}
		//로그인한 회원번호와 작성자 회원번호가 일치
		dao.deleteComm(comm_num);
		//파일 삭제
		FileUtil.removeFile(request, db_comm.getFilename1());
		FileUtil.removeFile(request, db_comm.getFilename2());
		FileUtil.removeFile(request, db_comm.getFilename3());
		
		return "redirect:/comm/list.do";
	}

}
