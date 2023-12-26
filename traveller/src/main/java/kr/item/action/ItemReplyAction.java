package kr.item.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.controller.Action;
import kr.itemreply.dao.ItemReplyDAO;
import kr.itemreply.vo.ItemReplyVO;
import kr.member.dao.MemberDAO;

public class ItemReplyAction implements Action{
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		if(user_num==null) {
			return "redirect:/member/loginForm.do";
		}
		
		request.setCharacterEncoding("utf-8");
		
		MemberDAO dao = MemberDAO.getInstance();
		String user_id = dao.getUserID(user_num);
		
		Integer item_num = Integer.parseInt(request.getParameter("item_num"));
		String item_st1 = request.getParameter("item_st1");
		String item_case = request.getParameter("item_case");
		String item_reip = request.getRemoteAddr();
		String item_recontent = request.getParameter("item_recontent");
		
		ItemReplyDAO redao = ItemReplyDAO.getInstance();
		ItemReplyVO revo = new ItemReplyVO();
		revo.setItem_num(item_num);
		revo.setMem_num(user_num);
		revo.setItem_recontent(item_recontent);
		revo.setItem_reip(item_reip);
		revo.setItem_st1(item_st1);
		revo.setItem_case(item_case);
		revo.setUser_id(user_id); 
		
		redao.insertReply(revo);
		
		
		request.setAttribute("user_num", user_num);
		request.setAttribute("user_auth", user_auth);

		response.addHeader("Refresh", "1;url=itemDetail.do?item_num="+item_num);
		request.setAttribute("accessMsg", "성공적으로 등록되었습니다.");
		request.setAttribute("accessUrl", "itemDetail.do?item_num="+item_num);
	
	
		return "/WEB-INF/views/common/notice.jsp"; 
		
		
		
	}
	
}
