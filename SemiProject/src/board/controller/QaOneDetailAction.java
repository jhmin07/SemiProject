package board.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import QA.model.InterQADAO;
import QA.model.QADAO;
import QA.model.QAVO;
import common.controller.AbstractController;
public class QaOneDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	/*	// == 관리자(admin)로 로그인 했을 때만 조회가 가능하도록 한다. == //
				HttpSession session = request.getSession();
				MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
				
				if( loginuser!=null && "admin".equals(loginuser.getUserid()) ) {
					// 관리자(admin)로 로그인 했을 경우
				 */
					String qaNo = request.getParameter("qaNo");
					InterQADAO qdao = new QADAO();
					QAVO qvo = qdao.qaOneDetail(qaNo);
					
					System.out.println(qvo.getFk_userid());
					
					request.setAttribute("qvo", qvo);
					
					/////////////////////////////////////////////////
					// *** 현재페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기
					String goBackURL = request.getParameter("goBackURL");
					
					
					request.setAttribute("goBackURL", goBackURL);
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/board/QANoticeDetail.jsp");
				/*}
				else {
					// 로그인을 안한 경우 또는 일반사용자로 로그인 한 경우
					
					 String message = "관리자만 접근이 가능합니다.";
			         String loc = "javascript:history.back()";
			         
			         request.setAttribute("message", message);
			         request.setAttribute("loc", loc);
			         
			      // super.setRedirect(false);
			         super.setViewPage("/WEB-INF/msg.jsp");
					
				}*/

	}

}
