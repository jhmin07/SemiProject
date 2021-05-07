package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import QA.model.InterQACommentDAO;
import QA.model.InterQADAO;
import QA.model.QACommentDAO;
import QA.model.QACommentVO;
import QA.model.QADAO;
import admin.model.AdminVO;
import common.controller.AbstractController;
import member.model.MemberVO;
import notice.model.InterNoticeDAO;
import notice.model.NoticeDAO;
import notice.model.NoticeVO;

public class QADelAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		MemberVO userid = (MemberVO) session.getAttribute("loginuser");
		
        String message = "";
        String loc = "";
		
		if(userid.getUserid() !=null ) {
            String qaNo = request.getParameter("qaNo");
			
			
			InterQADAO qdao = new QADAO();
    		
			int n = qdao.delQA(qaNo);
			
		if(n==1) {
           message = "Q&A 삭제 성공!!";
           loc = request.getContextPath()+"/board/boardQA.up";
        }
        else {
           message = "Q&A 삭제 실패!!";
           loc = request.getContextPath()+"/board/boardQA.up";
        }
        
        request.setAttribute("message", message);
        request.setAttribute("loc", loc);
        
        super.setViewPage("/WEB-INF/msg.jsp");

			
		}
		else {

			message = "Q&A 삭제는 본인만 가능합니다."; 
			loc = "javascript:history.back()";
		  
		  request.setAttribute("message", message);
		  request.setAttribute("loc", loc);
		  
		  // super.setRedirect(false);
		  super.setViewPage("/WEB-INF/msg.jsp");
		}

	}

}
