package order.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import myshop.model.InterProductDAO;
import myshop.model.ProductDAO;
import order.model.CartDAO;
import order.model.InterCartDAO;

public class CartEditAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getMethod();
	      
	      if(!"POST".equalsIgnoreCase(method)) {
	         // GET 방식이라면
	         
	         String message = "비정상적인 경로로 들어왔습니다";
	         String loc = "javascript:history.back()";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	         super.setViewPage("/WEB-INF/msg.jsp");
	         return;
	      }
	      else if ("POST".equalsIgnoreCase(method) && super.checkLogin(request)) {
	    	  String cartno = request.getParameter("cartNo");
	    	  String oqty = request.getParameter("odAmount");
	          
	    	  InterCartDAO cdao = new CartDAO();
	          
	          // 장바구니 테이블에서 특정제품을 장바구니에서 수량을 변경하기  
	          int n = cdao.updateCart(cartno, oqty);
	          
	          JSONObject jsobj = new JSONObject(); 
	          jsobj.put("n", n);
	          
	          String json = jsobj.toString();
	          
	          request.setAttribute("json", json);
	          
	          super.setRedirect(false);
	          super.setViewPage("/WEB-INF/jsonview.jsp");
	      }
	}

}
