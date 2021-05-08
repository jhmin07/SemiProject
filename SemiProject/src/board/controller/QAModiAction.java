package board.controller;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import QA.model.InterQADAO;
import QA.model.QADAO;
import QA.model.QAVO;
import admin.model.AdminVO;
import common.controller.AbstractController;
import member.model.MemberVO;
import notice.model.InterNoticeDAO;
import notice.model.NoticeDAO;
import notice.model.NoticeVO;

public class QAModiAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser.getUserid() !=null ) {
				
		      //   super.setRedirect(false);
		String userid = loginuser.getUserid();
		String qaNo = request.getParameter("qaNo");
		InterQADAO qdao = new QADAO();
		QAVO qvo = new QAVO();
		qvo =  qdao.qaOneDetail(qaNo);

		request.setAttribute("userid", userid);
		request.setAttribute("qvo", qvo);
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/board/QAModi.jsp");	
		
		  }
		else { 
			String message = "본인이 작성한 글만 수정 가능합니다."; 
			String loc = "javascript:history.back()";
		  
		  request.setAttribute("message", message); request.setAttribute("loc", loc);
		  
		  // super.setRedirect(false);
		  super.setViewPage("/WEB-INF/msg.jsp");
		 
		  }
			
	}
}


