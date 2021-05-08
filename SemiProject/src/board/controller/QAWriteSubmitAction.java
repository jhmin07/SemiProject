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

public class QAWriteSubmitAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		
		
            // 새로운 제품 등록시 form 태그에서 입력한 값들을 얻어오기 
            String QATitle = request.getParameter("QATitle");
            String QAContent = request.getParameter("QAContent");
            MemberVO loginuser =  (MemberVO) session.getAttribute("loginuser");
            String QAWriter = loginuser.getUserid();
            String QAPwd = request.getParameter("QAPwd");
            
 
            System.out.println("asfsdf");
            
         // !!!! 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어코드) 작성하기 !!!! // 
            // 아래처럼 하면 <>가 태그가 아니라 걍 부등호로 인식된다.
            QATitle = QATitle.replaceAll("<", "&lt;");
            QATitle = QATitle.replaceAll(">", "&gt;");
            QAContent = QAContent.replaceAll("<", "&lt;");
            QAContent = QAContent.replaceAll(">", "&gt;");
            QAPwd = QAPwd.replaceAll("<", "&lt;");
            QAPwd = QAPwd.replaceAll(">", "&gt;");

            
            QATitle = QATitle.replaceAll("\r\n", "<br>");
            QAContent = QAContent.replaceAll("\r\n", "<br>");
            QAPwd = QAPwd.replaceAll("\r\n", "<br>");
            
            InterQADAO qdao = new QADAO();
    		request.setAttribute("QAWriter", QAWriter);
            

    		
    		QAVO qvo = new QAVO();
    		System.out.println("QAWriter=> "+QAWriter);
    		qvo.setQaTitle(QATitle);
    		qvo.setQaContent(QAContent);
    		qvo.setFk_userid(QAWriter);
    		qvo.setQaPwd(QAPwd);
    		// tbl_qaboard 테이블에 Q&A insert 하기
    		int qaNo = qdao.getQAno(qvo);
 	        
    		int n = qdao.QAInsert(qvo, qaNo);

	        String message = "";
	        String loc = "";
            
            if(n==1) {
               message = "Q&A등록 성공!!";
               loc = request.getContextPath()+"/board/qaOneDetail.up?qaNo="+qaNo;
            }
            else {
               message = "Q&A등록 실패!!";
               loc = request.getContextPath()+"/board/boardQA.up";
            }
            
            request.setAttribute("message", message);
            request.setAttribute("loc", loc);
            
            super.setViewPage("/WEB-INF/msg.jsp");;
			
			 } 
	

}
