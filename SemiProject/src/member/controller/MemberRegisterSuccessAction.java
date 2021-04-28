package member.controller;

import java.util.*;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;

public class MemberRegisterSuccessAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
			String message = "잘못된 경로입니다!";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		else {
			String userid = request.getParameter("userid");
			String pwd = request.getParameter("pwd");
			
			String clientip = request.getRemoteAddr();
			
			Map<String, String> paraMap = new HashMap<>();
			paraMap.put("userid", userid);
			paraMap.put("pwd", pwd);
			paraMap.put("clientip", clientip);
			
			InterMemberDAO mdao = new MemberDAO();
			
			MemberVO loginuser = mdao.selectOneMember(paraMap);
			
			if(loginuser != null) {
				HttpSession session = request.getSession();
				session.setAttribute("loginuser", loginuser);
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/member/memberRegisterSuccess.jsp");			
			}			
		}
		
	}

}
