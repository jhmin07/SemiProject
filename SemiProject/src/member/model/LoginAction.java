package member.model;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;

public class LoginAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();  
		
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		String clientip = request.getRemoteAddr();
		
		if(!"POST".equalsIgnoreCase(method)) {

			  super.setRedirect(false); 
			  super.setViewPage("/WEB-INF/login/login.jsp");
		
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
				super.setViewPage(request.getContextPath()+"/home.up");
			}
			else {
				
				String message = "아이디 및 비밀번호를 확인해주세요.";
				String loc = request.getContextPath()+"/login/login.up";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			

			
		}
	
		/*
		if(!"POST".equalsIgnoreCase(method)) {
			
			
			String message = "비정상적인 경로로 들어왔습니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		else {

			// POST 방식으로 넘어온 것이라면
			String userid = request.getParameter("userid");
			String pwd = request.getParameter("pwd");
			
			// ===> 클라이언트의 IP 주소를 알아오는 것   <=== //
			String clientip = request.getRemoteAddr();
			
			//	System.out.println("확인용 clientip => " + clientip);

			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("userid", userid);
			paraMap.put("pwd", pwd);
			paraMap.put("clientip", clientip);
			
			InterMemberDAO mdao = new MemberDAO();
			
			MemberVO loginuser = mdao.selectOneMember(paraMap);
			
			// 로그인 성공시
			if(loginuser != null) {				
				
				HttpSession session = request.getSession();
				
				session.setAttribute("loginuser", loginuser);
				
				System.out.println("로그인성공");
				
				
				 super.setRedirect(true);
				 super.setViewPage(request.getContextPath()+"/home.up");
				 
				
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
		*/


		
	}

}
