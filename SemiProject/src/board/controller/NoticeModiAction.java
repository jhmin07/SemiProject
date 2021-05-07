package board.controller;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import admin.model.AdminVO;
import common.controller.AbstractController;
import notice.model.InterNoticeDAO;
import notice.model.NoticeDAO;
import notice.model.NoticeVO;

public class NoticeModiAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		HttpSession session = request.getSession();
		AdminVO adId = (AdminVO) session.getAttribute("loginadmin");
		
		if(adId.getAdId() !=null ) {
				
		      //   super.setRedirect(false);
		String adminId = adId.getAdId();
		request.setAttribute("adminId", adminId);
		String ctNo = request.getParameter("ctNo");
		InterNoticeDAO ndao = new NoticeDAO();
		NoticeVO nvo = new NoticeVO();
		nvo =  ndao.contentOneDetail(ctNo);
		request.setAttribute("nvo", nvo);
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/board/noticeModi.jsp");	
		
		  }
		else { 
			String message = "관리자만 접근이 가능합니다."; 
			String loc = "javascript:history.back()";
		  
		  request.setAttribute("message", message); request.setAttribute("loc", loc);
		  
		  // super.setRedirect(false);
		  super.setViewPage("/WEB-INF/msg.jsp");
		 
		  }
			
	}
}


