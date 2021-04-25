package detailMenu.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class blueCoverAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// super.setRedirect(false);
		super.setViewPage(request.getContextPath()+"/WEB-INF/detailMenu/blueCover.jsp");
		
	}

}
