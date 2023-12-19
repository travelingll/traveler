package kr.accom.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.accom.dao.AccomDAO;
import kr.accom.vo.AccomVO;
import kr.controller.Action;
import kr.util.FileUtil;

public class DeleteFileAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, String> mapAjax = new HashMap<String ,String>();
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null){//로그인이 되지 않은 경우
			//전송된 데이터 인코딩 처리
			request.setCharacterEncoding("utf-8");
			
			mapAjax.put("result", "logout");
		}else {
			int accom_num = Integer.parseInt(request.getParameter("accom_num"));
			
			AccomDAO dao = AccomDAO.getInstance();
			AccomVO db_accom = dao.getAccom(accom_num);
			if(user_num != db_accom.getMem_num()) {
				mapAjax.put("result", "wrongAcccess");
			}else {
				//로그인 한 회원번호와 작성자 회원번호가 일치해서 파일 삭제 가능
				dao.deleteFile(accom_num);
				
				//파일 삭제
				FileUtil.removeFile(request, db_accom.getAccom_filename());
				
				mapAjax.put("result", "success");
			}
	}
		//JSON 데이터 생성
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}
	
}
