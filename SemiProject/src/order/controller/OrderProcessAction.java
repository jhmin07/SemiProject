package order.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import order.model.InterOrderDAO;
import order.model.OrderDAO;

public class OrderProcessAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		InterOrderDAO odao = new OrderDAO();
		
		// == 주문내역 테이블에 주문 정보 삽입하기(insert) 과정 == //
		String fk_userid = request.getParameter("fk_userid");
		String totalPrice = request.getParameter("totalPrice");
		String totalPoint = request.getParameter("totalPoint");
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_userid", fk_userid);
		paraMap.put("totalPrice", totalPrice);
		paraMap.put("totalPoint", totalPoint);
		
		int n = odao.orderlistInsert(paraMap); // 주문내역 테이블에 정보 삽입
		/* autoCommit(false); 로 해야됨 */
		
		// == 주문상세내역 테이블에 {주문코드,제품번호,주문량,주문가격,배송상태,배송일자} 삽입하기(insert) == //
//		int m = odao.orderDetailInsert();
		
		// == 배송지정보 테이블에 {주문코드,우편번호,주소,상세주소,주소참고항목,수취인,수취인연락처,배송메세지} 삽입하기(insert) == //
//		int l = odao.deliverInfoInsert();
		
		// 
		if (n == 1) {
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
