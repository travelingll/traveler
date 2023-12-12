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

public class DeleteReplyAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//전송된 데이터 인코딩 처리
				request.setCharacterEncoding("utf-8");
				//전송된 데이터 반환
				int comm_renum = Integer.parseInt(request.getParameter("comm_renum"));
				
				Map<String,String> mapAjax = new HashMap<String,String>();
				CommDAO dao = CommDAO.getInstance();
				CommReplyVO db_reply = dao.getReplyComm(comm_renum);
				
				HttpSession session = request.getSession();
				Integer user_num = (Integer)session.getAttribute("user_num");
				if(user_num == null) {
					mapAjax.put("result", "logout");
				}else if(user_num != null && user_num == db_reply.getMem_num()){
					//로그인 되어있고 로그인한회원번호의 자성자 회원번호 일치
					dao.deleteReplyComm(comm_renum);
					
					mapAjax.put("result","success");
				}else {//로그인한 회원번호와 작성자 회원번호 불일치
						mapAjax.put("result","wrongAccess");
				}
				//JSON 문자열 변환
				ObjectMapper mapper = new ObjectMapper();
				String ajaxData = mapper.writeValueAsString(mapAjax);
				
				request.setAttribute("ajaxData", ajaxData);
						
						
						
				return "/WEB-INF/views/common/ajax_view.jsp";
			}

		}
