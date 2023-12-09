package kr.member.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.controller.Action;
import kr.member.dao.MemberDAO;
import kr.member.vo.MemberVO;

public class RegisterUserAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//전송된 데이터 인코딩 처리
		request.setCharacterEncoding("utf-8");
		//자바빈(VO) 생성
		MemberVO member = new MemberVO();
		member.setId(request.getParameter("id"));
		member.setName(request.getParameter("name"));
		member.setPasswd(request.getParameter("passwd"));
		member.setPhone(request.getParameter("phone"));
		member.setEmail(request.getParameter("email"));
		member.setBirth(request.getParameter("birth"));
		member.setGender(request.getParameter("gender"));
		member.setZipcode(request.getParameter("zipcode"));
		member.setAddress1(request.getParameter("address1"));
		member.setAddress2(request.getParameter("address2"));
		member.setStyle1(Integer.parseInt(request.getParameter("style1")));
		member.setStyle2(Integer.parseInt(request.getParameter("style2")));
		member.setStyle3(Integer.parseInt(request.getParameter("style3")));
		member.setPush(request.getParameter("push"));
		
		MemberDAO dao = MemberDAO.getInstance();
		dao.insertMember(member);
		
		return "/WEB-INF/views/member/registerUser.jsp";
	}

}
