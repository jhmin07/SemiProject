package board.controller;

import java.util.*;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import QA.model.InterQACommentDAO;
import QA.model.QACommentDAO;
import QA.model.QACommentVO;
import admin.model.AdminVO;
import common.controller.AbstractController;
import common.controller.InterCommand;
import notice.model.InterNoticeDAO;
import notice.model.NoticeDAO;
import notice.model.NoticeVO;

public class CommentModiSubmitAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		

		HttpSession session = request.getSession();

		AdminVO adId = (AdminVO) session.getAttribute("loginadmin");

		if(adId.getAdId() !=null ) {

            // 새로운 제품 등록시 form 태그에서 입력한 값들을 얻어오기 
            String contents = request.getParameter("modiContent");
            String addno = request.getParameter("addno");
           
            
            
         // !!!! 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어코드) 작성하기 !!!! // 
            // 아래처럼 하면 <>가 태그가 아니라 걍 부등호로 인식된다.
            contents = contents.replaceAll("<", "&lt;");
            contents = contents.replaceAll(">", "&gt;");

            
            contents = contents.replaceAll("\r\n", "<br>");
            
            InterQACommentDAO qacdao = new QACommentDAO();
            String adminId = adId.getAdId();
    		request.setAttribute("adminId", adminId);
            
    		
    		QACommentVO qacvo = new QACommentVO();
    		qacvo.setAddno(Integer.parseInt(addno));
    		qacvo.setAddSubject(contents);
    		// tbl_product 테이블에 공지사항 insert 하기
    		InterQACommentDAO qadao = new QACommentDAO();
    		int QAno = qadao.getQAno(addno);
			int n = qacdao.commentUpdate(qacvo);

	        String message = "";
	        String loc = "";
            
            if(n==1) {
               message = "댓글 수정 성공!!";
               loc = request.getContextPath()+"/qaOneDetail.up?qaNo="+QAno;
            }
            else {
               message = "댓글 수정 실패!!";
               loc = request.getContextPath()+"/board/boardQA.up";
            }
            
            request.setAttribute("message", message);
            request.setAttribute("loc", loc);
            
            super.setViewPage("/WEB-INF/msg.jsp");
			
			 } 
		else { String message = "관리자만 접근이 가능합니다."; String loc =
			  "javascript:history.back()";
			  
			 request.setAttribute("message", message); request.setAttribute("loc", loc);
			 
			 super.setRedirect(false); 
			 super.setViewPage("/WEB-INF/msg.jsp");
			 

		}
	}
}
