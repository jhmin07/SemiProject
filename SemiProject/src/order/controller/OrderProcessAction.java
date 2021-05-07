package order.controller;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.MemberVO;
import order.model.DeliverInfoVO;
import order.model.InterOrderDAO;
import order.model.OderDetailVO;
import order.model.OrderDAO;

public class OrderProcessAction extends AbstractController {
	
	InterOrderDAO odao = new OrderDAO();
	
	// 전표 만드는 함수
	private String getOrdercode() throws SQLException {
		
		// 전표(주문코드) 형식 : 날짜+sequence  20210504-1
		
		// 날짜 생성
		Date now = new Date();
		SimpleDateFormat smdatefm = new SimpleDateFormat("yyyyMMdd");
		String today = smdatefm.format(now);
		
		String ordercode = odao.getOrdercode(); // 주문코드 seq_tbl_order_ordercode.nextval 값 가져오기

		return today+"-"+ordercode;
	}
   
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String pnum_es = request.getParameter("pnum_es");
		String oqty_es = request.getParameter("oqty_es");
		String cartno_es = request.getParameter("cartno_es");
		String totalPrice_es= request.getParameter("totalPrice_es");
		String sumtotalPrice = request.getParameter("sumtotalPrice");
		String sumtotalPoint = request.getParameter("sumtotalPoint");		
//		System.out.println("~~~~ 확인용 pnum: " + pnum_es + ", oqty: " + oqty_es + ", totalPrice: " + totalPrice_es);
		
		JSONObject jsonObj = new JSONObject();
		String json = "";
		
		// ***** 장바구니에서 주문하기로 넘어왔을 때 ***** // 
		if (pnum_es != null && oqty_es != null && cartno_es != null 
				&& totalPrice_es != null && sumtotalPrice != null && sumtotalPoint != null) {
			
			Map<String, Object> paraMap = new HashMap<>();
			
			/* autoCommit(false); 로 진행되어야 함. */
			
			// == 주문내역 테이블에 insert 할 것들 == //
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
//			paraMap.put("fk_userid", loginuser.getUserid());
			paraMap.put("fk_userid", "jeonyj");
			
			String ordercode = getOrdercode();
			paraMap.put("ordercode", ordercode);
			
			paraMap.put("sumtotalPrice", sumtotalPrice);
			paraMap.put("sumtotalPoint", sumtotalPoint);
			

			// == 주문상세내역 테이블에 {주문코드,제품번호,주문량,주문가격,배송상태,배송일자,옵션} insert 할 것들 == //
			String[] pnumArr = pnum_es.split(",");
			String[] oqtyArr = oqty_es.split(",");
			String[] totalPriceArr = totalPrice_es.split(",");
			
			paraMap.put("pnumArr", pnumArr);
			paraMap.put("oqtyArr", oqtyArr);
			paraMap.put("totalPriceArr", totalPriceArr);
			
			
			// == 장바구니 테이블에 주문한 상품들 delete 할 것들 == //
			paraMap.put("cartno_es", cartno_es);
			
			
			int isSuccess = odao.orderInsertProcess(paraMap);
			if (isSuccess == 1) {
				jsonObj.put("isSuccess", isSuccess);
				
				json = jsonObj.toString();
				// 주문자 정보(포인트 증가/감소) 업데이트하기
			}
			else {
				System.out.println("실패!!");
			}
			
		}
		else if (pnum_es != null && oqty_es != null && cartno_es == null 
				&& totalPrice_es != null && sumtotalPrice != null && sumtotalPoint != null) {
			
		}
		
		json = jsonObj.toString();
		request.setAttribute("json", json);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/jsonview.jsp");
//		
//		int n = odao.orderlistInsert(paraMap); // 주문내역 테이블에 정보 삽입
//		/* autoCommit(false); 로 해야됨 */
//		
//		// == 주문상세내역 테이블에 {주문코드,제품번호,주문량,주문가격,배송상태,배송일자} 삽입하기(insert) == //
////		int m = odao.orderDetailInsert();
//	
//		
//		// == 배송지정보 테이블에 {주문코드,우편번호,주소,상세주소,주소참고항목,수취인,수취인연락처,배송메세지} 삽입하기(insert) == //
//		String recMobile = request.getParameter("recmobile");
//		String recPostcode = request.getParameter("recPostcode");
//		String recAddress = request.getParameter("recAddress");
//		String recDetailaddress = request.getParameter("recDetailaddress");
//		String recExtraaddress = request.getParameter("recExtraaddress");
//		String dvMessage = request.getParameter("dvMessage");
//		
//		DeliverInfoVO delivo = new DeliverInfoVO();
////		delivo.setFk_orderCode("10"); test
//		delivo.setFk_orderCode(ordercode);
//		delivo.setRecMobile(recMobile);
//		delivo.setRecPostcode(recPostcode);
//		delivo.setRecAddress(recAddress);
//		delivo.setRecDetailaddress(recDetailaddress);
//		delivo.setRecExtraaddress(recExtraaddress);
//		delivo.setDvMessage(dvMessage);
//		
//		int l = odao.deliverInfoInsert(delivo);
//		
//		// 
//		if (l == 1) {
//			super.setRedirect(false);
//			super.setViewPage("/WEB-INF/order/orderSuccess.jsp");
//		}
//		else {
//			System.out.println("error");
//			super.setRedirect(true);
//			super.setViewPage(request.getContextPath() + "/main/content2.up");
//		}
//		
	}
	
}
