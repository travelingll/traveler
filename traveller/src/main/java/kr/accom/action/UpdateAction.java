package kr.accom.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import kr.accom.dao.AccomDAO;
import kr.accom.vo.AccomVO;
import kr.controller.Action;
import kr.util.FileUtil;

public class UpdateAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num==null) {//로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		
		MultipartRequest multi = FileUtil.createFile(request);
		int accom_num = Integer.parseInt(multi.getParameter("accom_num"));
		String filename = multi.getFilesystemName("filename");
		
		AccomDAO dao = AccomDAO.getInstance(); 
		//수정전 데이터 반환
		AccomVO db_accom = dao.getAccom(accom_num);
		if(user_num != db_accom.getMem_num()) {//로그인한 회원번호와 작성자 회원번호가 불일치
			FileUtil.removeFile(request, filename);
			return "/WEB-INF/views/common/notice.jsp";
		}
		//로그인한 회원번호와 작성자 회원번호가 일치
		AccomVO accom = new AccomVO();
		accom.setAccom_title(multi.getParameter("accom_title"));
		accom.setAccom_content(multi.getParameter("accom_content"));
		accom.setAccom_status(Integer.parseInt(multi.getParameter("accom_status")));
		accom.setIp(request.getRemoteAddr());
		accom.setAccom_filename(multi.getFilesystemName("accom_filename"));
		accom.setAccom_quantity(Integer.parseInt(multi.getParameter("accom_quantity")));
		accom.setAccom_expense(Integer.parseInt(multi.getParameter("accom_expense")));
		accom.setAccom_start(multi.getParameter("accom_start"));
		accom.setAccom_end(multi.getParameter("accom_end"));
		accom.setMem_num(user_num);

		//글 수정
		dao.updateAccom(accom);
		
		if(filename!=null) {//새 파일로 교체할 때 원래 파일 제거
			FileUtil.removeFile(request, db_accom.getAccom_filename());
		}

		return "redirect:/accom/detail.do?accom_num="+accom_num;
	}  

}

