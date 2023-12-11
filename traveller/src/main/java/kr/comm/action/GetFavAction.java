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

public class GetFavAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//전송된 데이터 인코딩 처리
				request.setCharacterEncoding("utf-8");
				
				//전송된 데이터 반환
				int comm_num = Integer.parseInt(request.getParameter("comm_num"));
				
				Map<String, Object> mapAjax = new HashMap<String,Object>();
				
				HttpSession session = request.getSession();
				Integer user_num = (Integer)session.getAttribute("user_num");
				
				CommDAO dao = CommDAO.getInstance();
			
				//로그인이 되지 않은 경우
				if(user_num == null) {
					mapAjax.put("status", "noFav");
					
					
				//로그인 된 경우
				}else {
					CommFavVO commFav = dao.selectFav(new CommFavVO(comm_num,user_num));
					
					//좋아요 표시
					if(commFav!=null) {
						mapAjax.put("status", "yesFav");
					//좋아요 미표시
					}else {
						mapAjax.put("status", "noFav");
					}
				}
				mapAjax.put("count", dao.selectFavCount(comm_num));
				
				//JSON 문자열 생성
				ObjectMapper mapper = new ObjectMapper();
				String ajaxData = mapper.writeValueAsString(mapAjax);
				
				request.setAttribute("ajaxData", ajaxData);
				
				return "/WEB-INF/views/common/ajax_view.jsp";
			}

		}
