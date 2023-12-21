package kr.event.action;

import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import kr.controller.Action;
import kr.event.dao.EventDAO;
import kr.event.vo.EventVO;
import kr.util.FileUtil;

public class EventUpdateAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		int user_auth = (Integer)session.getAttribute("user_auth");
		
		//로그인, 관리자 조건체크
		if(user_num==null || user_auth!=9) return "redirect:/main/main.do";

		MultipartRequest multi = FileUtil.createFile(request);
		
		String event_photo1 = multi.getFilesystemName("event_photo1");
		int event_num = Integer.parseInt(multi.getParameter("event_num"));
		
		EventDAO dao = EventDAO.getInstance();
		EventVO db_event = dao.getEventDetail(event_num); //수정 전 데이터
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat newformat = new SimpleDateFormat("yy/MM/dd");
		
		//수정할 데이터 저장
		EventVO event = new EventVO();
		event.setEvent_num(event_num);
		event.setEvent_start(newformat.format(format.parse(multi.getParameter("event_start"))));
		event.setEvent_end(newformat.format(format.parse(multi.getParameter("event_end"))));
		event.setEvent_photo1(event_photo1);
		event.setEvent_content(multi.getParameter("event_content"));
		event.setEvent_count(Integer.parseInt(multi.getParameter("event_count")));
		
		dao.eventUpdate(event);
		
		if(event_photo1!=null) FileUtil.removeFile(request, db_event.getEvent_photo1()); //기존 파일 삭제
		
		request.setAttribute("notice_msg","이벤트를 수정했습니다!");
		request.setAttribute("notice_url","eventDetail.do?event_num="+event_num);
		
		return "/WEB-INF/views/common/alert_singleView.jsp";
	}
}