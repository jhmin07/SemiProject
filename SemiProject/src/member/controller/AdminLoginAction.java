package member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.AdminDAO;
import member.model.AdminVO;
import member.model.InterAdminDAO;



public class AdminLoginAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		String method = request.getMethod();  // "GET" 또는 "POST" 
				
				if(!"POST".equalsIgnoreCase(method)) {
					// POST 방식으로 넘어온 것이 아니라면
					/*
					 * String message = "비정상적인 경로로 들어왔습니다."; String loc =
					 * "javascript:history.back()";
					 * 
					 * request.setAttribute("message", message); request.setAttribute("loc", loc);
					 * 
					 * // super.setRedirect(false); super.setViewPage("/WEB-INF/msg.jsp");
					 */
					
					super.setViewPage("/WEB-INF/member/adminLogin.jsp");
				}
				
				else {
					// POST 방식으로 넘어온 것이라면
					String adId = request.getParameter("adId");
					String adPwd = request.getParameter("adPwd");
					
					// ===> 클라이언트의 IP 주소를 알아오는 것   <=== //
					String clientip = request.getRemoteAddr();
				
					
					Map<String, String> paraMap = new HashMap<>();
					paraMap.put("userid", adId);
					paraMap.put("pwd", adPwd);
					paraMap.put("clientip", clientip);
					
					InterAdminDAO addao = new AdminDAO();
					
					AdminVO loginuser = addao.loginAdmin(paraMap);
					
					if(loginuser != null) {
						
						
						HttpSession session = request.getSession();
						// 메모리에 생성되어져 있는 session 을 불러오는 것이다.
						
						session.setAttribute("loginuser", loginuser);
						// session(세션)에 로그인 되어진 사용자 정보인 loginuser 을 키이름을 "loginuser" 으로 저장시켜두는 것이다.
					
						
							super.setRedirect(true);
							super.setViewPage(request.getContextPath()+"/adminMyPage.up");// adminhome을 또 만들어야 함
						
						
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
