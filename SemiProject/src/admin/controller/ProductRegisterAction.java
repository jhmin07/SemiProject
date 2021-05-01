package admin.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.controller.AbstractController;
import member.model.MemberVO;
import myshop.model.InterProductDAO;
import myshop.model.ProductDAO;
import myshop.model.ProductVO;
import myshop.model.SpecVO;

public class ProductRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// === 관리자(admin)로 로그인 했을 때만 제품등록이 가능하도록 한다. === //
//		HttpSession session = request.getSession();
//		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
//		
//		if (loginuser != null && "admin".equals(loginuser.getUserid())) { // 관리자(admin)로 로그인 했을 경우
			String method = request.getMethod();
			
			if (!"POST".equalsIgnoreCase(method)) { // GET 이라면
				// 카테고리 목록 조회해오기
				super.getCategoryList(request);
				
				// spec 목록 조회해오기
				InterProductDAO pdao = new ProductDAO();
				List<SpecVO> specList = pdao.selectSpecList();
				request.setAttribute("specList", specList);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/admin/productRegister.jsp");
			}
			else { // POST 일 때
				MultipartRequest mtrequest = null; // 파일을 첨부하는 폼태그라 MultipartRequest 사용
				
				// 1. 첨부되어진 파일을 디스크의 어느경로에 업로드 할 것인지 그 경로를 설정해야 한다.
	            HttpSession session = request.getSession();
	            ServletContext svlCtx = session.getServletContext();
	            
	            System.out.println("svlCtx.getInitParameter => "+ svlCtx.getInitParameter("imagePath"));
	            String imagesDir = svlCtx.getRealPath("/image");
//	            System.out.println("=== 첨부되어지는 이미지 파일이 올라가는 절대경로 imagesDir ==> " + imagesDir);
	            
				try {
					mtrequest = new MultipartRequest(request, imagesDir, 10 * 1024 * 1024, "UTF-8",
							new DefaultFileRenamePolicy());

				} catch (IOException e) {
					request.setAttribute("message", "업로드 되어질 경로가 잘못되었거나 또는 최대용량 10MB를 초과했으므로 파일업로드 실패함!!");
					request.setAttribute("loc", request.getContextPath() + "/admin/productRegister.up");

					super.setViewPage("/WEB-INF/msg.jsp");
					return;
				}

				// 새로운 제품 등록시 form 태그에서 입력한 값들을 얻어오기
				String fk_decode = mtrequest.getParameter("fk_decode");
				String pname = mtrequest.getParameter("pname");
				String pcompany = mtrequest.getParameter("pcompany");

				// 업로드되어진 시스템의 첨부파일 이름을 얻어 오기
				String pimage1 = mtrequest.getFilesystemName("pimage1");
				String pimage2 = mtrequest.getFilesystemName("pimage2");

				String pqty = mtrequest.getParameter("pqty");
				String price = mtrequest.getParameter("price");
				String saleprice = mtrequest.getParameter("saleprice");
				String fk_snum = mtrequest.getParameter("fk_snum");

				// !!!! 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어코드) 작성하기 !!!! //
				String pcontent = mtrequest.getParameter("pcontent");
				pcontent = pcontent.replaceAll("<", "&lt;");
				pcontent = pcontent.replaceAll(">", "&gt;");
				pcontent = pcontent.replaceAll("\r\n", "<br>"); // 입력한 내용에서 엔터는 <br>로 변환시키기

				String point = mtrequest.getParameter("point");
				
				
				InterProductDAO pdao = new ProductDAO();
				int pnum = pdao.getPnumOfProduct(); // 제품번호 채번해오기
	            
	            ProductVO pvo = new ProductVO();
	            pvo.setPnum(pnum);
	            pvo.setFk_decode(fk_decode);
	            pvo.setPname(pname);
	            pvo.setPcompany(pcompany);
	            pvo.setPimage1(pimage1);
	            pvo.setPimage2(pimage2);
	            pvo.setPqty(Integer.parseInt(pqty));
	            pvo.setPrice(Integer.parseInt(price));
	            pvo.setSaleprice(Integer.parseInt(saleprice));
	            pvo.setFk_snum(Integer.parseInt(fk_snum));
	            pvo.setPcontent(pcontent);
	            pvo.setPoint(Integer.parseInt(point));
	            
	            // tbl_product 테이블에 제품정보 insert 하기
	            int n = pdao.productInsert(pvo);
	            
	            // === 추가이미지파일이 있다라면 tbl_product_imagefile 테이블에 제품의 추가이미지 파일명 insert 해주기
	            int m = 1;
	            String str_attachCount = mtrequest.getParameter("attachCount"); // str_attachCount 은 추가이미지 파일 개수이다. ("" "0" ~ "10")
	            int attachCount = 0;
	            
	            if (!"".equals(str_attachCount)) {
	            	attachCount = Integer.parseInt(str_attachCount);
	            }
	            
	            // 첨부파일의 파일명 알아오기
	            for (int i=0; i<attachCount; i++) {
	            	String attachFileName = mtrequest.getFilesystemName("attach"+i);
	            	m = pdao.product_imagefile_Insert(pnum, attachFileName); // pnum 은 위에서 채번해온 제품번호이다.
	            	
	            	if (m == 0) break;
	            }
	            
	            String message = "";
	            String loc = "";
	            
	            if(n*m==1) {
	               message = "제품등록 성공!!";
	               loc = request.getContextPath()+"/shop/mallHome1.up";
	            }
	            else {
	               message = "제품등록 실패!!";
	               loc = request.getContextPath()+"/shop/admin/productRegister.up";
	            }
	            
	            request.setAttribute("message", message);
	            request.setAttribute("loc", loc);
	            
	            super.setViewPage("/WEB-INF/msg.jsp");
			}
//		}
//		else { // 로그인을 안한 경우 또는 일반사용자로 로그인 한 경우  
//	         String message = "관리자만 접근이 가능합니다.";
//	         String loc = "javascript:history.back()";
//	         
//	         request.setAttribute("message", message);
//	         request.setAttribute("loc", loc);
//	         
//	      // super.setRedirect(false);
//	         super.setViewPage("/WEB-INF/msg.jsp");
//		}
	}

}