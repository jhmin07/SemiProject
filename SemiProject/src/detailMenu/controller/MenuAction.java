package detailMenu.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import myshop.model.*;

public class MenuAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 카테고리 목록을 조회해오기
		super.getCategoryList(request);
		
		String cnum = request.getParameter("cnum"); // 카테고리번호
		String decode = request.getParameter("decode"); // 세부 카테고리번호
		request.setAttribute("cnum", cnum);
		
		InterProductDAO pdao = new ProductDAO();
		
		//세부카테고리 목록 조회해오기
		List<DetailCategoryVO> detailList = pdao.selectdetailList(cnum);
		request.setAttribute("detailList", detailList);
				
		// *** 세부 카테고리번호에 해당하는 제품들을 페이징 처리하여 보여주기 *** //
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if(currentShowPageNo == null) {
			currentShowPageNo="1";
		}
		
		try {
			Integer.parseInt(currentShowPageNo);
		}catch(Exception e) {
			currentShowPageNo="1";
		}
		
		Map<String,String> paraMap = new HashMap<>();
		paraMap.put("decode", decode);
		paraMap.put("currentShowPageNo", currentShowPageNo);
		
		
		// 특정 카테고리에 속하는 제품들을 일반적인 페이징 처리하여 조회(select)해오기 
		List<ProductVO> productList = pdao.selectProductByCategory(paraMap);
		//System.out.println(paraMap);
		request.setAttribute("productList", productList);
		
		// **** ========= 페이지바 만들기 ========= **** //
	    		  
	      //  페이지바를 만들기 위해서 특정카테고리의 제품개수에 대한 총페이지수 알아오기(select)
		  int totalPage = pdao.getTotalPage(decode);
		  
		  // System.out.println("~~~ 확인용 totalPage : "+totalPage);		  
		  
		  String pageBar = "";
		  
		  int blockSize = 8;
		// blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다.
		  
		  int loop = 1;
		// loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(지금은 8개)까지만 증가하는 용도이다. 
		  
		  int pageNo = 0;
		// pageNo 는 페이지바에서 보여지는 첫번째 번호이다.
		  
		// !!!! 다음은 pageNo 를 구하는 공식이다. !!!! // 
	      pageNo = ( ( Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1; 
	      int currentN = Integer.parseInt(currentShowPageNo);
	      
	      // **** [맨처음][이전] 만들기 **** //
	      pageBar += "&nbsp;<a class='pagebar' href='menu.up?cnum="+cnum+"&decode="+decode+"&currentShowPageNo=1'>&laquo;</a>&nbsp;"; 
	      //pageBar += "&nbsp;<a class='pagebar' href='menu.up?cnum="+cnum+"&decode="+decode+"&currentShowPageNo="+(currentN-1)+"'>&laquo;</a>&nbsp;";


	      while( !(loop-0.9 > (double)((double)totalPage/8))) {
	         
	         if( pageNo == Integer.parseInt(currentShowPageNo) ) {
	            pageBar += "&nbsp;<span style='border:solid 1px gray; color:red; padding: 2px 4px;'>"+pageNo+"</span>&nbsp;"; 
	         }
	         else {
	            pageBar += "&nbsp;<a class='pagebar' href='menu.up?cnum="+cnum+"&decode="+decode+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a>&nbsp;";    
	         }
	         
	         loop++;    // 1 2 3 4 5 6 7 8 9 10 
	         
	         pageNo++;  //  1  2  3  4  5  6  7  8  9 10
	                    // 11 12 13 14 15 16 17 18 19 20
	                    // 21 
	      }// end of while----------------------------------------------
	      
	      // **** [다음][마지막] 만들기 **** //	     
          //pageBar += "&nbsp;<a class='pagebar' href='menu.up?cnum="+cnum+"&decode="+decode+"&currentShowPageNo="+(currentN+1)+"'>&raquo;</a>&nbsp;"; 
          pageBar += "&nbsp;<a class='pagebar' href='menu.up?cnum="+cnum+"&decode="+decode+"&currentShowPageNo="+(pageNo-1)+"'>&raquo;</a>&nbsp;";
	      
	      
	      
	      request.setAttribute("pageBar", pageBar);
	      
		  // super.setRedirect(false);
		  super.setViewPage("/WEB-INF/detailMenu/detailMenu.jsp");
	}
		
		

		
	}

