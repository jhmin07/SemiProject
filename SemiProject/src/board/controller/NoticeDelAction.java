package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import QA.model.InterQACommentDAO;
import QA.model.QACommentDAO;
import QA.model.QACommentVO;
import admin.model.AdminVO;
import common.controller.AbstractController;
import notice.model.InterNoticeDAO;
import notice.model.NoticeDAO;
import notice.model.NoticeVO;

public class NoticeDelAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		AdminVO adId = (AdminVO) session.getAttribute("loginadmin");
		
        String message = "";
        String loc = "";
		
		if(adId.getAdId() !=null ) {
            String ctNo = request.getParameter("ctNo");
			
			
			InterNoticeDAO ndao = new NoticeDAO();
    		
			int n = ndao.delNotice(ctNo);
			
		if(n==1) {
           message = "공지사항 삭제 성공!!";
           loc = request.getContextPath()+"/board/board.up";
        }
        else {
           message = "공지사항 삭제 실패!!";
           loc = request.getContextPath()+"/board/board.up";
        }
        
        request.setAttribute("message", message);
        request.setAttribute("loc", loc);
        
        super.setViewPage("/WEB-INF/msg.jsp");

			
		}
		else {

			message = "공지사항 삭제는 관리자만 가능합니다."; 
			loc = "javascript:history.back()";
		  
		  request.setAttribute("message", message);
		  request.setAttribute("loc", loc);
		  
		  // super.setRedirect(false);
		  super.setViewPage("/WEB-INF/msg.jsp");
		}

	}

}
