package kr.comm.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import kr.comm.dao.CommDAO;
import kr.comm.vo.CommFavVO;
import kr.controller.Action;

public class WriteFavAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
Map<String, Object> mapAjax = new HashMap<String,Object>();
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		
		if(user_num == null) {//로그인이 되지 않은 경우
			mapAjax.put("result", "logout");
		}else {//로그인 된 경우
			request.setCharacterEncoding("utf-8");
			
			int comm_num = Integer.parseInt(request.getParameter("comm_num"));
			
			CommFavVO favVO = new CommFavVO();
			favVO.setComm_num(comm_num);
			favVO.setMem_num(user_num);
			
			CommDAO dao = CommDAO.getInstance();
			//좋아요 등록 여부 체크
			CommFavVO db_fav = dao.selectFav(favVO);
			if(db_fav != null) {//좋아요 등록 o
				//좋아요 삭제
				dao.deleteFav(db_fav);
				mapAjax.put("status", "noFav");
				
			}else {//좋아요 등록 x
				dao.insertFav(favVO);
				mapAjax.put("status", "yesFav");
			}
			mapAjax.put("result", "success");
			mapAjax.put("count", dao.selectFavCount(comm_num));
		}
		//json 문자열 생성
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
