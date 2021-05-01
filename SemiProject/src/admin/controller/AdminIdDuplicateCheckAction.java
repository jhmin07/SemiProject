package admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import admin.model.AdminDAO;
import admin.model.InterAdminDAO;
import common.controller.AbstractController;

public class AdminIdDuplicateCheckAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {			
			String adId = request.getParameter("userid");
						
			InterAdminDAO adao = new AdminDAO();
			boolean isExists = adao.idDuplicateCheck(adId);
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("isExists", isExists);
						
			String json = jsonObj.toString(); 
			
			request.setAttribute("json", json);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		}
		
	}

}
