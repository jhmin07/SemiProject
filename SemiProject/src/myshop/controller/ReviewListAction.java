package myshop.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;

import myshop.model.InterProductDAO;
import myshop.model.ProductDAO;
import myshop.model.ReviewVO;

public class ReviewListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		 String fk_pnum = request.getParameter("fk_pnum"); //제품번호 
		 //System.out.println(isLogIn);
			
			InterProductDAO pdao = new ProductDAO();
			List<ReviewVO> commentList = pdao.commentList(fk_pnum);
			
			JSONArray jsArr = new JSONArray(); //[]
			if(commentList != null && commentList.size()>0) {
				for(ReviewVO reviewsvo : commentList) {
					JSONObject jsobj = new JSONObject(); // {}
					jsobj.put("contents", reviewsvo.getReviewSubject());
					jsobj.put("name", reviewsvo.getMvo().getName());
					jsobj.put("writeDate", reviewsvo.getReviewRegisterday());
					jsobj.put("fk_userid", reviewsvo.getFk_userid());
					jsobj.put("review_seq", reviewsvo.getReviewNo());
					jsobj.put("star", reviewsvo.getReview_like());
					
					jsArr.put(jsobj);
				}
				
			}
			
			
			String json = jsArr.toString();
			
			
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		 }
		
	


}
