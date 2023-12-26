package kr.item.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import kr.controller.Action;
import kr.item.dao.ItemDAO;
import kr.item.vo.ItemVO;
import kr.util.FileUtil;

public class ItemModifyAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		if(user_num==null) {//로그인 되지 않은 경우
			return "redirect:/member/loginForm.do";
		}
		
		if(user_auth!=9) {//로그인이 되었지만 관리자가 아닌 경우
			return "/WEB-INF/views/common/notice.jsp";
		}
		
		MultipartRequest multi = FileUtil.createFile(request);
		
		ItemVO item = new ItemVO();
		int item_num = Integer.parseInt(multi.getParameter("item_num"));

		ItemDAO dao = ItemDAO.getInstance();
		
		ItemVO db_item = dao.getItem(item_num);

		
		item.setItem_num(item_num);
		item.setItem_name(multi.getParameter("name"));
		item.setItem_content(multi.getParameter("city"));
		item.setItem_price(Integer.parseInt(multi.getParameter("price")));
		
		if(multi.getFilesystemName("pic1")==null) {
			item.setItem_img1(db_item.getItem_img1());
		}else {
			item.setItem_img1(multi.getFilesystemName("pic1"));
		}
		
		if(multi.getFilesystemName("pic2")==null) {
			item.setItem_img2(db_item.getItem_img2());
		}else {
			item.setItem_img2(multi.getFilesystemName("pic2"));
		}
		
		if(multi.getFilesystemName("pic3")==null) {
			item.setItem_img3(db_item.getItem_img3());
		}else {
			item.setItem_img3(multi.getFilesystemName("pic3"));
		}
		
		if(multi.getFilesystemName("pic4")==null) {
			item.setItem_img4(db_item.getItem_img4());
		}else {
			item.setItem_img4(multi.getFilesystemName("pic4"));
		}
		
		if(multi.getFilesystemName("pic5")==null) {
			item.setItem_img5(db_item.getItem_img5());
		}else {
			item.setItem_img5(multi.getFilesystemName("pic5"));
		}
		
		if(multi.getFilesystemName("pic6")==null) {
			item.setItem_img6(db_item.getItem_img6());
		}else {
			item.setItem_img6(multi.getFilesystemName("pic6"));
		}
		
		
		/*
		 * item.setItem_img1(multi.getFilesystemName("pic1"));
		 * item.setItem_img2(multi.getFilesystemName("pic2"));
		 * item.setItem_img3(multi.getFilesystemName("pic3"));
		 * item.setItem_img4(multi.getFilesystemName("pic4"));
		 * item.setItem_img5(multi.getFilesystemName("pic5"));
		 * item.setItem_img6(multi.getFilesystemName("pic6"));
		 * 
		 * 		
		String item_img1 = db_item.getItem_img1();
		String item_img2 = db_item.getItem_img2();
		String item_img3 = db_item.getItem_img3();
		String item_img4 = db_item.getItem_img4();
		String item_img5 = db_item.getItem_img5();
		String item_img6 = db_item.getItem_img6();
		 */
		
		
		item.setItem_st1(multi.getParameter("item_st1"));
		item.setItem_st2(multi.getParameter("item_st2"));
		item.setItem_st3(multi.getParameter("item_st3"));
		item.setDate_start(multi.getParameter("start_date"));
		item.setDate_end(multi.getParameter("end_date"));
		item.setStatus(multi.getParameter("status"));
		item.setQuantity(Integer.parseInt(multi.getParameter("quantity")));
		
		System.out.println(item.toString());
		dao.modifyItem(item);
	
		
		response.addHeader("Refresh", "1;url=adminItemDetail.do?item_num="+item_num);
		request.setAttribute("accessMsg", "성공적으로 수정되었습니다.");
		request.setAttribute("accessUrl", "2;url=adminItemDetail.do?item_num="+item_num);
	
	
		return "/WEB-INF/views/common/notice.jsp"; 
		

	}

}
