package board.controller;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import admin.model.AdminVO;
import common.controller.AbstractController;
import member.model.MemberVO;

public class QAWriteAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

		if(loginuser.getUserid() !=null ) {
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/board/QAWrite.jsp");	
		}
		else {

			String message = "Q&A 작성은 로그인 후 이용 가능합니다."; 
			String loc = "javascript:history.back()";
		  
		  request.setAttribute("message", message);
		  request.setAttribute("loc", loc);
		  
		  // super.setRedirect(false);
		  super.setViewPage("/WEB-INF/msg.jsp");
		}
		 
			
	}
}


