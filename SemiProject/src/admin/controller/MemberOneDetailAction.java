package admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.model.*;
import common.controller.AbstractController;
import member.model.MemberVO;


public class MemberOneDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// == 관리자 모드, 관리자로 로그인 했을 때만 조회가 가능하도록 한다. 
		HttpSession session = request.getSession();
		
		AdminVO loginadmin = (AdminVO) session.getAttribute("loginadmin");
		
		if(loginadmin != null) {
			// 관리자모드에서 로그인 했을 경우
			
		String userid = request.getParameter("userid");
		InterAdminDAO adao = new AdminDAO();
		MemberVO mvo = (MemberVO) adao.memberOneDetail(userid);
		
		request.setAttribute("mvo", mvo);
		
		String goBackURL = request.getParameter("goBackURL");
		request.setAttribute("goBackURL", goBackURL);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/admin/memberOneDetail.jsp");
				
		}
		else {
			// 관리자모드에서 로그인을 안한 경우
			String message = "관리자만 접근이 가능합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}		
		
	}

}
