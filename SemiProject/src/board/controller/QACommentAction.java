package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import QA.model.InterQACommentDAO;
import QA.model.InterQADAO;
import QA.model.QACommentDAO;
import QA.model.QACommentVO;
import QA.model.QADAO;
import QA.model.QAVO;
import admin.model.AdminVO;
import common.controller.AbstractController;
import member.model.MemberVO;
import notice.model.InterNoticeDAO;
import notice.model.NoticeDAO;
import notice.model.NoticeVO;

public class QACommentAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		AdminVO adId = (AdminVO) session.getAttribute("loginadmin");
		
        String message = "";
        String loc = "";
		
		if(adId.getAdId() !=null ) {
            String QAComment = request.getParameter("QAComment");
            String qaNo = request.getParameter("qaNo");
			String adminId = adId.getAdId();
			
			QAComment = QAComment.replaceAll("<", "&lt;");
			QAComment = QAComment.replaceAll(">", "&gt;");

			QAComment = QAComment.replaceAll("\r\n", "<br>");
			
			
			InterQACommentDAO qcdao = new QACommentDAO();
            
			QACommentVO qcvo = new QACommentVO();
    		
			qcvo.setAddSubject(QAComment);
			qcvo.setFk_qaNo(Integer.parseInt(qaNo));
			qcvo.setWriter(adminId);

    		// 댓글 DB에 넣기
            int n = qcdao.QACommentInsert(qcvo);
			
			
		if(n==1) {
           message = "Q&A 댓글 등록 성공!!";
           loc = request.getContextPath()+"/board/qaOneDetail.up?qaNo="+qaNo;
        }
        else {
           message = "Q&A 댓글등록 실패!!";
           loc = request.getContextPath()+"/board/qaOneDetail.up?qaNo="+qaNo;
        }
        
        request.setAttribute("message", message);
        request.setAttribute("loc", loc);
        
        super.setViewPage("/WEB-INF/msg.jsp");

			
		}
		else {

			message = "Q&A 댓글 작성은 관리자만 가능합니다."; 
			loc = "javascript:history.back()";
		  
		  request.setAttribute("message", message);
		  request.setAttribute("loc", loc);
		  
		  // super.setRedirect(false);
		  super.setViewPage("/WEB-INF/msg.jsp");
		}

	}

}
