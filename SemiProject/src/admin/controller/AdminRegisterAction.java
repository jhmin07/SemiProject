package admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.model.AdminDAO;
import admin.model.AdminVO;
import admin.model.InterAdminDAO;
import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;

public class AdminRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod(); // "GET" 또는 "POST"
		
		if("GET".equalsIgnoreCase(method)) {
			// 회원가입창을 띄운다
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/admin/adminRegister.jsp");
		}
		else {
			// 일반적인 회원으로 회원가입한 경우			
			String adId = request.getParameter("userid");			
			String adPwd = request.getParameter("pwd");
			String adName = request.getParameter("name");
			String adEmail = request.getParameter("email"); 
			String hp1 = request.getParameter("hp1"); 
			String hp2 = request.getParameter("hp2"); 
			String hp3 = request.getParameter("hp3"); 
			
			
			String adMobile = hp1 + hp2 + hp3;
			
			
			AdminVO admin = new AdminVO(adId, adPwd, adName, adEmail, adMobile);
			
			InterAdminDAO adao = new AdminDAO();
			
			try {
				int n = adao.adminRegister(admin);
								
				if(n == 1) {
					
					request.setAttribute("adId", adId);
					request.setAttribute("adName", adName);
					request.setAttribute("adEmail", adEmail);
					
					
				//	super.setRedirect(false);
					super.setViewPage("/WEB-INF/admin/adminRegisterAftermsg.jsp");			
				}
				else {
					String message = "관리자등록 실패";
					String loc = "javascript:history.back()";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
				//	super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");				
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}		
			
		}
		
	}

}
