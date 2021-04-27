package order.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class GoPaymentAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String lastpay_price = request.getParameter("lastpay_price");
		// System.out.println("lastPayPrice => " + lastpay_price);
		request.setAttribute("lastpay_price", lastpay_price);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/order/paymentGateway.jsp");
	}

}
