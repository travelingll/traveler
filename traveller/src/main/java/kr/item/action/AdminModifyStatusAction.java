package kr.item.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.item.dao.ItemDAO;

public class AdminModifyStatusAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		Map<String,String> map = new HashMap<String,String>();
		if(user_num==null && user_auth!=9) {//로그인 되지 않은 경우
			map.put("result", "logout");
		}else {
		
		
		//전송된 데이터 인코딩 처리
		request.setCharacterEncoding("utf-8");
		
		int item_num = Integer.parseInt(request.getParameter("item_num"));
		String status = request.getParameter("status");
		
		ItemDAO dao = ItemDAO.getInstance();
		dao.modifyItemStatus(status, item_num);
		
		map.put("result", "success");
		}
		
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(map);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
