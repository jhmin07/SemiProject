package myshop.controller;

import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;
import my.util.MyUtil;
import myshop.model.InterProductDAO;
import myshop.model.ProductDAO;
import myshop.model.ReviewVO;

public class ReviewRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
        
		
		
		String contents = request.getParameter("contents");
		String fk_userid = request.getParameter("fk_userid");
		String fk_pnum = request.getParameter("fk_pnum");
		String review_like = request.getParameter("star");
		//System.out.println("별"+review_like);
		
		// 크로스 사이트 스크립트 공격에 대응하는 안전한 코드 (시큐어 코드 )작성하기
		contents = MyUtil.secureCode(contents);
		
		contents = contents.replaceAll("\r\n", "<br>");
		
		HttpSession session = request.getSession();
        MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
        
        InterMemberDAO mdao = new MemberDAO();
        boolean bool = mdao.isBuy(loginuser.getUserid(), fk_pnum);
        
        if(bool) {

    		ReviewVO reviewsvo = new ReviewVO();
    		reviewsvo.setFk_userid(fk_userid);
    		reviewsvo.setFk_pnum(Integer.parseInt(fk_pnum));
    		reviewsvo.setReviewSubject(contents);
    		reviewsvo.setReview_like(Integer.parseInt(review_like));
    		
    		InterProductDAO pdao = new ProductDAO();
    		
    		int n = 0;
    		
    		try {
    			
    			n = pdao.addComent(reviewsvo);
    			
    		
    		} catch(SQLIntegrityConstraintViolationException e) { // 제약조건에 위배된 경우 (동일한 제품에 대하여 동일한 회원이 제품후기를 2번 쓴 경우 unique 제약에 위배됨)
    	         e.printStackTrace();
    	         n = -1;
    	    } catch (SQLException e) {
    				e.printStackTrace();
    				
    	    }
    		
    		JSONObject jsonObj = new JSONObject();
    		jsonObj.put("n", n);
    		
    		String json = jsonObj.toString(); // 
    		request.setAttribute("json", json);
    		
    		
    		super.setViewPage("/WEB-INF/jsonview.jsp");
        }
        else {
        	
        	 request.setAttribute("message", "상품구매 고객만 후기작성이 가능합니다!!");
	         request.setAttribute("loc", "javascript:history.back()"); 
	         
	      //   super.setRedirect(false);
	         super.setViewPage("/WEB-INF/msg.jsp");
	         return;
        }
		
		
	}

}
