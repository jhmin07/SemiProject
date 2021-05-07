package order.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import myshop.model.ProductVO;
import order.model.InterOrderDAO;
import order.model.OrderDAO;

public class OrderAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		boolean isLogin = super.checkLogin(request);

//		if (!isLogin) { // "바로주문하기가 있기 때문에"
//			request.setAttribute("message", "주문하시려먼 먼저 로그인 부터 하세요!!");
//			request.setAttribute("loc", "javascript:history.back()");
//
//			// super.setRedirect(false);
//			super.setViewPage("/WEB-INF/msg.jsp");
//			return;
//		}
		
//		String pnum_es = request.getParameter("pnum_es");
//		String oqty_es = request.getParameter("oqty_es");
//		String cartno_es = request.getParameter("cartno_es");
//		String totalPrice_es= request.getParameter("totalPrice_es");
//		String sumtotalPrice = request.getParameter("sumtotalPrice");
//		String sumtotalPoint = request.getParameter("sumtotalPoint");
		
		String pnum_es = "12,11,10";
		String oqty_es = "1,1,1";
		String cartno_es = "14,15,16";
		String totalPrice_es= "40000,30000,30000";
		String sumtotalPrice = "100000";
		String sumtotalPoint = "100";
		
		String[] pnumArr = pnum_es.split(",");
		String[] oqtyArr = oqty_es.split(",");
		String[] cartnoArr = cartno_es.split(",");
		String[] totalPriceArr = totalPrice_es.split(",");
		
		InterOrderDAO odao = new OrderDAO();
		
		List<Map<String, String>> mapList = new ArrayList<>();
		int length = pnumArr.length;
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		String userid = loginuser.getUserid();
		
		for (int i=0; i<length; i++) {
			Map<String, String> map = new HashMap<>();
			
			map.put("pnum", pnumArr[i]);
			map.put("oqty", oqtyArr[i]);
			map.put("cartno", cartnoArr[i]);
			
			ProductVO pvo = odao.getProdInfo(userid, cartnoArr[i]);	// cartno 를 가지고 해당 제품의 정보 가져오기
			map.put("pimage1", pvo.getPimage1());
			map.put("pname", pvo.getPname());
			map.put("price", String.valueOf(pvo.getPrice()));
			map.put("saleprice", String.valueOf(pvo.getSaleprice()));
			map.put("point", String.valueOf(pvo.getPoint()));
			map.put("fk_decode", pvo.getFk_decode());
			map.put("totalPrice", totalPriceArr[i]);
			
			mapList.add(map);
		}
		
		request.setAttribute("mapList", mapList);
		
		// 장바구니에서 가져온 값들 다시 모두 전달
		request.setAttribute("pnum_es", pnum_es);
		request.setAttribute("oqty_es", oqty_es);
		request.setAttribute("cartno_es", cartno_es);
		request.setAttribute("totalPrice_es", totalPrice_es);
		request.setAttribute("sumtotalPrice", sumtotalPrice);
		request.setAttribute("sumtotalPoint", sumtotalPoint);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/order/order.jsp");

	}

}
