package kr.item.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import kr.controller.Action;
import kr.item.dao.ItemDAO;
import kr.item.vo.ItemVO;
import kr.util.FileUtil;

public class ItemInsertFormAction implements Action{

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
		
			ItemVO item = new ItemVO();
			
			MultipartRequest multi = FileUtil.createFile(request);
			
			item.setItem_name(multi.getParameter("name"));
			item.setItem_content(multi.getParameter("city"));
			item.setItem_price(Integer.parseInt(multi.getParameter("price")));
			item.setItem_img1(multi.getFilesystemName("pic1"));
			item.setItem_img2(multi.getFilesystemName("pic2"));
			item.setItem_img3(multi.getFilesystemName("pic3"));
			item.setItem_img4(multi.getFilesystemName("pic4"));
			item.setItem_img5(multi.getFilesystemName("pic5"));
			item.setItem_img6(multi.getFilesystemName("pic6"));
			item.setItem_st1((multi.getParameter("item_st1")));
			item.setItem_st2((multi.getParameter("item_st2")));
			item.setItem_st3((multi.getParameter("item_st3")));
			item.setDate_start(multi.getParameter("start_date"));
			item.setDate_end(multi.getParameter("end_date"));
			item.setStatus(multi.getParameter("status"));
			item.setQuantity(Integer.parseInt(multi.getParameter("quantity")));
			item.setItem_case(multi.getParameter("item_case"));
			
			ItemDAO dao = ItemDAO.getInstance();
			dao.insertItem(item);
			
			response.addHeader("Refresh", "2;url=adminItemList.do");
			request.setAttribute("accessMsg", "성공적으로 등록되었습니다.");
			request.setAttribute("accessUrl", "adminItemList.do");
		
		
		return "/WEB-INF/views/common/notice.jsp"; 
	}

}
