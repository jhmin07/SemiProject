package admin.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.model.AdminVO;
import common.controller.AbstractController;

public class AdminMyPageAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		

		// 세션불러오기
		HttpSession session = request.getSession();
		AdminVO avo = (AdminVO)session.getAttribute("loginadmin");
		
		request.setAttribute("avo", avo);
		super.setRedirect(false); 
		super.setViewPage("/WEB-INF/admin/adminMyPage.jsp");
			  
	}

}
