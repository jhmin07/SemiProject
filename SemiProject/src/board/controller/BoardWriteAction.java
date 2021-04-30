package board.controller;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import anhyejin.model.InterProductDAO;
import anhyejin.model.ProductDAO;
import common.controller.AbstractController;
import member.model.MemberVO;
import myshop.model.ProductVO;

public class BoardWriteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		
		if(loginuser.getUserid() == "admin" ) {
			MultipartRequest mtrequest = null;
			
			
			// 1. 첨부되어진 파일을 디스크의 어느경로에 업로드 할 것인지 그 경로를 설정해야 한다.
            HttpSession sesssion = request.getSession();
            
            ServletContext svlCtx = sesssion.getServletContext();
            String imagesDir = svlCtx.getRealPath("/image/board/notice");
            
          
            
            // === 파일을 업로드 해준다 ===
            try {
            	mtrequest = new MultipartRequest(request, imagesDir, 10*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
            	// 이렇게 하면 내가 등록한 사진 파일이 imagesDir 경로 파일에 저장된다.
            } catch (Exception e) {
				request.setAttribute("message", "업로드 되어질 경로가 잘못되었거나 또는 최대용량 10MB를 초과했으므로 파일업로드 실패함!!");
	              request.setAttribute("loc", request.getContextPath()+"//board/boardWrite.up"); 
	              
	              super.setViewPage("/WEB-INF/msg.jsp");
	              return;
			}
            
         // === 첨부 이미지 파일을 올렸으니 그 다음으로 제품정보를 (제품명, 정가, 제품수량,...) DB의 tbl_product 테이블에 insert 를 해주어야 한다.  ===
         
            // 새로운 제품 등록시 form 태그에서 입력한 값들을 얻어오기 
            String fk_cnum = mtrequest.getParameter("fk_cnum");
            String pname = mtrequest.getParameter("pname");
            String pcompany = mtrequest.getParameter("pcompany");
            
            
         // 업로드되어진 시스템의 첨부파일 이름을 얻어 올때는 
            // cos.jar 라이브러리에서 제공하는 MultipartRequest 객체의 getFilesystemName("form에서의 첨부파일 name명") 메소드를 사용 한다. 
            // 이때 업로드 된 파일이 없는 경우에는 null을 반환한다.        
            String pimage1 = mtrequest.getFilesystemName("pimage1");
            String pimage2 = mtrequest.getFilesystemName("pimage2"); 
            
            // String origin_pimage1 = mtrequest.getOriginalFileName("pimage1");
            // String origin_pimage2 = mtrequest.getOriginalFileName("pimage2");
            
            // System.out.println(" ~~~ 확인용 pimage1 : " + pimage1);
            // System.out.println(" ~~~ 확인용 pimage2 : " + pimage2);
            
            // System.out.println(" ~~~ 확인용 origin_pimage1 : " + origin_pimage1);
            // System.out.println(" ~~~ 확인용 origin_pimage2 : " + origin_pimage2);
            
            // ~~~ 확인용 pimage1 : 강아지2.png
            // ~~~ 확인용 pimage2 : 쉐보레전면1.jpg
            // ~~~ 확인용 origin_pimage1 : 강아지.png
            // ~~~ 확인용 origin_pimage2 : 쉐보레전면.jpg
            /*
            <<참고>> 
            	※ MultipartRequest 메소드

            --------------------------------------------------
              	반환타입                         설명
            --------------------------------------------------
             Enumeration       getFileNames()
            
                                       업로드 된 파일들에 대한 이름을 Enumeration객체에 String형태로 담아 반환한다. 
                                       이때의 파일 이름이란 클라이언트 사용자에 의해서 선택된 파일의 이름이 아니라, 
                                       개발자가 form의 file타입에 name속성으로 설정한 이름을 말한다. 
                                       만약 업로드 된 파일이 없는 경우엔 비어있는 Enumeration객체를 반환한다.
            
             
             String            getContentType(String name)
            
                                       업로드 된 파일의 컨텐트 타입을 얻어올 수 있다. 
                                       이 정보는 브라우저로부터 제공받는 정보이다. 
                                       이때 업로드 된 파일이 없는 경우에는 null을 반환한다.
            
            
             File              getFile(String name)
            
                                       업로드 된 파일의 File객체를 얻는다. 
                                       우리는 이 객체로부터 파일사이즈 등의 정보를 얻어낼 수 있다. 
                                       이때 업로드 된 파일이 없는 경우에는 null을 반환한다.
            
            
             String            getFilesystemName(String name)
            
                                       시스템에 업로드되어진 파일의 이름을 반환한다.
                                       시스템에 "쉐보레전면.jpg" 가 올라가 있는데 또 사용자가 웹에서 "쉐보레전면.jpg" 파일을 올릴경우 
                             FileRenamePolicy 에 의해 시스템에 업로드되어지는 파일명은 "쉐보레전면1.jpg" 가 되며
                             "쉐보레전면1.jpg" 파일명을 리턴시켜주는 것이  getFilesystemName(String name) 이다.                       
                                       만약에, 이때 업로드 된 파일이 없는 경우에는 null을 반환한다.
            
            
             String            getOriginalFimeName(String name)
            
                                       중복 파일 처리 인터페이스에 의해 변환되기 이전의 파일 이름을 반환한다. 
                                       이때업로드 된 파일이 없는 경우에는 null을 반환한다.
            
            
             String            getParameter(String name)
            
                                       지정한 파라미터의 값을 반환한다. 
                                       이때 전송된 값이 없을 경우에는 null을 반환한다.
            
            
             Enumeration       getParameternames()
            
                                       폼을 통해 전송된 파라미터들의 이름을 Enumeration객체에 String 형태로 담아 반환한다. 
                                       전송된 파라미터가 없을 경우엔 비어있는 Enumeration객체를 반환한다
            
            
             String[]          getparameterValues(String name)
            
                                       동일한 파라미터 이름으로 전송된 값들을 String배열로 반환한다. 
                                       이때 전송된파라미터가 없을 경우엔 null을 반환하게 된다. 
                                       동일한 파라미터가 단 하나만 존재하는 경우에는 하나의 요소를 지닌 배열을 반환하게 된다.    
         */
            
            String pqty = mtrequest.getParameter("pqty");
            String price = mtrequest.getParameter("price");
            String saleprice = mtrequest.getParameter("saleprice");
            String fk_snum = mtrequest.getParameter("fk_snum");
            
         // !!!! 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어코드) 작성하기 !!!! // 
            // 아래처럼 하면 <>가 태그가 아니라 걍 부등호로 인식된다.
            String pcontent = mtrequest.getParameter("pcontent");
            pcontent = pcontent.replaceAll("<", "&lt;");
            pcontent = pcontent.replaceAll("<", "&gt;");

            
            pcontent = pcontent.replaceAll("\r\n", "<br>");
            
            
            String point = mtrequest.getParameter("point");
            
            InterProductDAO pdao = new ProductDAO();
            int pnum = pdao.getPnumOfProduct();
            
            ProductVO pvo = new ProductVO();
            pvo.setPnum(pnum);
            pvo.setFk_cnum(Integer.parseInt(fk_cnum));
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

	         // 추가이미지파일이 있다라면 tbl_product_imagefile 테이블에 제품의 추가이미지 파일명 insert 해주기
            int m = 0;
            String str_attachCount = mtrequest.getParameter("attachCount");
            	// str_attachCount 이 추가이미지 파일의 개수이다. "" ~ "10" 이 들어온다.
            int attachCount = 0;
            
            if(!"".equals(str_attachCount)) {
            	attachCount = Integer.parseInt(str_attachCount);
            	
            }
            // 첨부파일의 파일명 알아오기
            for(int i=0; i<attachCount; i++) {
            	String attachFileName = mtrequest.getFilesystemName("attach"+i);
            	m = pdao.product_imagefile_Insert(pnum, attachFileName);
            	if(m==0) break;
            } // end of for---------------------------------------------------------------------------
            
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
            
            super.setViewPage("/WEB-INF/msg.jsp");;
		}
		}
		else {
		     String message = "관리자만 접근이 가능합니다.";
	         String loc = "javascript:history.back()";
	         
	         request.setAttribute("message", message);
	         request.setAttribute("loc", loc);
	         
	      //   super.setRedirect(false);
	         super.setViewPage("/WEB-INF/msg.jsp");	
		}

	}

}
