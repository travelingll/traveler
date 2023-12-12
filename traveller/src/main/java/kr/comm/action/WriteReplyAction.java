package kr.comm.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.comm.dao.CommDAO;
import kr.comm.vo.CommReplyVO;
import kr.controller.Action;

public class WriteReplyAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
Map<String,String> mapAjax = new HashMap<String,String>();
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {//login x
			mapAjax.put("result", "logout");
		}else {//login o
			//전송된 데이터 인코딩 처리
			request.setCharacterEncoding("utf-8");
			
			CommReplyVO reply = new CommReplyVO();
			reply.setMem_num(user_num);
			reply.setComm_recontent(request.getParameter("comm_recontent"));
			reply.setComm_reip(request.getRemoteAddr());
			reply.setComm_num(Integer.parseInt(request.getParameter("comm_num")));
			
			CommDAO dao = CommDAO.getInstance();
			dao.insertReplyComm(reply);
			
			mapAjax.put("result","success");
		}
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
