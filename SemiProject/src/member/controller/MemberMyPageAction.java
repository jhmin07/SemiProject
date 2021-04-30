package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;


public class MemberMyPageAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		
		if(super.checkLogin(request)) {//로그인을 한 경우
			
			String userid = request.getParameter("userid");
			
			InterMemberDAO mdao = new MemberDAO();
			String name = mdao.getUserName(userid);//이름 알아오기
			
			if(!(name==null)) {
				request.setAttribute("name", name);

				super.setViewPage("/WEB-INF/member/memberMyPage.jsp");
			}
			else {
				String message = "잘못된 접근입니다.";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
			
		}
		
		
		
			
		
	}

}
