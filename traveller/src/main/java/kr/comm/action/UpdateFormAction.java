package kr.comm.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.comm.dao.CommDAO;
import kr.comm.vo.CommVO;
import kr.controller.Action;
import kr.util.StringUtil;

public class UpdateFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		if(user_num == null) {
			return "redirect:/member/loginFom.do";
		}
		int comm_num = Integer.parseInt(request.getParameter("comm_num"));
		
		CommDAO dao = CommDAO.getInstance();
		CommVO db_comm = dao.getComm(comm_num);
		//로그인한 회원번호		작성자 회원번호
		if(user_num!=db_comm.getMem_num()) {
			//로그인한 회원번호와 작성자 회원번호 불일치
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		request.setAttribute("comm", db_comm);
		
		/*
		 * 큰 따옴표 처리(수정폼의 input 태그에만 명시)
		 * 게시판에 글 작성시 input 태그에서 ""를 넣어서 글쓰기를 하면
		 * 정상적으로 글 등록되고 목록 및 상세 페이지에서 잘 표시됨.
		 * 수정할 때 input 태그에 데이터가 표시되지 않은 현상이 발생
		 */
		db_comm.setComm_title(StringUtil.parseQuot(db_comm.getComm_title()));
		
		return "/WEB-INF/views/comm/updateForm.jsp";
	}

}