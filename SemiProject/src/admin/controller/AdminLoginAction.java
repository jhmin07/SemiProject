package admin.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.model.AdminDAO;
import admin.model.AdminVO;
import admin.model.InterAdminDAO;
import common.controller.AbstractController;



public class AdminLoginAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String method = request.getMethod();  
		
		String adId = request.getParameter("adId");
		String adPwd = request.getParameter("adPwd");
		String clientip = request.getRemoteAddr();
		
				
				if(!"POST".equalsIgnoreCase(method)) {
					
					super.setViewPage("/WEB-INF/admin/adminLogin.jsp");
				}
				
				else {
					
					Map<String, String> paraMap = new HashMap<>();
					paraMap.put("adId", adId);
					paraMap.put("adPwd", adPwd);
					paraMap.put("clientip", clientip);
					
					InterAdminDAO adao = new AdminDAO();
					AdminVO loginadmin  = adao.loginAdmin(paraMap);
					
					
					if(loginadmin  != null) {
						
						
						HttpSession session = request.getSession();
						// 메모리에 생성되어져 있는 session 을 불러오는 것이다.
						
						session.setAttribute("loginadmin ", loginadmin);
						// session(세션)에 로그인 되어진 사용자 정보인 loginadmin 을 키이름을 "loginadmin" 으로 저장시켜두는 것이다.
					
						request.setAttribute("adId", adId);
							super.setRedirect(true);
							super.setViewPage(request.getContextPath()+"/admin/adminMyPage.up");// adminhome을 또 만들어야 함
						
						
					}
					else {
						String message = "로그인 실패";
						String loc = "javascript:history.back()";
						
						request.setAttribute("message", message);
						request.setAttribute("loc", loc);
						
						super.setRedirect(false);
						super.setViewPage("/WEB-INF/msg.jsp");
					}
					
					
				}

				
		
	}

}
