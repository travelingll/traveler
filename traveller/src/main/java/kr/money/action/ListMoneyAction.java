package kr.money.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;
import kr.money.dao.MoneyDAO;
import kr.money.vo.MoneyVO;

public class ListMoneyAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) { //로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		//로그인 된 경우
		//회원정보
		MemberDAO dao = MemberDAO.getInstance();
		MemberVO member = dao.getMember(user_num);	
		
		MoneyDAO moneyDao = MoneyDAO.getInstance();
		int count = moneyDao.getMoneyCount(user_num);
		int money_total = moneyDao.getTotalByMem_num(user_num);
		MoneyVO money = moneyDao.getMoney(user_num);
		
		request.setAttribute("member", member);
		request.setAttribute("count", count);
		request.setAttribute("money", money);
		request.setAttribute("money_total", money_total);
		
		return "/WEB-INF/views/member/myMoney.jsp";
	}

}
