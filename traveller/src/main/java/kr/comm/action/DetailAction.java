package kr.comm.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.comm.dao.CommDAO;
import kr.comm.vo.CommVO;
import kr.controller.Action;
import kr.util.StringUtil;

public class DetailAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//글번호 반환
				int comm_num = Integer.parseInt(request.getParameter("comm_num"));
				
				CommDAO dao = CommDAO.getInstance();
				//조회수 증가
				dao.updateReadcount(comm_num);
				
				CommVO comm = dao.getComm(comm_num);
				
				//HTML 허용하지 않음
				comm.setComm_title(StringUtil.useNoHtml(comm.getComm_title()));
				//HTML 허용하지 않으면서 줄바꿈 처리
				comm.setComm_content(StringUtil.useBrNoHtml(comm.getComm_content()));
				request.setAttribute("comm", comm);
				
				
				return "/WEB-INF/views/comm/detail.jsp";
			}

		}
