package order.controller;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import common.controller.AbstractController;

import order.model.CartDAO;
import order.model.CartVO;
import order.model.InterCartDAO;

public class CartControllerAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		
		if(super.checkLogin(request)) {
			// 로그인을 했으면
			String userid = request.getParameter("userid");
			InterCartDAO cdao = new CartDAO();
			
			 CartVO cvo = cdao.getCartList(userid);
			 
			 request.setAttribute("cvo", cvo); //가져온 장바구니 리스트를 넣어준다.
			 		
			
			
			super.setViewPage("/WEB-INF/order/cart.jsp");// 장바구니 페이지로 이동함.
			
			

		}
		else {
			// 로그인을 하지않았으면
			
			String message = "로그인 후 이용하세요!";
	        String loc = "/WEB-INF/member/login.jsp";
	        
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	        
	        //   super.setRedirect(false);
	        super.setViewPage("/WEB-INF/msg.jsp");
		}
	        
	       


		
	}

}
