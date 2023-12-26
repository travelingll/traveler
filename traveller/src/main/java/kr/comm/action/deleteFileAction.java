package kr.comm.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.comm.dao.CommDAO;
import kr.comm.vo.CommVO;
import kr.controller.Action;
import kr.util.FileUtil;

public class deleteFileAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String,String> mapAjax = new HashMap<String,String>();
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {//로그인이 되지 않은 경우
			mapAjax.put("result", "logout");
		}else {//로그인 된 경우
			//전송된 데이터 인코딩
			request.setCharacterEncoding("utf-8");
			int comm_num = Integer.parseInt(request.getParameter("comm_num"));
			String file_del = request.getParameter("file_del");
			
			CommDAO dao = CommDAO.getInstance();
			CommVO db_comm = dao.getComm(comm_num);
			if(user_num != db_comm.getMem_num()) {
				mapAjax.put("result", "wronAccess");				
			
			
				
			}else if(user_num == db_comm.getMem_num() && file_del.equals("2")){//로그인한 회원번호와 작성자 회원번호가 일치해서 파일 삭제 가능
				mapAjax.put("result", null);
				dao.deleteFile(comm_num, Integer.parseInt(file_del));
				
				FileUtil.removeFile(request, db_comm.getFilename2());
				
				mapAjax.put("result", "success");
				//파일 삭제
			
			}else if(user_num == db_comm.getMem_num() && file_del.equals("3")){//로그인한 회원번호와 작성자 회원번호가 일치해서 파일 삭제 가능
				mapAjax.put("result", null);
				dao.deleteFile(comm_num, Integer.parseInt(file_del));
				
				FileUtil.removeFile(request, db_comm.getFilename3());
				
				mapAjax.put("result", "success");
				//파일 삭제
			
				
			}
		}
		
		//JSON 데이터 생성
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}