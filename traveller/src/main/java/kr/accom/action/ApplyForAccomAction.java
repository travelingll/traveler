package kr.accom.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.accom.dao.AccomDAO;

public class ApplyForAccomAction implements Action {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer) session.getAttribute("user_num");
		if (user_num == null) {
			// 로그인되지 않은 경우 로그인 페이지로 리다이렉트
			return "redirect:/member/loginForm.do";
		}

		// 동행 신청을 위한 정보 가져오기
		int accom_num = Integer.parseInt(request.getParameter("accom_num"));
		int userNum = user_num;

		AccomDAO accomDAO = new AccomDAO();

		try {
			// 동행 신청
			boolean applied = accomDAO.applyForAccom(accom_num, userNum);

			if (applied) {
				// 동행 신청 성공 시 메시지 설정
				request.setAttribute("message", "동행 신청이 완료되었습니다.");
			} else {
				// 동행 신청 실패 시 메시지 설정
				request.setAttribute("message", "동행 신청에 실패했습니다. 현재 신청 인원이 모집 인원을 초과하였습니다.");
			}
		} catch (Exception e) {
			// 예외 발생 시 메시지 설정
			e.printStackTrace();
			request.setAttribute("message", "동행 신청 중 오류가 발생했습니다.");
		}

		// 동행 상세 페이지로 리다이렉트
		return "redirect:/accom/accomDetail.do?accom_num=" + accom_num;
	}
}

