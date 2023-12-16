package kr.accom.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.accom.dao.AccomDAO;
import kr.accom.vo.AccomReplyVO;
import kr.controller.Action;

public class WriteReplyAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, String> mapAjax = new HashMap<String, String>();
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {//로그인이 되지 않은 경우
			mapAjax.put("result", "logout");
		}else {//로그인이 된 경우
			// 전송된 데이터 인코딩 처리
			request.setCharacterEncoding("utf-8");
			//자바빈 생성
			AccomReplyVO reply = new AccomReplyVO();
			reply.setMem_num(user_num); //회원번호(댓글 작성자)
			reply.setAccom_recontent(request.getParameter("accom_recontent"));
			reply.setAccom_reip(request.getRemoteAddr());
			reply.setAccom_num(Integer.parseInt(request.getParameter("accom_num")));
			
			AccomDAO dao = AccomDAO.getInstance();
			dao.insertReplyAccom(reply);
			
			mapAjax.put("result", "success");
		}
		// JSON 문자열 생성
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);

		
		request.setAttribute("ajaxData", ajaxData);
		
		//JSP 경로 반환
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
