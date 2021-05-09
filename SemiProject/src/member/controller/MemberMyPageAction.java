package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;
import order.model.CartDAO;
import order.model.InterCartDAO;


public class MemberMyPageAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		super.goBackURL(request);
		
		if(super.checkLogin(request)) {//로그인을 한 경우
			
			String userid = request.getParameter("userid");
			
			InterMemberDAO mdao = new MemberDAO();
			String name = mdao.getUserName(userid);//이름 알아오기
			
			if(!(name==null)) {
				request.setAttribute("name", name);
				HttpSession session = request.getSession();
		        MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
				
				InterCartDAO cdao = new CartDAO();
				int cartCount = cdao.getCartCount(loginuser.getUserid());
				request.setAttribute("cartCount", cartCount);// 장바구니에 담긴 물건갯수
				
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
		
		else {
			// 로그인을 안했을 경우
			request.setAttribute("message", "마이페이지를 보려면 먼저 로그인하세요!!");
			request.setAttribute("loc", "/SemiProject/member/login.up");
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		
			
		
	}

}
