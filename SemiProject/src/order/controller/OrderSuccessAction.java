package order.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import order.model.DeliverInfoVO;
import order.model.InterOrderDAO;
import order.model.OrderDAO;

public class OrderSuccessAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		InterOrderDAO odao = new OrderDAO();
		
		// == 배송지정보 테이블에 {주문코드,우편번호,주소,상세주소,주소참고항목,수취인,수취인연락처,배송메세지} 삽입하기(insert) == //
		String recMobile = request.getParameter("recmobile");
		String recPostcode = request.getParameter("recPostcode");
		String recAddress = request.getParameter("recAddress");
		String recDetailaddress = request.getParameter("recDetailaddress");
		String recExtraaddress = request.getParameter("recExtraaddress");
		String dvMessage = request.getParameter("dvMessage");
		
		String ordercode = odao.getOrdercode();
		
		DeliverInfoVO delivo = new DeliverInfoVO();
		delivo.setFk_orderCode(ordercode);
		delivo.setRecMobile(recMobile);
		delivo.setRecPostcode(recPostcode);
		delivo.setRecAddress(recAddress);
		delivo.setRecDetailaddress(recDetailaddress);
		delivo.setRecExtraaddress(recExtraaddress);
		delivo.setDvMessage(dvMessage);
		
		int n = odao.deliverInfoInsert(delivo);
		
		if (n == 1) {
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/order/orderSuccess.jsp");
		}
		else {
			System.out.println("error");
			request.setAttribute("message", "장바구니 담기 실패!!");
			request.setAttribute("loc", "javascript:history.back()");
			
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
	}

}
