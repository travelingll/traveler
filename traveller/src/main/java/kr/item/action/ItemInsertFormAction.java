package kr.item.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.controller.Action;
import kr.item.vo.ItemVO;

public class ItemInsertFormAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//전송된 데이터 인코딩 처리
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		Map<String,String>mapAjax = new HashMap<String,String>();
		
		if(user_num==null) {//로그인 되지 않은 경우
			mapAjax.put("result","logout");
		}else if(user_auth!=9) {//로그인이 되었지만 관리자가 아닌 경우
			mapAjax.put("result", "notAdmin");
		}else {//관리자로 로그인한 경우
			
			ItemVO item = new ItemVO();
			item.setItem_name(request.getParameter("name"));
			item.setItem_content(request.getParameter("city"));
			item.setPrice(Integer.parseInt(request.getParameter("item_price")));
			item.setItem_img1(request.getParameter("pic1"));
			item.setItem_img2(request.getParameter("pic2"));
			item.setItem_img3(request.getParameter("pic3"));
			item.setItem_img4(request.getParameter("pic4"));
			item.setItem_img5(request.getParameter("pic5"));
			item.setItem_img6(request.getParameter("pic6"));
			item.setItem_st1(Integer.parseInt(request.getParameter("item_st1")));
			item.setItem_st2(Integer.parseInt(request.getParameter("item_st2")));
			item.setItem_st3(Integer.parseInt(request.getParameter("item_st3")));
			item.setDate_start(request.getParameter("start_date"));
			item.setDate_end(request.getParameter("end_date"));
			item.setQuantity(Integer.parseInt(request.getParameter("quantity")));
			
			mapAjax.put("result", "success");
			
			
			
		}
		
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
