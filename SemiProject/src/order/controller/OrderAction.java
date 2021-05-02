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

public class OrderAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 회원으로 로그인 되어있는 경우만 접근 가능하도록
//		if (checkLogin(request)) {
			List<Map<String, String>> mapList = new ArrayList<>();

			// 임의로 값 설정한 부분. 장바구니 페이지에서 아래와 같은 형태로 값을 받아오면 되나싶음?
			String image = "table0";
			String prodname = "책상";
			String prodprice = "10000";
			String prodcnt = "1";
			String prodpoint = String.valueOf(Integer.parseInt(prodprice) * 0.01);
			String delivtype = "기본배송";
			String delivprice = "[조건]";
			String prodsum = String.valueOf(Integer.parseInt(prodprice) * Integer.parseInt(prodcnt));

			for (int i = 1; i <= 2; i++) {
				Map<String, String> map = new HashMap<>();

				map.put("image", image + i);
				map.put("prodname", prodname);
				map.put("prodprice", prodprice);
				map.put("prodcnt", prodcnt);
				map.put("prodpoint", prodpoint);
				map.put("delivtype", delivtype);
				map.put("delivprice", delivprice);
				map.put("prodsum", prodsum);

				mapList.add(map);
			}

			request.setAttribute("mapList", mapList);
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/order/order.jsp");

//		} else { // 회원으로 로그인 안 한 경우
//			String message = "로그인 후 이용하세요!";
//			String loc = "/WEB-INF/member/login.jsp";
//
//			request.setAttribute("message", message);
//			request.setAttribute("loc", loc);
//
//			// super.setRedirect(false);
//			super.setViewPage("/WEB-INF/msg.jsp");
//		}

	}

}
