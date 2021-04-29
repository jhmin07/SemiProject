package member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import common.controller.AbstractController;

public class AdminMyPageAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		

		super.setRedirect(false); 
		super.setViewPage("/WEB-INF/member/adminMyPage.jsp");
			  
	}

}
