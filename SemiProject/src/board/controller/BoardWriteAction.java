package board.controller;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import admin.model.AdminVO;
import common.controller.AbstractController;

public class BoardWriteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		AdminVO loginadmin = (AdminVO) session.getAttribute("loginadmin");
	    
		if(loginadmin.getAdId() !=null ) {
				
		      //   super.setRedirect(false);
		         super.setViewPage("/WEB-INF/board/boardWrite.jsp");	
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


