package kr.accom.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.accom.dao.AccomDAO;
import kr.accom.vo.AccomVO;
import kr.controller.Action;
import kr.util.StringUtil;

public class DetailAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 글번호 반환
		int accom_num = Integer.parseInt(request.getParameter("accom_num"));
		
		AccomDAO dao = AccomDAO.getInstance();
		//조회수 증가
		dao.updateReadCount(accom_num);
		
		AccomVO accom = dao.getAccom(accom_num);
		
		//HTML을 허용하지 않음
		accom.setAccom_title(StringUtil.useNoHtml(accom.getAccom_title()));
		//HTML 허용하지 않으면서 줄바꿈 처리
		accom.setAccom_content(StringUtil.useBrNoHtml(accom.getAccom_content()));
		request.setAttribute("accom", accom);
		
		return "/WEB-INF/views/accom/detail.jsp";
	}	
}
