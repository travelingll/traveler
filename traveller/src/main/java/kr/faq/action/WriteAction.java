package kr.faq.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.faq.dao.FaqDAO;
import kr.faq.vo.FaqVO;

public class WriteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		if(user_num==null) {return "redirect:/member/loginForm.do";}
		//관리자로 로그인하지 않은 경우
		if(user_auth!=9) {return "/WEB-INF/views/common/notice.jsp";}
		
		FaqVO faq = new FaqVO();
		faq.setFaq_title(request.getParameter("title"));
		System.out.println(request.getParameter("content"));
		faq.setFaq_content(request.getParameter("content"));
		System.out.println(request.getParameter("category"));
		faq.setFaq_category(Integer.parseInt(request.getParameter("category")));
		
		FaqDAO dao = FaqDAO.getInstance();
		dao.insertFaq(faq);
		
		return "/WEB-INF/views/faq/write.jsp";
	}

}
