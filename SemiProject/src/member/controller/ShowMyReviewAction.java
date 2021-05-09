package member.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;
import myshop.model.InterProductDAO;
import myshop.model.ProductDAO;
import myshop.model.ReviewVO;
import order.model.InterOrderDAO;
import order.model.OrderDAO;
import order.model.OrderDetailVO;

public class ShowMyReviewAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		super.goBackURL(request);
		
		// == 로그인을 했을 때만 조회가 가능하도록 한다.		
				boolean isLogin = super.checkLogin(request);
				
				if(!isLogin) {
					// 로그인을 안했을 경우
					request.setAttribute("message", "리뷰리스트를 보려면 먼저 로그인하세요!!");
					request.setAttribute("loc", "/SemiProject/member/login.up");
					
				//	super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
					return;
				}
				else {
					// 로그인을 한 경우
					
					HttpSession session = request.getSession();
					MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
					
					InterMemberDAO mdao = new MemberDAO();
					
					// 리뷰와 상품조회
					List<ReviewVO> review = mdao.getMyReviewList(loginuser.getUserid());
					request.setAttribute("review", review);
					
					
					
				//	super.setRedirect(false);
					super.setViewPage("/WEB-INF/member/MyReviewList.jsp");
				}
		
	}

}
