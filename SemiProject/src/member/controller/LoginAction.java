package member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;

public class LoginAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();  
		
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		String clientip = request.getRemoteAddr();
		
		if(!"POST".equalsIgnoreCase(method)) {

			  super.setRedirect(false); 
			  super.setViewPage("/WEB-INF/member/login.jsp");
		
			// System.out.println("확인용 clientip => 1" + clientip);
		}
		
		else {
			
			// System.out.println("확인용 clientip => 2" + clientip);

			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("userid", userid);
			paraMap.put("pwd", pwd);
			paraMap.put("clientip", clientip);
			
			InterMemberDAO mdao = new MemberDAO();
			
			MemberVO loginuser = mdao.selectOneMember(paraMap);
			
			// 아이디와 비밀번호를 입력했을 경우
			if (loginuser != null) {				
				
				HttpSession session = request.getSession();
				
				session.setAttribute("loginuser", loginuser);
				
				// System.out.println("로그인성공");
				// System.out.println(loginuser.getName());
				
				super.setRedirect(true); 
				
				// 로그인을 하면 시작페이지(home.up)로 가는 것이 아니라 로그인을 시도하려고 머물렀던 그 페이지로 가기 위한 것이다.
				String goBackURL = (String) session.getAttribute("goBackURL");				
				
				if(goBackURL != null) {
					super.setViewPage(request.getContextPath() + "/" + goBackURL);						
				}
				else {
					super.setViewPage(request.getContextPath() + "/home.up");						
				}
			}
			else {
				
				String message = "아이디 및 비밀번호를 확인해주세요.";
				String loc = request.getContextPath()+"/member/login.up";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
			
		}


		
	}

}
