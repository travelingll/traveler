package kr.member.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.itemreply.dao.ItemReplyDAO;
import kr.itemreply.vo.ItemReplyVO;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;

public class MyItemReplyAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		if(user_num == null) { //로그인이 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		
		MemberDAO mdao = MemberDAO.getInstance();
		MemberVO member = mdao.getMember(user_num);
		
		String user_id = member.getId();
		
		ItemReplyDAO dao = ItemReplyDAO.getInstance();
		int count = dao.getItemReplyCount(user_id);
		List<ItemReplyVO> itemReply = null;
		if(count > 0) {
			itemReply = dao.getMyItemReply(user_id);
		}
		
		request.setAttribute("count", count);
		request.setAttribute("itemReply", itemReply);
		
		return "/WEB-INF/views/member/myItemReply.jsp";
	}

}
