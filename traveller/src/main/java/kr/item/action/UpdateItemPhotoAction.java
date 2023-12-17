package kr.item.action;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;

import com.oreilly.servlet.MultipartRequest;

import kr.controller.Action;
import kr.item.dao.ItemDAO;
import kr.util.FileUtil;

public class UpdateItemPhotoAction implements Action{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		Integer user_num = (Integer)session.getAttribute("user_num");
		Integer user_auth = (Integer)session.getAttribute("user_auth");
		
		Map<String, String> mapAjax = new HashMap<String, String>();
		
		if(user_num==null) {//로그인 되지 않은 경우
			mapAjax.put("result", "adminLogout");
		}
		
		if(user_auth!=9) {//로그인이 되었지만 관리자가 아닌 경우
			mapAjax.put("result", "adminLogout");
		}
		
		MultipartRequest multi = FileUtil.createFile(request);
		String photo = multi.getFilesystemName("photo");
		String img_num = multi.getParameter("data-num");
		
		ItemDAO dao = ItemDAO.getInstance();
		//dao.updateItemPhoto()
		
		mapAjax.put("result", "success");
		
		ObjectMapper mapper = new ObjectMapper();
		String ajaxData = mapper.writeValueAsString(mapAjax);
		
		request.setAttribute("ajaxData", ajaxData);
		
		
		return "/WEB-INF/views/common/ajax_view.jsp";
	}

}
