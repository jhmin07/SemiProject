package order.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import order.model.InterOrderDAO;
import order.model.OrderDAO;

public class OrderlistInsertAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String fk_userid = request.getParameter("fk_userid");
		String totalPrice = request.getParameter("totalPrice");
		String totalPoint = request.getParameter("totalPoint");
		
//		System.out.println("fk_usersid: "+ fk_userid);
//		System.out.println("totalPrice: "+ totalPrice);
//		System.out.println("totalPoint: "+ totalPoint);
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_userid", fk_userid);
		paraMap.put("totalPrice", totalPrice);
		paraMap.put("totalPoint", totalPoint);
		
		InterOrderDAO odao = new OrderDAO();
		int n = odao.orderlistInsert(paraMap);
		
		if (n == 1) {
//			System.out.println("insert 성공");
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/order/orderSuccess.jsp");
		}
		else {
			System.out.println("error");
			super.setRedirect(true);
			super.setViewPage(request.getContextPath() + "/main/content2.up");
		}
		
	}
	
}
