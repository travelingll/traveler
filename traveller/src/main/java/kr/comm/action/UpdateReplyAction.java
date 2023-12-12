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

public class UpdateReplyAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//전송된 데이터 인코딩 처리
				request.setCharacterEncoding("utf-8");
				//댓글 번호
				int comm_renum = Integer.parseInt(request.getParameter("comm_renum"));
				
				CommDAO dao = CommDAO.getInstance();
				CommReplyVO db_reply = dao.getReplyComm(comm_renum);
				
				HttpSession session = request.getSession();
				Integer user_num = (Integer)session.getAttribute("user_num");
				
				Map<String,String> mapAjax = new HashMap<String,String>();
				if(user_num == null) {
					mapAjax.put("result","logout");
				}else if(user_num != null && user_num == db_reply.getMem_num()){
					
					//로그인한 회우너번호와 작성자 회원번호 일치
					//자바빈(VO)생성
					CommReplyVO reply = new CommReplyVO();
					reply.setComm_renum(comm_renum);
					reply.setComm_recontent(request.getParameter("comm_recontent"));
					reply.setComm_reip(request.getRemoteAddr());
					
					dao.updateReplyComm(reply);
					
					mapAjax.put("result","success");
				}else {//로그인한 회원번호와 작성자 회원번호 불일치
					mapAjax.put("result","wrongAccess");
				}
				//json 문자열 변환
				ObjectMapper mapper = new ObjectMapper();
				String ajaxData = mapper.writeValueAsString(mapAjax);
				
				request.setAttribute("ajaxData", ajaxData);
				
				return "/WEB-INF/views/common/ajax_view.jsp";
			}

		}
