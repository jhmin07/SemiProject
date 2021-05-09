package order.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class GoPaymentAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String sumtotalPrice = request.getParameter("sumtotalPrice");
		String name = request.getParameter("name");
		request.setAttribute("sumtotalPrice", sumtotalPrice);
		request.setAttribute("name", name);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/order/paymentGateway.jsp");
	}

}
