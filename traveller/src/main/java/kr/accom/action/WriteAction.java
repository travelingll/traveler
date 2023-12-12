package kr.accom.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import kr.accom.dao.AccomDAO;
import kr.accom.vo.AccomVO;
import kr.comm.dao.CommDAO;
import kr.controller.Action;
import kr.util.FileUtil;

public class WriteAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num==null) {//로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		//로그인 된 경우
		MultipartRequest multi = FileUtil.createFile(request);
		AccomVO accom = new AccomVO();
		accom.setAccom_title(multi.getParameter("accom_title"));
		accom.setAccom_content(multi.getParameter("accom_content"));
		accom.setIp(request.getRemoteAddr());
		accom.setAccom_filename(multi.getFilesystemName("accom_filename"));
		accom.setAccom_quantity(Integer.parseInt(multi.getParameter("accom_quantity")));
		accom.setAccom_expense(Integer.parseInt(multi.getParameter("accom_expense")));
		accom.setAccom_start(multi.getParameter("accom_start"));
		accom.setAccom_end(multi.getParameter("accom_end"));
		accom.setMem_num(user_num);
		
		AccomDAO dao = AccomDAO.getInstance();
		dao.insertAccom(accom);
		
		//JSP 경로 반환
		return "/WEB-INF/views/accom/write.jsp";
		
	}
}
