package order.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;

public class CartControllerAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		if(super.checkLogin(request)) {
			// 로그인을 했으면
			String userid = request.getParameter("userid");
			
		}
		
	       Map<String, String> paraMap = new HashMap<>();

	        //hashmap은 map(key,value)로 이뤄져 있고,
	        //key값은 중복이 불가능 하고 value는 중복이 가능하다.
	        //value에 null값도 사용이 가능하다.
	        //전달할 정보가 많을 경우에는 HashMap<>을 사용하는 것이 좋다.
	        //장바구니에 담을 값들이 많기 때문에 여기선 HashMap<>를 사용한다.
	                

	        String userid = request.getParameter("userid");
	        
	       


		
	}

}
