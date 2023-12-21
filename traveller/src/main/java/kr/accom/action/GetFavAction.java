package kr.accom.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.accom.dao.AccomDAO;
import kr.accom.vo.AccomFavVO;
import kr.controller.Action;

public class GetFavAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//전송된 데이터 인코딩 처리
		request.setCharacterEncoding("utf-8");
		// 전송된 데이터 반환
		int accom_num = Integer.parseInt(request.getParameter("accom_num"));
		
		Map<String,Object> mapAjax = new HashMap<String,Object>();
		
		HttpSession session = request.getSession();
		
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		AccomDAO dao = AccomDAO.getInstance();
		if(user_num==null) {//로그인이 되지 않은 경우
			mapAjax.put("status", "noFav");
			
		}else {//로그인이 된 경우
			AccomFavVO boardFav = dao.selectFav(new AccomFavVO(accom_num, user_num));
			
			if(boardFav!=null) {//좋아요 표시
				mapAjax.put("status", "yesFav");
			}else {//좋아요 미표시
				mapAjax.put("status", "noFav");
			}
			
		}
		mapAjax.put("count", dao.selectFavCount(accom_num));
		
		//JSON 문자열 생성
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}
}

