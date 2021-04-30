package member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.controller.AdminDAO;
import admin.controller.AdminVO;
import admin.controller.InterAdminDAO;
import common.controller.AbstractController;


public class AdminLoginAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
				String method = request.getMethod();  
				String adId = request.getParameter("adId");
				String adPwd = request.getParameter("adPwd");
				
				
				
				if(!"POST".equalsIgnoreCase(method)) {
		
					  super.setRedirect(false); 
					  super.setViewPage("/WEB-INF/member/adminLogin.jsp");
				
					// System.out.println("확인용 clientip => 1" + clientip);
				}
				
				else {
					
					// System.out.println("확인용 clientip => 2" + clientip);
		
					
					Map<String, String> paraMap = new HashMap<>();
					paraMap.put("adId", adId);
					paraMap.put("adPwd", adPwd);
					
					InterAdminDAO adao = new AdminDAO();
					
					AdminVO loginuser = adao.loginAdmin(paraMap);
					
					// 아이디와 비밀번호를 입력했을 경우
					if (loginuser != null) {				
						
						HttpSession session = request.getSession();
						
						session.setAttribute("loginuser", loginuser);
						
						// System.out.println("로그인성공");
						// System.out.println(loginuser.getName());
						
						super.setRedirect(true); 
						super.setViewPage(request.getContextPath()+"/adminHome.up"); //관리자모드 home으로 감
					}
					else {
						
						String message = "아이디 및 비밀번호를 확인해주세요.";
						String loc = request.getContextPath()+"/member/adminLogin.up";
						
						request.setAttribute("message", message);
						request.setAttribute("loc", loc);
						
						super.setRedirect(false);
						super.setViewPage("/WEB-INF/msg.jsp");
					}
					
					
				}
				
		
	}

}
