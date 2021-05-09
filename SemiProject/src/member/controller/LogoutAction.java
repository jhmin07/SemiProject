package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;

public class LogoutAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		
		// 로그아웃을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것임.
		String goBackURL = (String) session.getAttribute("goBackURL");
		
		if(goBackURL != null) {
			goBackURL = request.getContextPath()+"/"+goBackURL;
		}
				
		session.invalidate();
		
		super.setRedirect(true);
		
		if(goBackURL != null) {
			super.setViewPage(goBackURL);
		}
		else {
			super.setViewPage(request.getContextPath()+"/home.up");		
		}
		
		
	}

}
