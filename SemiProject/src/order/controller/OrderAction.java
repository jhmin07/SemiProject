package order.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.MemberVO;
import myshop.model.InterProductDAO;
import myshop.model.ProductDAO;
import myshop.model.ProductVO;
import order.model.InterOrderDAO;
import order.model.OrderDAO;

public class OrderAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		boolean isLogin = super.checkLogin(request);

		if (!isLogin) { // "바로주문하기가 있기 때문에"
			request.setAttribute("message", "주문하시려먼 먼저 로그인 부터 하세요!!");
			request.setAttribute("loc", "javascript:history.back()");

			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
//		String option_es = "[색상]:red / [크기]: 100x150 (추가요금 +10000원),[조립유무]:무";
		String option_es = "";
		String pnum_es = request.getParameter("pnum_es");
		String oqty_es = request.getParameter("oqty_es");
		String cartno_es = request.getParameter("cartno_es");
		String totalPrice_es= request.getParameter("totalPrice_es");
		String sumtotalPrice = request.getParameter("sumtotalPrice");
		String sumtotalPoint = request.getParameter("sumtotalPoint");
//		System.out.println("cartno_es:"+cartno_es);
		
		List<Map<String, String>> mapList = new ArrayList<>();
		
		// ===== 장바구니에서 넘어왔을 때 ====== //
		if (cartno_es != null) {
			String[] pnumArr = pnum_es.split(",");
			String[] oqtyArr = oqty_es.split(",");
			String[] cartnoArr = cartno_es.split(",");
			String[] totalPriceArr = totalPrice_es.split(",");
			String[] optionArr = option_es.split(",");
			
			InterOrderDAO odao = new OrderDAO();
			
			int length = pnumArr.length;
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			String userid = loginuser.getUserid();
			
			for (int i=0; i<length; i++) {
				Map<String, String> map = new HashMap<>();
				
				map.put("pnum", pnumArr[i]);
				map.put("oqty", oqtyArr[i]);
				map.put("cartno", cartnoArr[i]);
				map.put("option", optionArr[i]);
				
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
			
		}
		else { // ===== 바로 주문하기에서 넘어왔을 때 ====== //
			Map<String, String> map = new HashMap<>();
			
			map.put("pnum", pnum_es);
			map.put("oqty", oqty_es);
			map.put("option", option_es);
			
			InterProductDAO pdao = new ProductDAO();
			
			ProductVO pvo = pdao.selectOneProductByPnum(pnum_es);	// pnum 를 가지고 해당 제품의 정보 가져오기 pnum_es 에 pum 은 하나만 들어있다.
			map.put("pimage1", pvo.getPimage1());
			map.put("pname", pvo.getPname());
			map.put("price", String.valueOf(pvo.getPrice()));
			map.put("saleprice", String.valueOf(pvo.getSaleprice()));
			map.put("point", String.valueOf(pvo.getPoint()));
			map.put("fk_decode", pvo.getFk_decode());
			map.put("totalPrice", totalPrice_es);
			
			mapList.add(map);
		}
		
		request.setAttribute("mapList", mapList);
		
		// 장바구니에서 가져온 값들 다시 모두 전달
		request.setAttribute("pnum_es", pnum_es);
		request.setAttribute("oqty_es", oqty_es);
		request.setAttribute("cartno_es", cartno_es);
		request.setAttribute("option_es", option_es);
		request.setAttribute("totalPrice_es", totalPrice_es);
		request.setAttribute("sumtotalPrice", sumtotalPrice);
		request.setAttribute("sumtotalPoint", sumtotalPoint);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/order/order.jsp");
	}

}
