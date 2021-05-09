package order.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import myshop.model.InterProductDAO;
import myshop.model.ProductDAO;

public class GoCartAction extends AbstractController {

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
	      else {
	    	  // POST 방식이라면
	    	  
	    	// === 로그인 유무 검사하기 === //
	          boolean isLogin = super.checkLogin(request);
	             
	          if(!isLogin) { // 로그인을 하지 않은 상태이라면 
	    
	             // super.goBackURL(request); 
	             // session 에 돌아갈 페이지주소를 "goBackURL" 이라는 키값으로 저장해두었음. 
	                
	             request.setAttribute("message", "장바구니에 담으려면 먼저 로그인 부터 하세요!!");
	             request.setAttribute("loc", "javascript:history.back()");
	                
	          //   super.setRedirect(false);
	             super.setViewPage("/WEB-INF/msg.jsp");
	                
	             return;

	    	  }
	    	  else {

	    		  String optionNo0 = request.getParameter("optionNo0");	 
	    		  String optionNo1 = request.getParameter("optionNo1");	
	    		  String optionNo = optionNo0+","+optionNo1;
	    		  String pnum = request.getParameter("pnum"); // 제품번호
	    		  String odAmount = request.getParameter("odAmount");		// 수량
	    		  // System.out.println("optionNo0 : " + optionNo0);
	    		  // System.out.println("optionNo1 : " + optionNo1);
	    		  // System.out.println("optionNo : " + optionNo);
	    		  // System.out.println(optionNo);
	    		  // System.out.println("시작3");
	    		  // System.out.println(pnum);
	    		  
	    		  InterProductDAO pdao = new ProductDAO();
	    		  
	    		  HttpSession session =  request.getSession();
	    		  MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
	    		  
	    		  int n = pdao.addCart(loginuser.getUserid(), pnum, odAmount, optionNo);
	    		  
	    		  if(n==1) {
	    			  request.setAttribute("message", "장바구니 담기 성공!!");
	                  request.setAttribute("loc", "cartController.up");
	                  // 장바구니 목록보여주기 페이지 이동 
	    		  }
	    		  else {
	    			  request.setAttribute("message", "장바구니 담기 실패!!");
	                  request.setAttribute("loc", "javascript:history.back()");
	    		  }
	    		  
	    		  super.setRedirect(false);
	    		  super.setViewPage("/WEB-INF/msg.jsp");
	    		  
	    		  
	    	  } 
	    	  
	    	  
	      } // ------------------------------------
		
	}

}
