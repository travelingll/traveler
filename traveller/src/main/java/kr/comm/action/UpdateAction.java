package kr.comm.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import kr.comm.dao.CommDAO;
import kr.comm.vo.CommVO;
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
		int comm_num = Integer.parseInt(multi.getParameter("comm_num"));
		String filename = multi.getFilesystemName("filename");
		
		CommDAO dao = CommDAO.getInstance(); 
		//수정전 데이터 반환
		CommVO db_comm = dao.getComm(comm_num);
		if(user_num != db_comm.getMem_num()) {//로그인한 회원번호와 작성자 회원번호가 불일치
			FileUtil.removeFile(request, filename);
			return "/WEB-INF/views/common/notice.jsp";
		}
		//로그인한 회원번호와 작성자 회원번호가 일치
		CommVO comm = new CommVO();
		comm.setComm_num(comm_num);
		comm.setComm_title(multi.getParameter("comm_title"));
		comm.setComm_content(multi.getParameter("comm_content"));
		comm.setIp(request.getRemoteAddr());
		comm.setFilename(filename);
		
		//글 수정
		dao.updateComm(comm);
		
		if(filename!=null) {//새 파일로 교체할 때 원래 파일 제거
			FileUtil.removeFile(request, db_comm.getFilename());
		}

		return "redirect:/comm/detail.do?comm_num="+comm_num;
	}  

}
