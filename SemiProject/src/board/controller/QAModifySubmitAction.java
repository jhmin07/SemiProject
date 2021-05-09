package board.controller;

import java.util.*;

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

public class QAModifySubmitAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		

		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		 
		if(loginuser.getUserid() !=null ) {
			
            
            // 새로운 제품 등록시 form 태그에서 입력한 값들을 얻어오기 
            String QATitle = request.getParameter("QATitle");
            String QAContent = request.getParameter("QAContent");
            String qaNo = request.getParameter("qaNo");
 
            
            
         // !!!! 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어코드) 작성하기 !!!! // 
            // 아래처럼 하면 <>가 태그가 아니라 걍 부등호로 인식된다.
            QATitle = QATitle.replaceAll("<", "&lt;");
            QATitle = QATitle.replaceAll(">", "&gt;");
            QAContent = QAContent.replaceAll("<", "&lt;");
            QAContent = QATitle.replaceAll(">", "&gt;");

            
            QATitle = QATitle.replaceAll("\r\n", "<br>");
            QAContent = QAContent.replaceAll("\r\n", "<br>");
            
            InterQADAO qdao = new QADAO();
            String userid = loginuser.getUserid();
    		request.setAttribute("userid", userid);
            

    		
    		QAVO qvo = new QAVO();
    		qvo.setQaNo(Integer.parseInt(qaNo));
    		qvo.setQaTitle(QATitle);
    		qvo.setQaContent(QAContent);
    		// tbl_product 테이블에 공지사항 insert 하기
            int n = qdao.QAUpdate(qvo);

	        String message = "";
	        String loc = "";
            
            if(n==1) {
               message = "Q&A 수정 성공!!";
               loc = request.getContextPath()+"/board/qaOneDetail.up?qaNo="+qaNo;
            }
            else {
               message = "Q&A 수정 실패!!";
               loc = request.getContextPath()+"/board/qaOneDetail.up?qaNo="+qaNo;
            }
            
            request.setAttribute("message", message);
            request.setAttribute("loc", loc);
            
            super.setViewPage("/WEB-INF/msg.jsp");
			
			 } 
		else { String message = "글 작성자만 접근이 가능합니다."; String loc =
			  "javascript:history.back()";
			  
			 request.setAttribute("message", message); request.setAttribute("loc", loc);
			 
			 super.setRedirect(false); 
			 super.setViewPage("/WEB-INF/msg.jsp");
			 

		}
	}
}
