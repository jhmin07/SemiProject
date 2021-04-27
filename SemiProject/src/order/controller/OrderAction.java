package order.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class OrderAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		List<Map<String,String>> mapList = new ArrayList<>(); 
		
		String image = "table0";
		String prodname = "책상";
		String prodprice = "10000";
		String prodcnt = "1";
		String prodpoint = String.valueOf(Integer.parseInt(prodprice)*0.01);
		String delivtype = "기본배송";
		String delivprice = "[조건]"; 
		String prodsum = String.valueOf(Integer.parseInt(prodprice)* Integer.parseInt(prodcnt));
		
		for (int i=1; i<=2; i++) {
			Map<String,String> map = new HashMap<>();
			
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
	}

}
