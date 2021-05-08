package detailMenu.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import myshop.model.DetailCategoryVO;
import myshop.model.InterProductDAO;
import myshop.model.ProductDAO;
import myshop.model.ProductVO;

public class NewhithomeAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {		
				
		HttpSession session = request.getSession();
		
		
		//카테고리 목록을 조회해오기
		super.getCategoryList(request);
		
		String cnum = request.getParameter("cnum"); // 카테고리번호
		String fk_snum = request.getParameter("fk_snum"); // hit, new, best 가져오기
		request.setAttribute("fk_snum", fk_snum);
		
		InterProductDAO pdao = new ProductDAO();
		
		/*//세부카테고리 목록 조회해오기
		List<DetailCategoryVO> detailList = pdao.selectdetailList(cnum);
		request.setAttribute("detailList", detailList);
			*/
		
		List<ProductVO> newHitList = pdao.newHitList(fk_snum);// New 또는 HIT 상품 불러오기		
		
		request.setAttribute("newHitList", newHitList);
		
		// super.setRedirect(false);
		super.setViewPage("/WEB-INF/detailMenu/newHitMain.jsp");
		
	}

}
