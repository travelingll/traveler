package kr.comm.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import kr.comm.dao.CommDAO;
import kr.comm.vo.CommVO;
import kr.controller.Action;
import kr.util.FileUtil;

public class WriteAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num==null) {//로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		//로그인 된 경우
		MultipartRequest multi = FileUtil.createFile(request);
		CommVO comm = new CommVO();
		comm.setComm_title(multi.getParameter("comm_title"));
		comm.setComm_content(multi.getParameter("comm_content"));
		comm.setIp(request.getRemoteAddr());
		comm.setFilename1(multi.getFilesystemName("filename1"));
		comm.setFilename2(multi.getFilesystemName("filename2"));
		comm.setFilename3(multi.getFilesystemName("filename3"));
		comm.setCategory(Integer.parseInt(multi.getParameter("category")));
		comm.setTag(processComma(multi.getParameterValues("tag")));
		comm.setMem_num(user_num);
		
		CommDAO dao = CommDAO.getInstance();
		dao.insertComm(comm);
		
		//JSP 경로 반환
		return "/WEB-INF/views/comm/write.jsp";
	}
	private String processComma(String[] str) {
		String temp = "";
		for(int i=0;i<str.length;i++) {
			if(i>0) temp += ",";
			temp += str[i];
		}
		return temp;
	}

}
