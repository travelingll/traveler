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
  
public class WriteFavAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> mapAjax = new HashMap<String, Object>();
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) {//로그인이 되지 않는 경우
			mapAjax.put("result", "logout");		
		}else {//로그인 된 경우
			//전송된 데이터 인코딩 처리
			request.setCharacterEncoding("utf-8");
			//전송된 데이터 반환
			int accom_num = Integer.parseInt(request.getParameter("accom_num"));
			AccomFavVO favVO = new AccomFavVO();
			favVO.setAccom_num(accom_num);
			favVO.setMem_num(user_num);
			
			AccomDAO dao = AccomDAO.getInstance();
			//좋아요 등록 여부 체크
			AccomFavVO db_fav = dao.selectFav(favVO);
			
			if(db_fav != null) {//좋아요 등록 O
				//좋아요 삭제
				dao.deleteFav(db_fav);
				mapAjax.put("status","noFav");
			}else {//좋아요 등록 X
				//좋아요 등록
				dao.insertFav(favVO);
				mapAjax.put("status", "yesFav");				
			}
			mapAjax.put("result", "success");
			mapAjax.put("count", dao.selectFavCount(accom_num));
		}
		//JSON 문자열 생성
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		return "/WEB-INF/views/common/ajax_view.jsp"; 
	}

}
