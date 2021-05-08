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
		String recName = request.getParameter("recName");
		String recMobile = request.getParameter("recMobile");
		String recPostcode = request.getParameter("recPostcode");
		String recAddress = request.getParameter("recAddress");
		String recDetailaddress = request.getParameter("recDetailAddress");
		String recExtraaddress = request.getParameter("recExtraAddress");
		String dvMessage = request.getParameter("dvMessage");
		String ordercode = request.getParameter("ordercode");
		
//		System.out.println("ordercode: "+ordercode +"recMobile"+recMobile);
		
		DeliverInfoVO delivo = new DeliverInfoVO();
		delivo.setRecName(recName);
		delivo.setFk_orderCode(ordercode);
		delivo.setRecMobile(recMobile);
		delivo.setRecPostcode(recPostcode);
		delivo.setRecAddress(recAddress);
		delivo.setRecDetailaddress(recDetailaddress);
		delivo.setRecExtraaddress(recExtraaddress);
		delivo.setDvMessage(dvMessage);
		
		int n = odao.deliverInfoInsert(delivo);
		
		// 주문메세지 받아오고 넘기기
		String odrmsg = request.getParameter("odrmsg");
		request.setAttribute("odrmsg", odrmsg);
		
		// 주문 결제 금액 넘기기
		request.setAttribute("sumtotalPrice", request.getParameter("sumtotalPrice"));
		
		if (n == 1) {
			request.setAttribute("delivo", delivo);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/order/orderSuccess.jsp");
		}
		else {
			System.out.println("error");
			request.setAttribute("message", "주문 실패!!");
			request.setAttribute("loc", "javascript:history.back()");
			
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
	}

}
