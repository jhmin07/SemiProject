package detailMenu.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import common.controller.AbstractController;
import myshop.model.InterProductDAO;
import myshop.model.OptionVO;
import myshop.model.ProductDAO;

public class ProductDetailOptionAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// super.goBackURL(request);
		
		String pnum = request.getParameter("pnum");
		String oname = request.getParameter("oname");
		
		InterProductDAO pdao = new ProductDAO();
		
		List<OptionVO> optionList = pdao.selectProductOption(pnum,oname);
		
		JSONArray jsArr = new JSONArray();	
		
		if(optionList != null && optionList.size() > 0 ) {
			
			for(OptionVO optionvo:optionList) {
				
				JSONObject jsonObj = new JSONObject(); // {}
				
				jsonObj.put("ocontents", optionvo.getOcontents());
				jsonObj.put("optionNo", optionvo.getOptionNo());
				
				jsArr.put(jsonObj);				
				
			} // end of for(OptionVO optionvo:optionList) {}			
			
		} // end of if(optionList != null && optionList.size() > 0 ) {}
		
		String json = jsArr.toString(); // 문자열 형태로 변환해줌
		// System.out.println(json);
		// "[{"contents":"제품후기내용물", "name":"작성자이름","writeDate":"작성일자", "userid":"작성자아이디", "review_seq":"제품후기글번호"}]"
		
		request.setAttribute("json", json);
		
		super.setViewPage("/WEB-INF/jsonview.jsp");
		
		
	}

}