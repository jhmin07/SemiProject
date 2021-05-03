package order.controller;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import order.model.CartDAO;
import order.model.CartVO;
import order.model.InterCartDAO;

public class CartControllerAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		if(super.checkLogin(request)) {
			// 로그인 한 경우 true, 로그인 안 한 경우 false 를 리턴한다.
			
			String userid = request.getParameter("userid");
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			// 로그인을 했기 때문에 null 이 나올 수 없다.
			
			if(loginuser.getUserid().equals(userid)) {
				// 로그인한 사용자가 자신의 정보를 수정하는 경우
				
				 InterCartDAO cdao = new CartDAO();
				 CartVO cvo = cdao.getCartList(userid);
				 
				 request.setAttribute("cvo", cvo); //가져온 장바구니 리스트를 넣어준다.
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/order/cart.jsp");
			}
			else {
				// 로그인한 사용자가 다른 사용자의 정보를 수정하는 경우
				String message = "다른 사용자의 장바구니 열람은 불가합니다!!";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				return;
			}
		}
		else {
			String message = "로그인 먼저해주세요";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
	}

}
