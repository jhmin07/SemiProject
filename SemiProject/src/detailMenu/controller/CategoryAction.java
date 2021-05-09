package detailMenu.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import myshop.model.*;


public class CategoryAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		super.goBackURL(request);
		
		//카테고리 목록을 조회해오기
		super.getCategoryList(request);
		
		String cnum = request.getParameter("cnum"); // 카테고리번호
		
		request.setAttribute("cnum", cnum);
		
		InterProductDAO pdao = new ProductDAO();
				
		//세부카테고리 목록 조회해오기
		List<DetailCategoryVO> detailList = pdao.selectdetailList(cnum);
		request.setAttribute("detailList", detailList);
		
		// super.setRedirect(false);
		super.setViewPage("/WEB-INF/detailMenu/detailMain.jsp");
	}

	
	
	
	
	
}
